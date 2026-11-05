-- Git 履歴をインタラクティブなグラフ形式で視覚化し、コミット・ブランチ・マージを時系列で表示する。
return {
  'isakbm/gitgraph.nvim',
  dependencies = { require('plugins/diffview') },
  cmd = {
    'GitGraph',
  },
  keys = {
    {
      '<leader>gl',
      function()
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end,
      desc = 'Git graph',
    },
  },
  config = function()
    vim.api.nvim_create_user_command('GitGraph', function(_)
      require('gitgraph').draw({}, { all = true, max_count = 5000 })
    end, {
      nargs = '*',
    })

    require('gitgraph').setup {
      symbols = {
        merge_commit = 'M',
        commit = '*',
        -- merge_commit = '',
        -- commit = '',
        -- merge_commit_end = '',
        -- commit_end = '',
        -- GVER = '',
        -- GHOR = '',
        -- GCLD = '',
        -- GCRD = '╭',
        -- GCLU = '',
        -- GCRU = '',
        -- GLRU = '',
        -- GLRD = '',
        -- GLUD = '',
        -- GRUD = '',
        -- GFORKU = '',
        -- GFORKD = '',
        -- GRUDCD = '',
        -- GRUDCU = '',
        -- GLUDCD = '',
        -- GLUDCU = '',
        -- GLRDCL = '',
        -- GLRDCR = '',
        -- GLRUCL = '',
        -- GLRUCR = '',
      },
      format = {
        timestamp = '%Y-%m-%d(%a) %H:%M',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        on_select_commit = function(commit)
          -- print('selected commit:', commit.hash)
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        on_select_range_commit = function(from, to)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
    }
  end,
}
