-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
    init = require("vimtex-setup")
  },
  "micangl/cmp-vimtex",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    }
  },
  
  -- 第三方 Copilot 实现 - 核心组件
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- 面板设置（显示多个建议）
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>", -- Alt+Enter 打开建议面板
          },
          layout = {
            position = "bottom", -- 面板位置: top | bottom | left | right
            ratio = 0.4, -- 面板高度比例
          },
        },
        -- 内联建议设置
        suggestion = {
          enabled = true,
          auto_trigger = true, -- 自动触发建议
          debounce = 75, -- 建议延迟（毫秒）
          keymap = {
            accept = "<C-j>", -- Ctrl+j 接受建议
            accept_word = "<C-l>", -- Ctrl+l 接受单词
            accept_line = "<C-\\>", -- Ctrl+\ 接受整行
            next = "<C-]>", -- Ctrl+] 下一个建议
            prev = "<C-[>", -- Ctrl+[ 上一个建议
            dismiss = "<C-c>", -- Ctrl+c 取消建议
          },
        },
        -- 文件类型设置（哪些文件类型启用/禁用）
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false, -- 禁用文件名中带点的文件
        },
        -- 复制设置
        copilot_node_command = 'node', -- 使用系统 Node
        server_opts_overrides = {}, -- 服务器选项覆盖
      })
    end,
  },
  
  -- 第三方 Copilot 与 nvim-cmp 的集成
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { 
      "zbirenbaum/copilot.lua",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling", -- 建议方法
        formatters = {
          label = require("copilot_cmp.format").format_label_text, -- 格式化标签
          insert_text = require("copilot_cmp.format").format_insert_text, -- 格式化插入文本
          preview = require("copilot_cmp.format").deindent, -- 格式化预览
        },
      })
    end,
  }
})

-- Set up nvim-cmp based on your existing configuration
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<A-Tab>'] = function(fallback)
      if luasnip.jumpable(1) then  -- 如果有可跳转的占位符，则执行跳转
        luasnip.jump(1)
      else
        fallback()  -- 否则调用fallback，不触发补全
      end
    end,
    ['<A-Space>'] = function()
      if cmp.visible() then
        cmp.abort()  -- 如果补全菜单显示，按下将关闭补全菜单
      else
        cmp.complete()  -- 如果补全菜单未显示，按下将强制打开补全菜单
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 }, -- Copilot 源 (添加)
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'nvim_lsp' },
    { name = 'vimtex' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- 添加源名称
      vim_item.menu = ({
        copilot = "[AI]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
        vimtex = "[Tex]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if installed
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
