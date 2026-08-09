-- JSON serializer with structural indentations

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

local Interface
do
  do
    local BaseInterface = request('^.minimal.interface')
    Interface = new(BaseInterface)
  end

  local init
  do
    local Indent = request('!.concepts.Indent')
    init =
      function(Me)
        local Indent = Indent.create()
        Indent:SetIndentChunk(Me.indent_chunk)
        Me.Indent = Indent
      end
  end

  local inc_indent =
    function(Me)
      Me.Indent:Inc()
    end

  local dec_indent =
    function(Me)
      Me.Indent:Dec()
    end

  local get_indent_str =
    function(Me)
      return Me.Indent:ToString()
    end

  local merge_and_patch = request('!.table.merge_and_patch')

  merge_and_patch(
    Interface,
    {
      indent_chunk = '  ',
      Indent = { },
      dec_indent = dec_indent,
      inc_indent = inc_indent,
      get_indent_str = get_indent_str,

      init = init,
      handlers = request('handlers.interface'),
    }
  )
end

return Interface

--[[
  2016
  2017
  2026-08-09
]]
