-- Return shell command to download file by URL

--[[
  Author: Martin Eden
  Last mod.: 2026-06-15
]]

-- Imports:
local quote = request('!.concepts.shell.quote')
local normalize = request('!.concepts.path_name.normalize')
local glue_words = request('!.concepts.words.to_string')

local get_cmd_wget =
  function(url_str, pathname)
    return
      {
        'wget',
        '--output-document=' .. pathname,
        url_str,
        '--quiet',
      }
  end

local get_cmd_curl =
  function(url_str, pathname)
    return
      {
        'curl',
        '--output',
        pathname,
        url_str,
        '--silent',
      }
  end

local get_cmd_download_file =
  function(url_str, pathname)
    assert_string(url_str)
    assert_string(pathname)

    url_str = quote(url_str)
    pathname = quote(normalize(pathname))

    --[[
      We prefer "curl" because in case of error it does not create
      zero-sized output file.
    ]]

    return glue_words(get_cmd_curl(url_str, pathname))
  end

-- Export:
return get_cmd_download_file

--[[
  2026-06-15
]]
