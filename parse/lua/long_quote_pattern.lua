local long_quote_pattern_open = '%[(=*)%['
local long_quote_pattern_close = '%](=*)%]'

return
  {
    start = long_quote_pattern_open,
    finish = long_quote_pattern_close,
  }
