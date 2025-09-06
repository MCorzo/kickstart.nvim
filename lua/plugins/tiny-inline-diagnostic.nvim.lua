return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy', -- Or 'LspAttach
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup()
    -- only if needed in your configuration, if you already have native LSP diagnostics
    vim.diagnostic.config { virtual_text = false }
  end,
}
