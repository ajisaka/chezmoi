return {
  name = 'openscad-make',
  builder = function(_)
    local filepath = vim.fn.expand('%:p')
    return {
      cmd = { 'openscad-make' },
      args = { "--default", filepath },
      name = 'openscad-make',
      env = {},
      components = { 'default' },
      metadata = {},
    }
  end,
  desc = 'Generate STL file',
  params = {
  },
  priority = 50,
  condition = {
    filetype = { 'openscad' },
    callback = function()
      return true
    end,
  },
}
