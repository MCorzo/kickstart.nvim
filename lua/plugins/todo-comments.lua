return {
  'folke/todo-comments.nvim',
  optional = true,
  keys = {
    {
      '<leader>t',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Project Comments List',
    },
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Search Todo/Fix/Fixme',
    },
  },
}
