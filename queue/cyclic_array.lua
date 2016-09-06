--[[ Cyclic array implementation. ]]--

--[[
  Status: not tested, conceptual complete
  Last mod.: 2015-07-15
--]]

--[[
  This implementations does not deal with any real array (and thus
  not limited by it). It supports indexes where elements should be
  stored. This way to add element <e> in add of queue represented
  by array <A> do following:

    queue.increase_tail()
    A[queue.get_tail()] = e
--]]

local chunk_name = 'cyclic_array'

local default_capacity = 100
local default_overflow_allowed = false
local default_underflow_allowed = false

local create_cyclic_array =
  function(capacity, overflow_allowed)
    local capacity = capacity or default_capacity
    local check_capacity =
      function()
        local condition = (capacity >= 1)
        if not condition then
          error(('bad capacity: %d'):format(capacity), 2)
        end
      end

    local overflow_allowed = overflow_allowed or default_overflow_allowed
    local underflow_allowed = underflow_allowed or default_underflow_allowed

    local head
    local tail
    local first = 1
    local last = first + capacity - 1
    local length = 0

    local check_index =
      function(seq_num)
        local condition = (seq_num >= 1) and (seq_num <= length)
        if not condition then
          error(('index not valid: %d not in (%d, %d)'):format(seq_num, 1, length), 2)
        end
      end

    local get_index =
      function(seq_num)
        check_index(seq_num)
        local result
        result = head + seq_num - 1
        if (result > last) then
          result = (first + (last - result) - 1)
        end
        return result
      end

    local next =
      function(cur_index)
        local result
        result = cur_index + 1
        if (result > last) then
          result = first
        end
        return result
      end

    local prev =
      function(cur_index)
        local result
        result = cur_index - 1
        if (result < first) then
          result = last
        end
        return result
      end

    local update_length =
      function()
        if head and tail then
          if (head <= tail) then
            length = tail - head + 1
          else
            length = (last - head + 1) + (tail - first + 1)
          end
        else
          length = 0
        end
      end

    local check_overflow =
      function()
        local condition = (length < capacity) or overflow_allowed
        if not condition then
          error(('overflow: %d >= %d'):format(length, capacity), 2)
        end
      end

    local check_underflow =
      function()
        local condition = (length > 0) or underflow_allowed
        if not condition then
          error(('underflow: %d <= 0'):format(length), 2)
        end
      end

    local add_at_tail =
      function()
        check_overflow()
        if not tail then
          head = 1
          tail = 1
        else
          tail = next(tail)
          if (tail == head) then
            head = next(head)
          end
        end
        update_length()
      end

    local remove_at_tail =
      function()
        check_underflow()
        if tail then
          if (tail == head) then
            tail = nil
            head = nil
          else
            tail = prev(tail)
          end
          update_length()
        end
      end

    local add_at_head =
      function()
        check_overflow()
        if not head then
          tail = 1
          head = 1
        else
          head = prev(head)
          if (head == tail) then
            tail = prev(tail)
          end
        end
        update_length()
      end

    local remove_at_head =
      function()
        check_underflow()
        if head then
          if (head == tail) then
            head = nil
            tail = nil
          else
            head = next(head)
          end
          update_length()
        end
      end

    return
      {
        get_index = get_index,
        increase_head = remove_at_head,
        decrease_head = add_at_head,
        increase_tail = add_at_tail,
        decrease_tail = remove_at_tail,

        get_head = function() return head end,
        get_tail = function() return tail end,

        is_empty = function() return (length == 0) end,

        get_length = function() return length end,
        get_capacity = function() return array_size end,
        get_overflow_allowed = function() return overflow_allowed end,
        get_underflow_allowed = function() return underflow_allowed end,
        --[[
          Wish to create more generic code like

            table.merge(result, create_getters('head', head, 'tail', ...

          I've done some experiments but failed to create function
          which returns function which returns passed upvalue (not
          value!).
        --]]
      }
  end

tribute(chunk_name, create_cyclic_array)

--[[
2015-06-26
2015-06-29
2015-07-06
2015-07-07
2015-07-15
--]]
