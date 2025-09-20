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
          pattern = '',
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
        local os_name = package.config:sub(1, 1) == '\\' and 'win' or 'unix'
        Snacks.terminal(os_name == 'win' and 'pwsh.exe' or 'bash', { win = { border = 'rounded' } })

        --[[  local Snacks = require 'snacks'

        local opciones = { 'Opción A', 'Opción B', 'Opción C' }

        vim.ui.select(opciones, {
          prompt = 'Selecciona una opción:',
          format_item = function(item)
            return '👉 ' .. item
          end,
        }, function(seleccion)
          if seleccion then
            Snacks.notify.info('Elegiste: ' .. seleccion)
            -- Aquí puedes ejecutar la acción correspondiente
          else
            Snacks.notify.warn 'No se seleccionó ninguna opción'
          end
        end) ]]
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
        --Snacks.picker.git_status()
        Snacks.lazygit()
      end,
      desc = 'Lazy[g]it',
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
    {
      '<F5>',
      function()
        print('f5 pressed...' .. vim.fn.getcwd())
        local os_name = package.config:sub(1, 1) == '\\' and 'win' or 'unix'

        local files = vim.fs.find(function(name, path)
          return name:match '%.csproj$'
        end, { limit = math.huge, type = 'file', path = vim.fn.getcwd() })
        print(vim.fn.getcwd())
        print(files)

        --[[         local function mostrar_salida_comando(comando)
          local salida = vim.fn.system(comando)

          -- Crear buffer flotante
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(salida, '\n'))

          -- Configurar ventana flotante
          local ancho = math.floor(vim.o.columns * 0.6)
          local alto = math.floor(vim.o.lines * 0.6)
          local opts = {
            relative = 'editor',
            width = ancho,
            height = alto,
            row = (vim.o.lines - alto) / 2,
            col = (vim.o.columns - ancho) / 2,
            style = 'minimal',
            border = 'rounded',
          }

          vim.api.nvim_open_win(buf, true, opts)
        end ]]

        -- Ejemplo de uso
        --mostrar_salida_comando 'ls -la'

        --[[  local Snacks = require 'snacks'

        local opciones = { 'Opción A', 'Opción B', 'Opción C' }

        vim.ui.select(opciones, {
          prompt = 'Selecciona una opción:',
          format_item = function(item)
            return item
          end,
        }, function(seleccion)
          if seleccion then
            Snacks.notify.info('Elegiste: ' .. seleccion)
            -- Aquí puedes ejecutar la acción correspondiente
          else
            Snacks.notify.warn 'No se seleccionó ninguna opción'
          end
        end) ]]
      end,
    },
  },
}
