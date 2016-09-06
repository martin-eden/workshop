local chunk_name = 'handlers'

tribute(
  chunk_name,
  {
    debug = request('handlers.debug').debug,
    debug_with_indent = request('handlers.debug').debug_indent,
    nice_print = request('handlers.nice_print').handler,
  }
)
