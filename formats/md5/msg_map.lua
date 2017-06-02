local msg_map = {}
for r = 1, 4 do
  msg_map[r] = {}
end
for i = 1, 16 do
  msg_map[1][i] = i
  msg_map[2][i] = (5 * (i - 1) + 1) % 16 + 1
  msg_map[3][i] = (3 * (i - 1) + 5) % 16 + 1
  msg_map[4][i] = (7 * (i - 1)) % 16 + 1
end

return msg_map
