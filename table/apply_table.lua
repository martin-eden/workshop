-- Apply values from another table to our table

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

--[[
  Rules structure

    List of records with following structure

    {
      has_a [b] -- value A is present
      has_b [b] -- value B is present
      action [s] -- action to apply for item in A
        keep -- keep value in A
        replace -- replace value in A
        remove -- remove value in A
    }
]]

local keep_str = 'keep'
local replace_str = 'replace'
local remove_str = 'remove'

--[[
  Return action name considering given inputs and set of rules

  If there is no rule for given condition then keep current value.
--]]
local get_action =
  function(has_a, has_b, rules)
    for _, rule in ipairs(rules) do
      if (rule.has_a == has_a) and (rule.has_b == has_b) then
        return rule.action
      end
    end
    return keep_str
  end

-- Apply values to table A from table B following list of rules
local apply_table
apply_table =
  function(a, b, rules)
    local keys = { }
    do
      for a_key in pairs(a) do
        keys[a_key] = true
      end
      for b_key in pairs(b) do
        keys[b_key] = true
      end
    end

    for key in pairs(keys) do
      local a_key = a[key]
      local b_key = b[key]

      if is_table(a_key) and is_table(b_key) then
        apply_table(a_key, b_key, rules)
      else
        local has_a = not is_nil(a_key)
        local has_b = not is_nil(b_key)

        local action = get_action(has_a, has_b, rules)

        if (action == keep_str) then
          ;
        elseif (action == replace_str) then
          a[key] = b[key]
        elseif (action == remove_str) then
          a[key] = nil
        end
      end
    end
  end

local check_rule =
  function(rule)
    local has_a = is_boolean(rule.has_a)
    local has_b = is_boolean(rule.has_b)

    local action = rule.action
    local is_known_action =
      (action == keep_str) or
      (action == replace_str) or
      (action == remove_str)

    return has_a and has_b and is_known_action
  end

-- Export:
return
  function(a, b, rules)
    assert_table(a)
    assert_table(b)
    assert_table(rules)

    assert(a ~= b)

    -- Assert rules
    for index, rule in ipairs(rules) do
      if not check_rule(rule) then
        error('Unsupported rule.')
      end
    end

    apply_table(a, b, rules)
  end

--[[
  2026 # # #
]]
