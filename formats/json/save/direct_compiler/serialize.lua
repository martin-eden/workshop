local quote_string = request('^.quote_string')

local is_array = request('!.mechs.array.is_array')

return
  function(self, value)
    local printer = self.printer
    local tokens = self.tokens

    local value_type = type(value)
    if (value_type == 'nil') then
      printer:add_curline('null')
    elseif (value_type == 'boolean') then
      printer:add_curline(tostring(value))
    elseif (value_type == 'number') then
      --possibly need more fine-grain formatting
      printer:add_curline(tostring(value))
    elseif (value_type == 'string') then
      printer:add_curline(quote_string(value))
    elseif (value_type == 'table') then
      if is_array(value) then
        tokens:open_array()
        if (#value > 0) then
          self:serialize(value[1])
          for i = 2, #value do
            tokens:delimit_array_values()
            self:serialize(value[i])
          end
        end
        local is_empty = (#value == 0)
        tokens:close_array()
      else
        tokens:open_object()
        local is_first_rec = true
        for k, v in self.table_iterator(value) do
          if not is_first_rec then
            tokens:delimit_object_values()
          end
          self:serialize(k)
          tokens:delimit_key_value()
          self:serialize(v)
          is_first_rec = false
        end
        tokens:close_object()
      end
    end
  end
