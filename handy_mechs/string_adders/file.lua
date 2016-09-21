-- Concatter implementation via writing to file.

--[[
  With comparision of mere ".." and "table.concat" implementations:
  + capacity
  - speed
]]

local safe_open = request('^.^.file.safe_open')
local file_as_string = request('^.^.file.as_string')
local file_exists = request('^.^.file.exists')

local get_new_file_name =
  function()
    -- do return os.tmpname() end --(1)
    local result
    local num_tries = 0
    repeat
      result = ('%010d.tmp'):format(math.random(2 ^ 32))
      num_tries = num_tries + 1
      if (num_tries > 10) then
        error('Too many tries to generate file name. Possibly due same math.randomseed. Stopped.')
      end
    until not file_exists(result)
    return result
  end

local result =
  {
    --file_name
    --file
    init =
      function(self)
        self.file_name = get_new_file_name()
        self.file = safe_open(self.file_name, 'a+b')
      end,
    free =
      function(self)
        if self.file then
          if (io.type(self.file) == 'file') then
            io.close(self.file)
          end
          os.remove(self.file_name)
        end
      end,
    add_term =
      function(self, s)
        self.file:write(s)
      end,
    get_result =
      function(self)
        self.file:flush()
        self.file:seek('set')
        local result
        result = self.file:read('a')
        self.file:seek('end')
        return result
      end,
  }

setmetatable(
  result,
  {
    __gc =
      function(obj)
        obj:free()
      end,
  }
)

return result

--[[
  [1]
    os.tmpname() is not used because in my case /tmp is really
    partition in memory. So it does not solve problem when I have
    data structure occupuing 80% of RAM and write raw data which
    is 40% of RAM.
]]
