return
  function(rec)
    return ('< c8 c8 c8'):pack(rec.modified, rec.accessed, rec.created)
  end
