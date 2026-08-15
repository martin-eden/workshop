-- Common interface for syntax element writers

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

--[[
  Intention of this module is provide structural sketch for
  implementers.

  Conceptually we provide

    * For implementers
      * Helper method for create() implementation
      * Method to write to output stream

    * For callers

      * create() method, it must be called before work
      * Set of serialization methods
]]

--[[
  Data format

    [t] -- output stream object
]]

local internal_create
do
  local attach_methods = request('!.table.attach_methods')
  internal_create =
    function(OutputStream, Interface)
      local State = { OutputStream }
      attach_methods(State, Interface)

      return State
    end
end

local get_output_stream = function(Me) return Me[1] end

local write =
  function(Me, str)
    get_output_stream(Me):Write(str)
  end

local writer_method = function(Me) end

local Interface

local create =
  function(OutputStream)
    return internal_create(OutputStream, Interface)
  end

Interface =
  {
    -- For implementers:
    internal_create = internal_create,
    Write = write,

    -- ( For callers
    create = create,

    Keyword_Local = writer_method,
    SeparateName = writer_method,
    EndStatement = writer_method,
    Keyword_Return = writer_method,

    Assign = writer_method,
    SeparateItem = writer_method,
    StartTable = writer_method,
    EndTable = writer_method,
    EmptyTable = writer_method,
    StartIndex = writer_method,
    EndIndex = writer_method,
    -- )
  }

return Interface

--[[
  2026-08-15
]]
