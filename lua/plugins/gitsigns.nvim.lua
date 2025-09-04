-- See `:help gitsigns` to understand what the configuration keys do
return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '➕' },
      change = { text = '✏️' },
      delete = { text = '🗑️' },
      topdelete = { text = '🗑️🔝' },
      changedelete = { text = '🗑️✏️ ' },
    },
  },
}
