local looks_like_name = request('^.^.parse.lua.is_identifier')

local put_qualified_key =
  function(self, node)
    if looks_like_name(node) and not self.serializer.always_index_keys then
      self.serializer.string_adder:add_term('.' .. tostring(node))
    else
      self.serializer:serialize_key(node, 0)
    end
  end

return put_qualified_key
