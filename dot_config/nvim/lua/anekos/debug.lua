local enabled = false

if enabled then
  vim.fn.writefile({ vim.fn.strftime('NVIM STARTED') }, '/tmp/xmosh/nvim-debug.log', 'a')
end

return {
  debug = function(...)
    if enabled then
      vim.fn.writefile({ vim.fn.json_encode { ... } }, '/tmp/xmosh/nvim-debug.log', 'a')
    end
  end,
}
