local match_regexp = request('!.mechs.parser.handy').match_regexp

local not_mid_letter = '%f[^_A-Za-z0-9]'

return
  function(str)
    return match_regexp(str .. not_mid_letter)
  end
