local try_string =
  {is_string, on_match = quote_str}

local try_number =
  {is_number, on_match = tonumber}

local try_boolean =
  {is_boolean, on_match = tostring}

local try_null =
  {is_nil, on_match = 'null'}

local try_array =
  {tv('array'), on_match = {'(', opt_rep('>value'), ')'}}

local try_object =
  {tv('object'), on_match = {'(', opt_rep(try_string, '>value'), ')'}}

local try_value =
  {
    inner_name = 'value',
    cho(
      try_string,
      try_number,
      try_boolean,
      try_null,
      try_array,
      try_object,
    )
  }

processor.link(try_value)

return try_object
