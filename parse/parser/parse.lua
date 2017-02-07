-- Parse/verify given data with given structure

--[[
  This module will do actual parsing or verifying data
  versus given compiled structure.
]]

local mode_handlers =
  {
    ['seq'] = request('modes.seq'),
    ['choice_best'] = request('modes.choice_best'),
    ['choice_first'] = request('modes.choice_first'),
    ['is_not'] = request('modes.is_not'),
    ['optional'] = request('modes.optional'),
    ['repeat'] = request('modes.repeat'),
  }

local verify_only

local quote_string = request('^.^.compile.lua.quote_string')

local debug_print =
  function(struc, s, s_pos, mode, parse_result)
    local struc_str = ''
    if is_string(struc) then
      struc_str = struc
    end
    local struc_name = ''
    if is_table(struc) and struc.name then
      struc_name = struc.name
    end
    print(
      ('debug_print: [%10s] [%10s] [%10s] %7s (%4d) %-12s'):
      format(
        mode,
        type(struc),
        struc_name,
        quote_string(struc_str),
        s_pos,
        quote_string(s:sub(s_pos, s_pos + 3))
      )
    )
  end

local folder = request('folder')
local get_checkpoint = folder.get_checkpoint
local mark = folder.mark
local rollback = folder.rollback

local parse
parse =
  function(struc, s, s_pos)
    local struc_is_table = (type(struc) == 'table')
    local mode = (struc_is_table and struc.mode) or 'seq'
    -- debug_print(struc, s, s_pos, mode)
    local parse_result, new_s_pos
    local is_tracking = not verify_only and struc_is_table and struc.name
    local checkpoint = get_checkpoint()
    parse_result, new_s_pos = mode_handlers[mode](struc, s, s_pos, parse)
    if parse_result then
      if is_tracking and (s_pos < new_s_pos) then
        mark(s_pos, new_s_pos - 1, struc.name)
      end
    else
      new_s_pos = s_pos
      rollback(checkpoint)
    end
    return parse_result, new_s_pos
  end
---

local populate = request('populate')
local optimize = request('optimize')
local link = request('link')

return
  function(struc, s, a_verify_only)
    assert(is_table(struc) or is_string(struc) or is_function(struc))
    assert_string(s)
    verify_only = a_verify_only
    link(struc)
    if verify_only then
      local result, new_s_pos = parse(struc, s, 1)
      return result, new_s_pos
    else
      optimize(struc)
      folder.init()
      local result, new_s_pos = parse(struc, s, 1)
      local data_struc = folder.get_struc()
      populate(data_struc, s)
      return result, new_s_pos, data_struc
    end
  end
