local string_lines_iterator = request('^.^.^.handy_mechs.line_iterators.string')
local file_lines_iterator = request('^.^.^.handy_mechs.line_iterators.file')

return
  function(self, file_or_string)
    if is_string(file_or_string) then
      self.lines_iterator = new(string_lines_iterator)
    elseif (io.type(file_or_string) == 'file') then
      self.lines_iterator = new(file_lines_iterator)
    end
    self.lines_iterator:init(file_or_string)
  end
