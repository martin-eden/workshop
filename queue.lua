local chunk_name = 'queue'

tribute(
  chunk_name,
  {
    create =
      function(capacity)
        local capacity = capacity or math.huge

        local dequeue_arr = request('queue.cyclic_array')(capacity)

        local result =
          {
            get_location = dequeue_arr.get_index,

            get_head = dequeue_arr.get_head,
            get_tail = dequeue_arr.get_tail,

            increase_head = dequeue_arr.increase_head,
            increase_tail = dequeue_arr.increase_tail,
            decrease_head = dequeue_arr.decrease_head,
            decrease_tail = dequeue_arr.decrease_tail,

            is_empty = dequeue_arr.is_empty,
          }

        return result
      end,
  }
)

--[[
  Yes, this code looks silly. The point is that we force queue interface here,
  no matter of implementation details. In case implementation method names
  equal interface method names, tautology occurs.

  If you want to use some concrete interface implementation (with additional
  parameters and tuning options), call it like

    local cyclic_arr_deq = request('queue.cyclic_array')()

  If you agnostic to implementation, use

    local queue = request('queue').create()

--]]
