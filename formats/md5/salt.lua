local salt = {}
for i = 1, 64 do
  salt[i] = math.floor(math.abs(math.sin(i)) * 2 ^ 32)
end

return salt
