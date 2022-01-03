--[[
  Gets two tables with segment descriptions. Changes data of <SegInner> segment
  to be contained inside <SegOuter> segment. Returns possibly modified <SegInner>
  table.
]]

return
  function(SegInner, SegOuter)
    assert_table(SegInner)
    assert_table(SegOuter)

    if (SegInner:GetLength() > SegOuter:GetLength()) then
      SegInner:SetStart(SegOuter:GetStart())
      SegInner:SetFinish(SegOuter:GetFinish())
    end

    if (SegInner:GetStart() < SegOuter:GetStart()) then
      SegInner:MoveStart(SegOuter:GetStart())
    end

    if (SegInner:GetFinish() > SegOuter:GetFinish()) then
      SegInner:MoveFinish(SegOuter:GetFinish())
    end

    return SegInner
  end
