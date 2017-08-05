local md4_salt = request('^.md4.salt')

return
  {
    [1] = md4_salt,
    [2] =
      {
        [1] = 0,
        [2] = math.floor(2 ^ (1 / 3) * 2 ^ 30),
        [3] = math.floor(3 ^ (1 / 3) * 2 ^ 30),
      }
  }
