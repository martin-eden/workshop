return
  function(rec)
    assert_table(rec.extra_data)
    for i, extra_rec in ipairs(rec.extra_data) do
      if extra_rec.meta and (extra_rec.meta.type == 'zip64') then
        return extra_rec
      end
    end
  end
