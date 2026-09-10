return {
  generator = function(_, callback)
    callback {
      {
        name = 'git push',
        builder = function(_)
          return {
            cmd = { 'git' },
            args = { 'push' },
          }
        end,
      },
      {
        name = 'git push current branch',
        builder = function(_)
          return {
            cmd = { 'git' },
            args = { 'pscb' },
          }
        end,
      },
    }
  end,
  condition = {
    callback = function(_)
      return vim.trim(vim.fn.system('git rev-parse --is-inside-work-tree')) == 'true'
    end,
  },
}
