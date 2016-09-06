local result =
  {
    indenter = request('^.^.^.handy_mechs.indents_table'),
    level = 0,
    last_command = nil,
    debt = '',
    init =
      function(self)
        self.indenter:init()
        self.level = 0
        self.last_command = nil
        self.debt = ''
      end,
    open_array =
      function(self)
        local result = '['
        self.debt = '\n'
        self.level = self.level + 1
        return result
      end,
    close_array =
      function(self)
        self.level = self.level - 1
        self.debt = ''
        local result
        if (self.last_command == 'open_array') then
          result = ']'
        else
          result = '\n' .. self.indenter.indents[self.level] .. ']'
        end
        return result
      end,
    open_object =
      function(self)
        local result = '{'
        self.debt = '\n'
        self.level = self.level + 1
        return result
      end,
    close_object =
      function(self)
        self.level = self.level - 1
        self.debt = ''
        local result
        if (self.last_command == 'open_object') then
          result = '}'
        else
          result = '\n' .. self.indenter.indents[self.level] .. '}'
        end
        return result
      end,
    array_delimiter =
      function(self)
        return ',' .. '\n'
      end,
    indent_value =
      function(self)
        local result = self.debt .. self.indenter.indents[self.level]
        self.debt = ''
        return result
      end,
    key_val_delimiter =
      function(self)
        return ' : '
      end,
    object_delimiter =
      function(self)
        return ',' .. '\n'
      end,
  }

local method_names =
  {
    'open_array',
    'close_array',
    'open_object',
    'close_object',
    'array_delimiter',
    'indent_value',
    'key_val_delimiter',
    'object_delimiter',
  }

local wrap_methods =
  function()
    for i = 1, #method_names do
      local m = method_names[i]
      local base_method = result[m]
      result[m] =
        function(self)
          local result = base_method(self)
          self.last_command = m
          return result
        end
    end
  end

wrap_methods()

return result
