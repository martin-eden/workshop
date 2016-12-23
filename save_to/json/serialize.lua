local quote_string = request('^.^.compile.json.quote_string')

local is_array = request('^.^.array.is_array')

return
  function(self, value)
    local adder = self.string_adder
    local tokens = self.token_giver

    local value_type = type(value)
    if (value_type == 'nil') then
      adder:add('null')
    elseif (value_type == 'boolean') then
      adder:add(tostring(value))
    elseif (value_type == 'number') then
      --possibly need more fine-grain formatting
      adder:add(tostring(value))
    elseif (value_type == 'string') then
      adder:add(quote_string(value))
    elseif (value_type == 'table') then
      if is_array(value) then
        adder:add(tokens:open_array())
        if (#value > 0) then
          adder:add(tokens:indent_value())
          self:serialize(value[1])
          for i = 2, #value do
            adder:add(tokens:array_delimiter())
            adder:add(tokens:indent_value())
            self:serialize(value[i])
          end
        end
        local is_empty = (#value == 0)
        adder:add(tokens:close_array(is_empty))
      else
        adder:add(tokens:open_object())
        local is_first_rec = true
        for k, v in self.table_iterator(value) do
          if not is_first_rec then
            adder:add(tokens:object_delimiter())
          end
          adder:add(tokens:indent_value())
          self:serialize(k)
          adder:add(tokens:key_val_delimiter())
          self:serialize(v)
          is_first_rec = false
        end
        adder:add(tokens:close_object())
      end
    end
  end
