local sub_commands = {
  -- Name, args...
  { 'Install this app', 'uv tool install -e --force .' },
  { 'Install dev tools', 'uv add --dev ruff mypy' },
  { 'pytest', 'uv run pytest', true },
  { 'Check all', 'uv run mypy . && uv run ruff check --fix && uv run ruff format' },
  { 'Check all and Test', 'uv run mypy . && uv run ruff check --fix && uv run ruff format && uv run pytest', true },
}

local qf = {
  'on_output_quickfix',
  errorformat = table.concat({
    '%f:%l: %m', -- foo.py:42: エラー本文
    '%-G%.%#', -- 上記にマッチしない行はすべて捨てる
  }, ','),
  open = false, -- 完了時に quickfix を開く
  open_height = 8,
  close = false,
  set_empty_results = false,
}

return {
  generator = function(_, callback)
    local valid = vim.fn.glob('pyproject.toml') ~= ''
    if not valid then
      callback {}
      return
    end

    callback(vim.tbl_map(function(name_and_cmd)
      local name = name_and_cmd[1]
      local cmd = name_and_cmd[2]
      local use_qf = name_and_cmd[3] or false

      return {
        name = 'uv: ' .. name,
        builder = function(_)
          return {
            cmd = cmd,
            components = {
              'on_exit_set_status',
              'fidget-output',
              use_qf and qf or nil,
            },
          }
        end,
      }
    end, sub_commands))
  end,
}
