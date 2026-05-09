-- For list of ranges and ranges tree resolve that ranges to root's view

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

--[[
  Data structure

    Tree map of Range objects by name part
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local add_list = request('!.concepts.list.add_list')
local select_list_range = request('!.concepts.list.select_range')

local skip_n_read =
  function(Ranges, num_to_skip, num_to_read)
    --[[
      Getting segments for ( Start: 3, Length: 5 ) is
      same as reading 3 units, discarding found segments,
      reading 5 units, returning found segments.
    ]]

    local Result = { }

    local is_reading = false
    local num_to_process = num_to_skip

    local seg_start
    local seg_len

    for idx, Range in ipairs(Ranges) do
      local range_start = Range:GetStart()
      local range_len = Range:GetLength()

      ::process::

      seg_start = range_start
      if (num_to_process < range_len) then
        seg_len = num_to_process
      else
        seg_len = range_len
      end
      num_to_process = num_to_process - seg_len

      if is_reading then
        add_to_list(Result, Range.create(seg_start, seg_len))
      end

      if (num_to_process == 0) then
        if not is_reading then
          num_to_process = num_to_read
          is_reading = true
        else
          break
        end
      end

      -- If range was split then process remained part
      if (seg_len < range_len) then
        range_start = range_start + seg_len
        range_len = range_len - seg_len
        goto process
      end
    end

    return Result
  end

local get_real_ranges
get_real_ranges =
  function(Ranges, NodesPath)
    local Node = NodesPath[#NodesPath]

    local OurRanges = { }

    for idx, Range in ipairs(Ranges) do
      local num_to_skip = Range:GetStart() - 1
      local num_to_read = Range:GetLength()
      local AdjustedRanges =
        skip_n_read(Node.Ranges, num_to_skip, num_to_read)

      add_list(OurRanges, AdjustedRanges)
    end

    if (#NodesPath >= 2) then
      local ParentNodesPath =
        select_list_range(NodesPath, 1, #NodesPath - 1)

      return get_real_ranges(OurRanges, ParentNodesPath)
    end

    return OurRanges
  end

-- Export:
return get_real_ranges

--[[
  I think I should finally come to LISP. But even doing this in Lua is
  infinitely more nice than doing this in C++.
]]

--[[
  2026-05-02
  2026-05-03
  2026-05-06
]]
