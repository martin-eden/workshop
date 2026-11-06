-- Format strings tree to wrapped text

--[[
  Author: Martin Eden
  Last mod.: 2026-11-06
]]

--[[
  Contract

    A group tried to be rendered three ways:

      * One-line at current line:

        current_line «(» « » item [« » item]... « » «)»

      * One-line at clean line:

        current_line
        «(» « » item [« » item]... « » «)»

      * Wrapped multi-line at clean line:

        current_line
        «(»
          item [« » item]...
          [item [« » item]...]...
        «)»

    Fallback is the last way.
]]

--[[
  Input

    1 [t] -- strings tree
    2 [?t] -- options
      margin [?i] -- max line width
]]

local prefix = '('
local postfix = ')'
local separator = ' '

local render_list_ghost_inline
local render_list_shell_inline
do
  render_list_ghost_inline =
    function(List, Printer)
      for _, item in ipairs(List) do
        if is_string(item) then
          if not Printer:OnCleanLine() then
            Printer:AddToCurline(separator)
          end
          Printer:AddToCurline(item)
        elseif is_table(item) then
          render_list_shell_inline(item, Printer)
        end
      end
    end

  render_list_shell_inline =
    function(List, Printer)
      if not Printer:OnCleanLine() then
        Printer:AddToCurline(separator)
      end
      Printer:AddToCurline(prefix)
      render_list_ghost_inline(List, Printer)
      Printer:AddToCurline(separator)
      Printer:AddToCurline(postfix)
    end
end

local render_string =
  function(str, Printer)
    if not Printer:OnCleanLine() then
      Printer:AddToCurline(separator)
    end
    Printer:AddToCurline(str)
  end

local default_margin = 64
local TextBlock = request('!.mechs.TextBlock')

return
  function(Tree, Options)
    Options = Options or { }
    local margin = Options.margin or default_margin

    local Printer = TextBlock.create('  ')

    local try =
      function(render_fn, item)
        local Trial = Printer:Seed()
        render_fn(item, Trial)
        if (Trial:GetWidth() > margin) then return end
        Printer:Graft(Trial)
        return true
      end

    local render_list
    render_list =
      function(List)
        for _, item in ipairs(List) do
          if is_string(item) then
            if not try(render_string, item) then
              Printer:RequestCleanLine()
              Printer:AddToCurline(item)
            end
          elseif is_table(item) then
            if not try(render_list_shell_inline, item) then
              Printer:RequestCleanLine()
              if not try(render_list_shell_inline, item) then
                Printer:AddToCurline(prefix)
                Printer:IncIndent()
                Printer:RequestCleanLine()
                render_list(item)
                Printer:DecIndent()
                Printer:RequestCleanLine()
                Printer:AddToCurline(postfix)
              end
            end
          end
        end
      end

    render_list(Tree)

    Printer:RequestCleanLine()

    return Printer:GetText()
  end

--[[
  2026-11-06
]]
