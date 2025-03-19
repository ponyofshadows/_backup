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
    init = function()
      -- Vimtex 配置
      -- 使用 Zathura 作为 PDF 查看器
      vim.g.vimtex_view_method = 'zathura' 

      -- 设置编译方法为 latexmk
      vim.g.vimtex_build_method = 'latexmk' 
      -- 指定编译引擎
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = '-xelatex',  -- 设置默认引擎为 xelatex
      }
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        options = {
          '-shell-escape',
          '-verbose',
          '-file-line-error',
          '-interaction=nonstopmode',
          '-synctex=1',
          '-auxdir=aux',
        },
        engine = 'xelatex'
      }
      -- 启用 Vimtex 完成
      vim.g.vimtex_complete_enabled = 1 
    end
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
