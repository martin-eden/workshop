return
  function(template, substitutions)
    return template:gsub('%$([%w_]+)', substitutions)
  end
