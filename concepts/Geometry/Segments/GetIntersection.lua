--[[
  Return segment with intersection of two segments.

  |     |----|     | +
  | |------------| | =
  |     |----|     |

  | |------------| | +
  |     |----|     | =
  |     |----|     |

  | |--------|     | +
  |     |--------| | =
  |     |----|     |

  |     |--------| | +
  | |--------|     | =
  |     |----|     |

  |         |----| | +
  | |--|           | =
  |                |

]]

local Segment = request('^ Segment Interface')

return
  function(SegA, SegB)
    assert_table(SegA)
    assert_table(SegB)
    local result = new(Segment)
    result:SetStart(math max(SegA:GetStart(), SegB:GetStart()))
    result:SetFinish(math min(SegA:GetFinish(), SegB:GetFinish()))
    return result
  end
