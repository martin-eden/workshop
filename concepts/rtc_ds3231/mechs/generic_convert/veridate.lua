--[[
  Verify and validate data.

  Validation can be disabled in fourth argument.

  This is verify/validate interaction implementation via coroutines.

  Verificator must return nothing in case of successful verification.
  In case of problems it coroutine.yield(...) with problem details
  in arguments of yield().

  For such verificator validator is assumed that will receive <data>
  table and details from verifier. Validator should change data
  in-place and return nothing.
]]

local co = require('coroutine')

return
  function(data, verificator, validator, do_validate)
    local was_issues = false

    local process_results =
      function(results)
        if (results[2]) then
          was_issues = true
          -- print(table.unpack(results, 2))
          if do_validate then
            validator(data, table.unpack(results, 2))
          end
        end
      end

    local veri_co = co.create(verificator)
    local results = table.pack(co.resume(veri_co, data))
    process_results(results)
    while (co.status(veri_co) ~= 'dead') do
      results = table.pack(co.resume(veri_co))
      process_results(results)
    end

    return was_issues
  end
