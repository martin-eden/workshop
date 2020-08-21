local compile_file_rec = request('compile.file_rec')

return
  function(ast, stream)
    for _, rec in ipairs(ast.files) do
      if rec.meta.offset then
        stream:set_position(rec.meta.offset + 1)
      end
      compile_file_rec(rec, stream)
    end
  end
