return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      view = { side = 'right' },
      renderer = {
        icons = {
          show = { file = false, folder = false, folder_arrow = true, git = false },
          glyphs = {
            folder = { arrow_closed = '>', arrow_open = 'v' },
          },
        },
      },
    }
    vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', { desc = '[T]oggle [T]ree', silent = true })
  end,
}
