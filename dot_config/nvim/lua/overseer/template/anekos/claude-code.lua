return {
  generator = function(_, callback)
    callback {
      {
        name = 'claude-code: commit',
        builder = function(_)
          return {
            cmd = { 'claude' },
            args = { '--print', '/commit' },
          }
        end,
      },
    }
  end,
}
