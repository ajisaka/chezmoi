-- https://github.com/stevearc/overseer.nvim/blob/master/doc/guides.md#custom-components

return {
  desc = 'Output on notification',
  params = {},
  editable = true,
  serializable = false,
  constructor = function(_)
    local buffer = {}
    return {
      on_start = function()
        buffer = {}
      end,
      on_output_lines = function(_, _, lines)
        vim.list_extend(buffer, lines)
      end,
      on_complete = function()
        local non_blanks = vim.tbl_filter(function(line)
          return 0 < #line
        end, buffer)
        local short = vim.fn.join(vim.list_slice(non_blanks, #non_blanks - 5), '\n')

        if short == '' then
          return
        end

        vim.notify(short)

        if vim.fn.has('mac') == 1 then
          local escaped = vim.fn.shellescape(short)
          vim.system({ 'osascript', '-e', 'display notification "' .. escaped .. '"' }, { text = true })
        else
          vim.system({ 'notify-send', '-u', 'normal', short }, { text = true })
        end
      end,
    }
  end,
}
