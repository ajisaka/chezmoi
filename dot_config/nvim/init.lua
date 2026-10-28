-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- }}}

-- Load parted config files {{{

local get_filename = function(path)
  -- return path:match('^.+/(.+)$')
  return vim.fn.fnamemodify(path, ':t')
end

local load_parted_config_files = function()
  local in_local = vim.fn.expand('~/.config/nvim.local')

  local rtp = vim.o.rtp
  if vim.fn.isdirectory(in_local) then
    rtp = in_local .. ',' .. rtp
  end

  local files = vim.fn.globpath(rtp, 'part/*.{lua,vim}', true, true)
  table.sort(files, function(a, b)
    return get_filename(a) < get_filename(b)
  end)
  for _, fp in pairs(files) do
    -- print('Loading ' .. fp)
    -- print(vim.o.runtimepath)
    local ok, err = pcall(vim.cmd.source, fp)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end

load_parted_config_files()

-- }}}
