local overseer = require('overseer')

return {
  name = 'vmypy',
  builder = function(_)
    local dir = '.'
    if vim.fn.isdirectory('./src') ~= 0 then
      dir = './src'
    end

    return {
      cmd = { 'vmypy' },
      args = { dir },
      name = 'vmypy',
      -- cwd = '/tmp',
      env = {},
      components = { 'default' },
      metadata = {},
    }
  end,
  desc = 'mypy on venv',
  -- Tags can be used in overseer.run_template()
  tags = { overseer.TAG.BUILD },
  params = {
    -- See :help overseer-params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  priority = 50,
  -- Add requirements for this template. If they are not met, the template will not be visible.
  -- All fields are optional.
  condition = {
    -- A string or list of strings
    -- Only matches when current buffer is one of the listed filetypes
    filetype = { 'python' },
    -- A string or list of strings
    -- Arbitrary logic for determining if task is available
    callback = function(search)
      -- print(vim.inspect(search))
      return true
    end,
  },
}
