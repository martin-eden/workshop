local msg_format =
[[
%s
--

%s
]]

return
  function(self)
    local msg = msg_format:format(self.description, self.usage)
    print(msg)
  end
