return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'typescript',
      'python',
      'java',
      'terraform',
      'hcl',
    },
    auto_install = true,
    highlight = {
      enable = true,
      -- Ruby's indent rules depend on vim's regex highlighter.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = false, disable = { 'ruby' } },
  },
}
