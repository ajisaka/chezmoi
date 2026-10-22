return {
  generator = function(_, callback)
    callback {
      {
        name = 'pre-commit run',
        builder = function(_)
          return {
            cmd = { 'pre-commit' },
            args = { 'run' },
          }
        end,
      },
      {
        name = 'pre-commit run all',
        builder = function(_)
          return {
            cmd = { 'pre-commit' },
            args = { 'run', '--all-files' },
          }
        end,
      },
      {
        name = 'pre-commit install',
        builder = function(_)
          return {
            cmd = { 'pre-commit' },
            args = { 'install' },
          }
        end,
      },
    }
  end,
  condition = {
    callback = function(_)
      return vim.fn.filereadable('.pre-commit-config.yaml') == 1
    end,
  },
}
