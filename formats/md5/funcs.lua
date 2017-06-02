return
  {
    [1] =
      function(x, y, z)
        return (x & y) | (~x & z)
      end,
    [2] =
      function(x, y, z)
        return (x & z) | (y & ~z)
      end,
    [3] =
      function(x, y, z)
        return x ~ y ~ z
      end,
    [4] =
      function(x, y, z)
        return y ~ (x | ~z)
      end,
  }
