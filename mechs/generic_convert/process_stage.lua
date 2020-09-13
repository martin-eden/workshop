--[[
  Generic data conversion function.

  Receives data table and table record with functions to
  verify (optional), validate (optional) and convert (also optional)
  that data.

  Verify function must return nothing when verification is passed.

  General logic:

    if stage.verify and do_verify
      <<recheck>>
      results = verify_validate(data)
      if results
        -- Verification failed. If <do_validate> flag is set,
        -- validation was applied.
        was_issues = true
        if do_validate
          goto recheck
    if stage.convert
      data = convert(data)

  Returns converted data.
]]

local veridate = request('veridate')

return
  function(data, stage, do_verify, do_validate)
    local was_issues = false
    if do_verify and stage.verify then
      ::recheck::
      was_issues =
        veridate(data, stage.verify, stage.validate, do_validate)
      if was_issues then
        -- print('Was issues.')
        if do_validate and stage.validate then
          -- print('Re-running verification.')
          goto recheck
        end
      end
    end
    if stage.convert and not was_issues then
      data = stage.convert(data)
    end

    return data
  end
