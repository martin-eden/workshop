-- CSV parser driver

local string_lines_iterator = request('^.^.handy_mechs.line_iterators.string')
local file_lines_iterator = request('^.^.handy_mechs.line_iterators.file')

local init =
  function(self, file_or_string)
    if is_string(file_or_string) then
      self.lines_iterator = new(string_lines_iterator)
    elseif (io.type(file_or_string) == 'file') then
      self.lines_iterator = new(file_lines_iterator)
    end
    self.lines_iterator:init(file_or_string)
  end

local parse_line = request('specific.parse_line')

local get_next_rec =
  function(self)
    local result
    local line, broken_line
    local has_problems, is_unclosed_quote
    local next_line_func
    ::read::
    line = self.lines_iterator:get_next_line()
    if line then
      if broken_line then
        line = line .. broken_line
        broken_line = nil
      end
      result, has_problems, is_unclosed_quote = parse_line(self, line)
      if is_unclosed_quote then
        broken_line = line
        goto read
      end
      if has_problems then
        result = nil
      end
    end
    return result
  end

local parse_data =
  function(self)
    local result = {}
    repeat
      local rec = self:get_next_rec()
      result[#result + 1] = rec
    until not rec
    return result
  end

return
  {
    quote_char = '"',
    field_sep_char = ',',
    record_sep_char = '\n',
    dirty_data_allowed = false,
    lines_iterator = nil,
    init = init,
    get_next_rec = get_next_rec,
    parse_data = parse_data,
  }
