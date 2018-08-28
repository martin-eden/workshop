--[[
]]

local remove_offsets =
  function(struc)
    for i, rec in ipairs(struc.files) do
      rec.meta.offset = nil
      if rec.post_rec then
        rec.post_rec.meta.offset = nil
      end
    end

    for i, rec in ipairs(struc.locators) do
      rec.meta.offset = nil
      rec.file = nil
    end

    struc.locators_link.meta.offset = nil
    struc.locators_link.offset = nil

    if struc.locators_link_64 then
      struc.locators_link_64.meta.offset = nil
      struc.locators_link_64.offset = nil
    end

    if struc.locators_link_64_link then
      struc.locators_link_64_link.meta.offset = nil
      struc.locators_link_64_link.offset = nil
    end
  end

local recalc_lengths =
  function(struc)
    -- struc.locators_link.num_entries = #struc.locators
    -- struc.locators_link.directory_size = '?'
  end

local get_data_size = request('!.formats.pkzip.parser.get_data_size')
local compile_post_rec =
  request('!.formats.pkzip.compiler.compile.post_file_rec')

local file_rec_prefix = request('!.formats.pkzip.file_rec_prefix')
local file_rec_prefix_len = file_rec_prefix:packsize()

local locator_prefix = request('!.formats.pkzip.locator_prefix')
local locator_prefix_len = locator_prefix:packsize()

local fill_offsets =
  function(struc)
    local offset = 0

    for i, rec in ipairs(struc.files) do
      rec.meta.offset = offset
      struc.locators[i].file_offset = offset

      local post_rec_len = 0
      if rec.post_rec then
        post_rec_len = #compile_post_rec(rec.post_rec)
      end

      offset =
        offset +
        file_rec_prefix_len +
        rec.filename_length +
        rec.extra_data_length +
        get_data_size(struc.locators[i]) +
        post_rec_len
    end

    local first_locator_offset = offset

    for i, rec in ipairs(struc.locators) do
      rec.meta.offset = offset

      offset =
        offset +
        locator_prefix_len +
        rec.filename_length +
        rec.extra_data_length +
        rec.comment_length
    end

    struc.locators_link.offset = first_locator_offset
    struc.locators_link.meta.offset = offset

  end

return
  function(struc)
    assert_table(struc)
    remove_offsets(struc)
    recalc_lengths(struc)
    fill_offsets(struc)
    return struc
  end
