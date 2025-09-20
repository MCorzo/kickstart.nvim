return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'minimal',
      options = {

        use_icons_from_diagnostic = true,
        enable_on_insert = false,
      },
    }
    -- only if needed in your configuration, if you already have native LSP diagnostics
    vim.diagnostic.config {
      virtual_text = true,
      signs = false,
      --[[  {
        text = {
          [vim.diagnostic.severity.ERROR] = 'E '
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
      }, ]]
    }
  end,
}
