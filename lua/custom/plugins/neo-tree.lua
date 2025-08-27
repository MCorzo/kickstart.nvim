return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        width = 45,
        position = 'float',
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
          hide_by_pattern = {
            '**/debug',
            '**/obj',
            '**/.vs',
            '**/bin',
            '**/.git',
            '**/.svn',
            '**/.hg',
            '**/CVS',
            '**/.DS_Store',
            '**/Thumbs.db',
            '**/dist',
            '**/node_modules',
            '**/.angular',
            '**/.gitkeep',
          },
          always_show = {
            '.gitignore',
          },
        },
      },
      default_component_configs = {
        name = {
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added = '➕',
            modified = '✏️',
            deleted = '🗑️',
            renamed = '🔥',
            -- Status type
            untracked = '⛔',
            ignored = '🚫',
            unstaged = '🔓',
            staged = '🔒',
            conflict = '⚠️',
          },
        },
      },
    }
  end,
}
