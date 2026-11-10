-- make・npm・cargo など多様なフレームワークのタスクを定義・実行・監視できるタスクランナー。
local function list_templates_in_directory(dir)
  local result = {}

  for file_path, file_type in vim.fs.dir(dir, { depth = 10 }) do
    if file_type == 'file' and vim.endswith(file_path, '.lua') then
      local file_name = file_path.gsub(file_path, '.lua', '')
      local module_name = file_name:gsub('/', '.')
      table.insert(result, module_name)
    end
  end

  return result
end

local function open_task_in(position)
  return function()
    local overseer = require('overseer')
    local tasks = overseer.list_tasks { recent_first = true }
    if tasks[1] then
      tasks[1]:open_output(position)
    else
      vim.notify('No tasks')
    end
  end
end

local function open_selected_task_in(position)
  return function()
    local overseer = require('overseer')
    local tasks = overseer.list_tasks { recent_first = true }

    if #tasks == 0 then
      vim.notify('No tasks', vim.log.levels.WARN)
      return
    end

    vim.ui.select(tasks, {
      prompt = 'Select a task',
      kind = 'overseer_task',
      format_item = function(task)
        return string.format('[%s] %s', task.status, task.name)
      end,
    }, function(task)
      if task then
        task:open_output('tab')
      end
    end)
  end
end

local function templates()
  local result = { 'builtin' }
  vim.list_extend(result, list_templates_in_directory(vim.fn.stdpath('config') .. '/lua/overseer/template'))
  return result
end

return {
  'stevearc/overseer.nvim',
  cmd = {
    'OverseerOpen',
    'OverseerClose',
    'OverseerToggle',
    'OverseerSaveBundle',
    'OverseerLoadBundle',
    'OverseerDeleteBundle',
    'OverseerRunCmd',
    'OverseerRun',
    'OverseerInfo',
    'OverseerBuild',
    'OverseerQuickAction',
    'OverseerTaskAction',
    'OverseerClearCache',
  },
  keys = {
    {
      '<Leader>rr',
      function()
        local overseer = require('overseer')
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.cmd([[ OverseerRun ]])
        else
          overseer.run_action(tasks[1], 'restart')
        end
      end,
      mode = { 'n' },
      desc = 'Overseer re-run',
    },
    { '<Leader>rR', ':<C-u>OverseerRun<CR>', mode = { 'n' }, desc = 'Overseer: Run' },
    { '<Leader>rb', '<Cmd>OverseerToggle<CR>', mode = { 'n' }, desc = 'Overseer: Task In Bottom' },
    { '<Leader>rt', open_task_in('tab'), mode = { 'n' }, desc = 'Overseer: Task In Tab - Last' },
    { '<Leader>rv', open_task_in('vertical'), mode = { 'n' }, desc = 'Overseer: Task In Vertical - Last' },
    { '<Leader>rT', open_selected_task_in('tab'), mode = { 'n' }, desc = 'Overseer: Task In Tab' },
    { '<Leader>rV', open_selected_task_in('vertical'), mode = { 'n' }, desc = 'Overseer: Task In Vertical' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    local overseer = require('overseer')

    overseer.setup {
      templates = templates(),

      bundles = {
        -- When saving a bundle with OverseerSaveBundle or save_task_bundle(), filter the tasks with
        -- these options (passed to list_tasks())
        save_task_opts = {
          bundleable = true,
        },
        -- Autostart tasks when they are loaded from a bundle
        autostart_on_load = false,
      },

      task_list = {
        bindings = {
          ['<CR>'] = '<Nop>',
          ['r'] = '<cmd>OverseerQuickAction restart<CR>',
        },
      },
    }
  end,
}
