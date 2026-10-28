-- https://github.com/stevearc/overseer.nvim/blob/master/doc/guides.md#custom-components
-- https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget-api.txt
-- https://zenn.dev/slin/articles/2024-02-07-fidget

return {
  desc = 'Output on fidget',
  params = {},
  editable = false,
  serializable = false,
  constructor = function(_)
    local fidget = nil -- require('fidget.progress').handle.create {}

    return {
      on_start = function(_, task)
        fidget = require('fidget.progress').handle.create {
          title = 'Overseer',
          lsp_client = { name = 'Overseer' },
        }

        fidget:report {
          title = task.name,
        }
      end,
      on_output_lines = function(_, _, lines)
        local message = vim.fn.trim(lines[#lines])
        if message == '' then
          return
        end
        fidget:report {
          message = message,
        }
      end,
      on_complete = function()
        fidget:finish()
      end,
    }
  end,
}
