local M = {}

math.randomseed(os.time())

function M.choose_from_table(t)
  return t[math.random(#t)]
end

function M.merge_tables(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

function M.relative_path(target, base)
  local abs_target = vim.fn.resolve(target)
  local abs_base = vim.fn.resolve(base)
  return vim.fn.fnamemodify(abs_target, ':.' .. abs_base)
end

function M.popup_window(opts)
  -- { content }

  local content = opts.content

  local buf = vim.api.nvim_create_buf(false, true)

  local editor_width = vim.api.nvim_get_option_value('columns', { scope = 'local' })
  local editor_height = vim.api.nvim_get_option_value('lines', { scope = 'local' })

  local width = 120
  local height = content and #content or math.floor(editor_height / 0.6)
  local winblend = 20 -- 透過度を設定 (0-100)

  local row = math.floor((editor_height - height) / 2)
  local col = math.floor((editor_width - width) / 2)

  local window_options = {
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'single',
  }

  local win = vim.api.nvim_open_win(buf, true, window_options)
  vim.api.nvim_set_option_value('winblend', winblend, { win = win })
  if content then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  end
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>quit<CR>', { noremap = true })
end

return M
