-- File stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

--[[
  Storage format

    1 [u] file handle
]]

local str_format = string.format

local assert_no_error =
  function(result, err_msg, err_code)
    if not result then
      error(str_format('[%d] %s.', err_code, err_msg))
    end
    return result
  end

local init
do
  local io_type = io.type
  init =
    function(me, f)
      assert_userdata(f)
      assert(io_type(f) == 'file')
      me[1] = f
    end
end

local get_length =
  function(me)
    local orig_pos = me:get_position()
    local result = assert_no_error(me[1]:seek('end'))
    me:set_position(orig_pos)
    return result
  end

local get_position =
  function(me)
    local seek_pos = assert_no_error(me[1]:seek())
    return seek_pos + 1
  end

local set_position
do
  local max = math.max
  set_position =
    function(me, new_position)
      new_position = max(new_position, 1)
      assert_no_error(me[1]:seek('set', new_position - 1))
    end
end

local read =
  function(me, num_slots)
    local s, msg = me[1]:read(num_slots)
    if not s then return '', 0 end
    return s, #s
  end

local write =
  function(me, s)
    assert_no_error(me[1]:write(s))
  end

local match_string =
  function(me, str)
    local orig_pos = me:get_position()
    local segment = me:read(#str)
    if (segment ~= str) then
      me:set_position(orig_pos)
      return false
    end
    return true
  end

local match_regexp
do
  --[[
    Same interface as for [^.string.match_regexp].

    Implementation is limited:

      Maximum length of possible capture is <chunk_size>.
  ]]
  local chunk_size = 64 * 1024
  match_regexp =
    function(me, pattern)
      local orig_pos = me:get_position()

      local part_a, part_b

      part_a = ''
      part_b = me:read(chunk_size)

      local window

      while (part_b ~= '') do
        part_a = part_b
        part_b = me:read(chunk_size) or ''

        window = part_a .. part_b

        local start, finish, capture = window:find(pattern)
        if start then
          me:set_relative_position(-#window + finish)
          capture = capture or window:sub(start, finish)
          return capture
        end
      end
      me:set_position(orig_pos)
    end
end

local overrides =
  {
    -- Core:
    init = init,
    get_length = get_length,
    get_position = get_position,
    set_position = set_position,
    read = read,
    -- Extensions:
    match_string = match_string,
    match_regexp = match_regexp,
    write = write,
  }

local base_interface = request('^.interface')
local force_merge = request('!.table.merge_and_patch')

local interface = new(base_interface)
force_merge(interface, overrides)

-- Export:
return interface

--[[
  2017 # #
  2018 #
  2026 #
  2026-11-15
]]
