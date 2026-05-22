return {
  'romus204/tree-sitter-manager.nvim',
  opts = {
    ensure_installed = {
      'html',
      'luadoc',
      'markdown_inline',
      'typescript',
      'python',
      'java',
      'terraform',
      'hcl',
    },
    auto_install = true,
    highlight = true,
  },
}
