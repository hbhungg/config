return {
  'stevearc/oil.nvim',
  -- Not lazy: oil takes over directory buffers (e.g. `nvim .`), so it must
  -- be loaded at startup. Netrw is already disabled in init.lua.
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { '<leader>te', '<cmd>Oil<cr>', desc = '[T]ree [E]dit (oil)' },
  },
}
