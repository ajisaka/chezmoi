local dbg = function(msg)
  local file = io.open('/tmp/xmosh/log.txt', 'a')
  if file == nil then
    return
  end
  file:write(msg)
  file:write('\n')
  file:close()
end
