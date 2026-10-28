-- 非同期で動作する汎用ファイルツリーエクスプローラ。ドロワー形式でファイル操作・Git 状態表示が可能。
-- https://zenn.dev/sirasagi62/articles/c10c8004ab43a8

local function nmap(lhs, rhs)
  vim.keymap.set({ 'n' }, lhs, rhs, { remap = true, silent = true, buffer = true })
end

local function nnoremap(lhs, rhs)
  vim.keymap.set({ 'n' }, lhs, rhs, { remap = false, silent = true, buffer = true })
end

return {
  'lambdalisue/fern.vim',
  cond = false,
  cmd = {
    'Fern',
  },
  keys = {
    { '<Leader>ff', '<Cmd>Fern . -reveal=% -drawer<CR>', mode = { 'n' }, desc = 'Fern filer' },
  },
  dependencies = {
    'lambdalisue/nerdfont.vim',
    'lambdalisue/fern-renderer-nerdfont.vim',
    'yuki-yano/fern-preview.vim',
    'lambdalisue/vim-fern-mapping-git',
    'andykog/fern-highlight.vim',
  },
  config = function()
    vim.g['fern#renderer'] = 'nerdfont'
    vim.g['fern#default_hidden'] = 1
    vim.g['fern#default_exclude'] = [[\v^(\.git|node_modules|__pycache__|\.aws-sam|\.terraform|\.mypy_cache|\.venv)$]]
    vim.g['g:fern#disable_default_mappings'] = 1

    vim.g['fern_git_status#disable_ignored'] = 1
    vim.g['fern_git_status#disable_untracked'] = 0
    vim.g['fern_git_status#disable_submodules'] = 0
    vim.g['fern_git_status#disable_directories'] = 0

    local ns = vim.api.nvim_create_namespace('fern-colors')
    local AuGroupName = 'AnekosFernConf'
    vim.api.nvim_create_augroup(AuGroupName, {})

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = { 'fern' },
      callback = function()
        vim.opt_local.winfixbuf = true

        nmap('<CR>', '<plug>(fern-action-open-or-expand)')
        nmap('c', '<Plug>(fern-action-new-file)')
        nmap('p', '<Plug>(fern-action-preview:auto:toggle)')
        nmap('dd', '<plug>(fern-action-trash)')
        nmap('H', '<Plug>(fern-action-collapse)')
        nmap('L', '<plug>(fern-action-expand-tree)')
        nmap('=', '<plug>(fern-action-cd)')

        nmap('<C-t>', '<plug>(fern-action-open:tabedit)')
        nmap('<C-r>', '<plug>(fern-action-reload:all)')
        nmap('<C-v>', '<plug>(fern-action-open:vsplit)')
        nmap('<C-s>', '<plug>(fern-action-open:split)')

        nmap('s', '<Leader>')
        nnoremap('n', 'n')
      end,
      -- group
    })

    vim.api.nvim_create_autocmd('BufRead', {
      group = AuGroupName,
      nested = true, -- 必須
      callback = function()
        if vim.bo.filetype ~= 'fern' and vim.bo.buftype == '' then
          vim.cmd([[Fern . -reveal=% -drawer -stay]])
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      group = AuGroupName,
      pattern = 'FernHighlight',
      callback = function()
        -- 0,すなわちカレントバッファのみに名前空間を適用する
        -- hover-popup作成時にも呼び出されるためうまく適用される
        vim.api.nvim_win_set_hl_ns(0, ns)
        vim.api.nvim_set_hl(ns, 'FernBranchSymbol', { link = 'Directory' })
        vim.api.nvim_set_hl(ns, 'FernBranchText', { link = 'Directory' })
      end,
    })
  end,
}
