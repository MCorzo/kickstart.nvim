return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    indent = { enabled = true },
    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          {
            icon = '🔍 ',
            key = 'f',
            desc = 'Find File',
            action = ":lua Snacks.explorer {finder = 'explorer',layout = { preset = 'vertical', preview = false },auto_close = true,git_status = true,matcher = { sort_empty = false, fuzzy = false },}",
          },
          { icon = '📃 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = '💬 ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = '🗃️ ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '⚙️ ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '♻️ ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '💤 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = '🚪 ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
      },
      sections = {
        { section = 'header' },
        {
          section = 'keys',
          indent = 1,
          padding = 1,
        },
        { section = 'projects', icon = '📁 ', title = 'Recent Projects', indent = 3, padding = 2 },
        { section = 'recent_files', icon = '🗄️ ', title = 'Recent Files', indent = 3, padding = 2 },
        { section = 'startup' },
      },
    },
    notifier = { enabled = true },
    explorer = { enabled = false },
    scope = { enabled = true },
    picker = {
      icons = {
        git = {
          enabled = true,
          added = '➕ ',
          modified = '📝 ',
          removed = '❌ ',
          renamed = '🔀 ',
          staged = '✔️ ',
          unstaged = '⚠️ ',
          untracked = '🆕 ',
        },
        diagnostics = {
          Error = '🚩 ',
          Warn = '⚠️ ',
          Hint = '💡 ',
          Info = 'ℹ️ ',
        },
      },
    },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      --https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#general
      '<C-b>',
      function()
        --@type fun(opts?: snacks.picker.explorer.Config): snacks.Picker
        Snacks.picker.explorer {
          finder = 'explorer',
          layout = { preset = 'vertical', preview = false },
          auto_close = true,
          git_status = true,
          matcher = { sort_empty = false, fuzzy = false },
        }
      end,
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines {
          layout = {
            preset = 'vertical',
            preview = 'main',
          },
          title = 'Search in current buffer',
        }
      end,
      desc = 'Search in [B]uffer',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker()
      end,
      desc = 'Picker list',
    },
    {
      '<leader>st',
      function()
        Snacks.terminal 'pwsh.exe'
      end,
      desc = 'Open float [t]erminal',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Show [K]eymaps',
    },
    {
      '<leader>se',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Gr[e]p in project',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      mode = { 'n', 'x' },
      desc = 'Search [w]ord in current project',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.git_status()
      end,
      desc = '[G]it Status',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[R]esume last picker',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer [D]iagnostic',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Project Di[a]gnostics',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[N]otifications',
    },
    {
      '<leader>sc',
      function()
        Snacks.scratch()
      end,
      desc = 'Open s[c]ratch buffer',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          layout = {
            preset = 'vertical',
            preview = 'main',
          },
          title = 'Active Buffers List',
        }
      end,
    },
  },
}
