-- Cyclic array implementation.

local default_params =
  {
    min_idx = 1,
    max_idx = 4,
    overflow_allowed = false,
  }

local override_params = request('^.handy_mechs.override_params')
local create_cyclic_array =
  function(a_params)
    local params = override_params(default_params, a_params)
    assert(params.min_idx <= params.max_idx)

    local min_idx = params.min_idx
    local max_idx = params.max_idx

    local head_idx
    local tail_idx

    local get_length =
      function()
        local result = 0
        if head_idx then
          if (head_idx <= tail_idx) then
            result = tail_idx - head_idx + 1
          else
            result = (max_idx - head_idx + 1) + (tail_idx - min_idx + 1)
          end
        end
        return result
      end

    local get_index =
      function(seq_num)
        local result
        if (seq_num >= 1) and (seq_num <= get_length()) then
          result = head_idx + seq_num - 1
          if (result > max_idx) then
            result = (min_idx + (max_idx - result) - 1)
          end
        end
        return result
      end

    local get_next =
      function(cur_index)
        local result
        result = cur_index + 1
        if (result > max_idx) then
          result = min_idx
        end
        return result
      end

    local get_prev =
      function(cur_index)
        local result
        result = cur_index - 1
        if (result < min_idx) then
          result = max_idx
        end
        return result
      end

    local increase_tail =
      function()
        if not tail_idx then
          head_idx = 1
          tail_idx = 1
        else
          tail_idx = get_next(tail_idx)
          if (tail_idx == head_idx) then
            if not params.overflow_allowed then
              error('Overflow.')
            end
            head_idx = get_next(head_idx)
          end
        end
      end

    local decrease_head =
      function()
        verify_overflow()
        if not head_idx then
          tail_idx = 1
          head_idx = 1
        else
          head_idx = get_prev(head_idx)
          if (head_idx == tail_idx) then
            if not params.overflow_allowed then
              error('Overflow.')
            end
            tail_idx = get_prev(tail_idx)
          end
        end
      end

    local decrease_tail =
      function()
        if tail_idx then
          if (tail_idx == head_idx) then
            tail_idx = nil
            head_idx = nil
          else
            tail_idx = get_prev(tail_idx)
          end
        end
      end

    local increase_head =
      function()
        if head_idx then
          if (head_idx == tail_idx) then
            head_idx = nil
            tail_idx = nil
          else
            head_idx = get_next(head_idx)
          end
        end
      end

    return
      {
        get_length = get_length,
        get_index = get_index,
        increase_head = increase_head,
        decrease_head = decrease_head,
        increase_tail = increase_tail,
        decrease_tail = decrease_tail,

        get_head_idx = function() return head_idx end,
        get_tail_idx = function() return tail_idx end,
        is_empty = function() return (get_length() == 0) end,
        get_params = function() return clone(params) end,
      }
  end

return create_cyclic_array
