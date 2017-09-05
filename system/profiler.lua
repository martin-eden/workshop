--[[
  Q&D lua code profiler.

  Prints to stdout(). Uses _G.debug.

  Basic usage:

    .start()
    [...]
    .stop()

  start() options:
    {
      instructions_per_hook
      print_interval
      measure_interval
      parent_offset
    }

  For additional info see "profiler.txt".
]]

local func_call_count = {}  -- [name] = {[line] = count, total_calls = count}

local parent_offset = 0

local get_first_line = request('^.string.get_first_line')

local update_call_count =
  function()
    local func_name
    local func_line
    local func_info = debug.getinfo(4 + parent_offset, 'nlS')
    func_name = func_info.source
    func_name = get_first_line(func_name) -- or you may got whole chunk from _G.load()
    func_line = func_info.currentline
    func_call_count[func_name] = func_call_count[func_name] or {}
    func_call_count[func_name][func_line] = func_call_count[func_name][func_line] or 0
    func_call_count[func_name][func_line] = func_call_count[func_name][func_line] + 1
    func_call_count[func_name].total_calls = func_call_count[func_name].total_calls or 0
    func_call_count[func_name].total_calls = func_call_count[func_name].total_calls + 1
  end

local get_normalized_runtimes =
  function()
    local normalized_runtimes = new(func_call_count)

    local total_sum = 0
    for func_name, func_lines in pairs(normalized_runtimes) do
      total_sum = total_sum + func_lines.total_calls
    end
    if (total_sum > 0) then
      for func_name, func_lines in pairs(normalized_runtimes) do
        normalized_runtimes[func_name].total_calls =
          normalized_runtimes[func_name].total_calls / total_sum
        for line_num, num_calls in pairs(func_lines) do
          if (line_num ~= 'total_calls') then
            normalized_runtimes[func_name][line_num] =
              num_calls / total_sum / normalized_runtimes[func_name].total_calls
          end
        end
      end
    end

    return normalized_runtimes
  end

local compare_recs =
  function(a, b)
    return (a.value.total_calls > b.value.total_calls)
  end

local compare_line_calls =
  function(a, b)
    return (a.value > b.value)
  end

local max_funcs = 50
local max_lines_per_func = 30
local cum_part_threshold = .8
--[[ .8 means stop printing after printed part sum exceed 80% ]]

local ordered_pass = request('^.table.ordered_pass')

local print_funcs_roster =
  function()
    local normalized_runtimes = get_normalized_runtimes()
    local num_funcs_printed = 0
    local funcs_printed_cum_part = 0
    for func_name, func_lines in ordered_pass(normalized_runtimes, compare_recs) do
      print(('%.2f %s'):format(func_lines.total_calls, func_name))
      local num_printed = 0
      local lines_printed_cum_part = 0
      for line_num, num_calls in ordered_pass(func_lines, compare_line_calls) do
        if (line_num ~= 'total_calls') then
          print(('  %.2f %s'):format(num_calls, line_num))
          num_printed = num_printed + 1
          lines_printed_cum_part = lines_printed_cum_part + num_calls
          if
            (num_printed >= max_lines_per_func) or
            (lines_printed_cum_part >= cum_part_threshold)
          then
            break
          end
        end
      end
      num_funcs_printed = num_funcs_printed + 1
      funcs_printed_cum_part = funcs_printed_cum_part + func_lines.total_calls
      if
        (num_funcs_printed >= max_funcs) or
        (funcs_printed_cum_part >= cum_part_threshold)
      then
        break
      end
    end
  end

local instructions_per_hook = 5e5 + 1

local print_interval = 12
local last_print_time = 0

local measure_interval = .01
local last_measure_time = 0
local num_measurements_done = 0

local num_hook_calls = 0

local cur_time = 0

local do_measurement =
  function()
    update_call_count()
    num_measurements_done = num_measurements_done + 1
    last_measure_time = cur_time
    -- print(debug.traceback())
  end

local print_stats =
  function()
    print(
      'cur_time', cur_time,
      'num_hook_calls', num_hook_calls,
      'num_measurements_done', num_measurements_done,
      'calls_skipped', num_hook_calls - num_measurements_done
    )
    print(
      ('%.2fM instructions / second'):format(
        num_hook_calls /
        1e6 /
        (cur_time - last_print_time) *
        instructions_per_hook
      )
    )
    print_funcs_roster()
    num_hook_calls = 0
    num_measurements_done = 0
    last_print_time = cur_time
  end

local hook_func =
  function(event_name)
    num_hook_calls = num_hook_calls + 1
    cur_time = os.clock()
    if (cur_time - last_measure_time >= measure_interval) then
      do_measurement()
    end
    if (cur_time - last_print_time >= print_interval) then
      print_stats()
    end
  end

local start_profile =
  function(options)
    if is_table(options) then
      instructions_per_hook =
        options.instructions_per_hook or instructions_per_hook
      print_interval =
        options.print_interval or print_interval
      measure_interval =
        options.measure_interval or measure_interval
      parent_offset =
        options.parent_offset or parent_offset
    end
    debug.sethook(hook_func, '', instructions_per_hook)
  end

local stop_profile =
  function()
    debug.sethook()
    print_stats()
  end

return
  {
    start = start_profile,
    stop = stop_profile,
  }
