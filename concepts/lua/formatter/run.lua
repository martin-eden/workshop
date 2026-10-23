-- Run formatter

--[[
  Author: Martin Eden
  Last mod.: 2026-10-21
]]

local transform_ast = request('^.transform_ast')

return
  function(self)
    self.data_struc =
      transform_ast(
        self.data_struc,
        {
        }
      )
    self.is_ok = self:process_node(self.data_struc)

    return self:get_result()
  end

--[[
  2018 #
  2026-10-21
]]
