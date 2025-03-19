-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins managed by lazy, see https://github.com/folke/lazy.nvim
require("lazy").setup(
{
  "kevinhwang91/rnvimr", -- communicate with ranger
  "hrsh7th/nvim-cmp",
  {
    "neovim/nvim-lspconfig",
    dependencies = {"hrsh7th/cmp-nvim-lsp",}
  },
  {
 "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {"saadparwaiz1/cmp_luasnip",}
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    'lervag/vimtex',
    init = require("plugins.vimtex-setup")
  },
  "micangl/cmp-vimtex",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}
)
