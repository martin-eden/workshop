local quote_string = request('^.^.compile.json.quote_string')

local is_array = request('^.^.array.is_array')

return
  function(self, value)
    local adder = self.string_adder
    local tokens = self.token_giver

    local value_type = type(value)
    if (value_type == 'nil') then
      adder:add_term('null')
    elseif (value_type == 'boolean') then
      adder:add_term(tostring(value))
    elseif (value_type == 'number') then
      --possibly need more fine-grain formatting
      adder:add_term(tostring(value))
    elseif (value_type == 'string') then
      adder:add_term(quote_string(value))
    elseif (value_type == 'table') then
      if is_array(value) then
        adder:add_term(tokens:open_array())
        if (#value > 0) then
          adder:add_term(tokens:indent_value())
          self:serialize(value[1])
          for i = 2, #value do
            adder:add_term(tokens:array_delimiter())
            adder:add_term(tokens:indent_value())
            self:serialize(value[i])
          end
        end
        local is_empty = (#value == 0)
        adder:add_term(tokens:close_array(is_empty))
      else
        adder:add_term(tokens:open_object())
        local is_first_rec = true
        for k, v in self.table_iterator(value) do
          if not is_first_rec then
            adder:add_term(tokens:object_delimiter())
          end
          adder:add_term(tokens:indent_value())
          self:serialize(k)
          adder:add_term(tokens:key_val_delimiter())
          self:serialize(v)
          is_first_rec = false
        end
        adder:add_term(tokens:close_object())
      end
    end
  end
