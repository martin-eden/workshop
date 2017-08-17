return
  function(C, key, salt, block_num)
    return
      {
        C[1], key[1], key[2], key[3],
        key[4], C[2], salt[1], salt[2],
        block_num[1], block_num[2], C[3], key[5],
        key[6], key[7], key[8], C[4],
      }
  end
