--LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },
    --{ 'Hoffs/omnisharp-extended-lsp.nvim' },
    { 'rachartier/tiny-inline-diagnostic.nvim' },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>ln', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('<leader>lk', vim.lsp.buf.hover, 'Hover Documentation')

        -- Custom mapping for omniSharp lsp
        map('<leader>ld', '<cmd>:lua Snacks.picker.lsp_definitions()<CR>', 'Goto [D]efinition')
        map('<leader>le', '<cmd>:lua Snacks.picker.lsp_declarations()<CR>', 'Goto D[e]claration')
        map('<leader>lr', '<cmd>:lua Snacks.picker.lsp_references()<CR>', 'Goto [R]eferences')
        map('<leader>li', '<cmd>:lua Snacks.picker.lsp_implementations()<CR>', 'Goto Implementat[i]on')
        map('<leader>ly', '<cmd>:lua Snacks.picker.lsp_types_definitions()<CR>', 'Goto T[y]pe Definition')
        map('<leader>ls', '<cmd>:lua Snacks.picker.lsp_symbols()<CR>', 'Goto [S]ymbols')
        map('<leader>lw', '<cmd>:lua Snacks.picker.lsp_workspace_symbols()<CR>', 'Goto [W]orkspace Symbols')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  cmd (table): Override the default command used to start the server
    --  filetypes (table): Override the default list of associated filetypes for the server
    --  capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.

    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

    local servers = {
      angularls = {},
      html = {},
      roslyn = {},
      --[[       omnisharp = {
        capabilities = capabilities,
        filetypes = { 'cs', 'vb', 'sln', 'csproj' },
        root_dir = function(fname)
          local primary = require('lspconfig').util.root_pattern '*.sln'(fname)
          local fallback = require('lspconfig').util.root_pattern '*.csproj'(fname)

          return primary or fallback
        end,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          MsBuild = {
            LoadProjectsOnDemand = false,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = true,
            EnableDecompilationSupport = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      }, ]]
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    }

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    require('tiny-inline-diagnostic').setup {
      preset = 'powerline',
    }

    vim.diagnostic.config {
      underline = false,
      virtual_text = false,
      update_in_insert = false,
      severity_sort = true,
    }

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    })
  end,
}
