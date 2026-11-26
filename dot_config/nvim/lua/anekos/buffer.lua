local M = {}

function M.insert_text(text)
  local _, line, col, _ = unpack(vim.fn.getcurpos())
  local buf = vim.api.nvim_get_current_buf()
  local lines
  if type(text) == 'table' then
    lines = text
  else
    lines = vim.split(text, '\n')
  end
  vim.api.nvim_buf_set_text(buf, line - 1, col - 1, line - 1, col - 1, lines)
end

function M.append_text_to_buffer_end(lines)
  if type(lines) ~= 'table' then
    lines = vim.split(lines, '\n')
  end

  local buf = vim.api.nvim_get_current_buf()

  local line_count = vim.api.nvim_buf_line_count(buf)

  vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)
end

function M.cut_selected_text_async(fn)
  local keys = vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', true)

  vim.schedule(function()
    local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
    if #lines == 0 then
      return
    end

    local selected_text
    if #lines == 1 then
      local line_length = #lines[1]
      end_col = math.min(end_col, line_length + 1) -- 行の長さを超えないよう調整
      selected_text = string.sub(lines[1], start_col, end_col - 1)
    else
      lines[1] = string.sub(lines[1], start_col)
      lines[#lines] = string.sub(lines[#lines], 1, math.min(end_col, #lines[#lines] + 1) - 1)
      selected_text = table.concat(lines, '\n')
    end

    vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, end_row - 1, math.min(end_col - 1, #lines[#lines]), {})

    fn(vim.split(selected_text, '\n'))
  end)
end

return M
