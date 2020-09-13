--[[
  Apply conversion stages to given data.

  Returns processed result.
]]

local process_stage = request('generic_convert.process_stage')

local verify_default = true
local validate_default = true

return
  function(data, stages, do_verify, do_validate)
    do_verify = is_boolean(do_verify) and do_verify or verify_default
    do_validate = is_boolean(do_validate) and do_validate or validate_default
    for _, stage in ipairs(stages) do
      data = process_stage(data, stage, do_verify, do_validate)
    end
    return data
  end
