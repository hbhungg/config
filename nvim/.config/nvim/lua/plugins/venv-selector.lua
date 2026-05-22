return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  ft = 'python',
  keys = { { '<leader>v', '<cmd>VenvSelect<cr>', desc = 'Select Python [V]env' } },
  opts = {
    options = {},
    search = {},
  },
}
