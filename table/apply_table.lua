-- Apply values from another table to our table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

--[[
  Rules structure

    List of records with following structure

    {
      HasA [b] -- value A is present
      HasB [b] -- value B is present
      Action [s] -- string with one of following values
        use_a
        use_b
    }
]]

local use_a_str = 'use_a'
local use_b_str = 'use_b'

--[[
  Return action name considering given inputs and set of rules

  If there is no rule for our condition,
  action is "use_a" -- keep current value.
--]]
local get_action =
  function(has_a, has_b, Rules)
    for _, Rule in ipairs(Rules) do
      local is_same_signature =
        (Rule.HasA == has_a) and (Rule.HasB == has_b)

      if is_same_signature then
        return Rule.Action
      end
    end

    return use_a_str
  end

-- Apply values to table A from table B following list of rules
local apply_table
apply_table =
  function(A, B, Rules)
    local a_type = type(A)
    local b_type = type(B)

    local Keys = {}
    do
      for a_key in pairs(A) do
        Keys[a_key] = true
      end
      for b_key in pairs(B) do
        Keys[b_key] = true
      end
    end

    for key in pairs(Keys) do
      local has_a = not is_nil(A[key])
      local has_b = not is_nil(B[key])

      local a_is_table = has_a and is_table(A[key])
      local b_is_table = has_b and is_table(B[key])

      if a_is_table and b_is_table then
        apply_table(A[key], B[key], Rules)
      else
        local action = get_action(has_a, has_b, Rules)
        if (action == use_a_str) then
        elseif (action == use_b_str) then
          A[key] = B[key]
        end
      end
    end
  end

local check_rule =
  function(Rule)
    local has_a = is_boolean(Rule.HasA)
    local has_b = is_boolean(Rule.HasB)

    local action = Rule.Action
    local is_known_action = (action == use_a_str) or (action == use_b_str)

    return has_a, has_b, is_known_action
  end

local apply_table_root =
  function(A, B, Rules)
    assert_table(A)
    assert_table(B)
    assert_table(Rules)

    -- Assert rules
    for index, Rule in ipairs(Rules) do
      local has_a, has_b, is_known_action = check_rule(Rule)

      if not (has_a and has_b and is_known_action) then
        local err_msg =
          'Unsupported rule at index ' .. tostring(index)

        error(err_msg, 2)
      end
    end

    apply_table(A, B, Rules)
  end

-- Export:
return apply_table_root

--[[
  2026-04-30
]]
