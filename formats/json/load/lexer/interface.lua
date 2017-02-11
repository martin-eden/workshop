local result
local spawn_get_functions = request('spawn_get_functions')
result = spawn_get_functions()
result.get_token = request('get_token')
return result
