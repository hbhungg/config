return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    require('vscode').setup { disable_nvimtree_bg = true }
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'vscode'
  end,
}
