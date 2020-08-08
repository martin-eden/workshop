--[[
  Generic parse function.

  Gets some <data> token, array of parse <stages> and boolean
  options <do_verify>, <do_validate>. (To enable validation you need
  to enable verification also.)

  Then do some sort of

    for i = 1, n
      data = stages[i].parse(data)

  with adjustments according to verification and validation.
]]

local adv_assert = request('!.system.adv_assert')

return
  function(data, stages, do_verify, do_validate)
    for _, stage in ipairs(stages) do
      if do_verify and stage.verify then
        local result, msg, details = stage.verify(data)
        if not result then
          if do_validate and stage.validate then
            stage.validate(data, details)
            result, msg, details = stage.verify(data)
          end
          adv_assert(result, msg, details)
        end
      end
      if stage.parse then
        data = stage.parse(data)
      end
    end
    return data
  end
