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
  -- Copilot 主插件
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
            next = "<C-9>", -- Ctrl+9 下一个建议
            prev = "<C-0>", -- Ctrl+0 上一个建议
            dismiss = "<C-c>", -- Ctrl+c 取消建议
          },
          disable_on_esc = true,  -- 关键设置：按ESC时禁用Copilot建议
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
          --["."] = false, -- 禁用文件名中带点的文件
        },
        -- 复制设置
        copilot_node_command = 'node', -- 使用系统 Node
        server_opts_overrides = {}, -- 服务器选项覆盖
      })
      
      -- 设置默认禁用 Copilot (延迟执行确保初始化完成)
      vim.defer_fn(function()
        vim.cmd("Copilot disable")
        vim.g.copilot_enabled = false
      end, 500)
      
      -- Copilot 切换功能
      local function toggle_copilot()
        local enabled = vim.g.copilot_enabled or false
        
        if enabled then
          -- 禁用 Copilot
          vim.cmd("Copilot disable")
          vim.g.copilot_enabled = false
          vim.notify("Copilot 已禁用", vim.log.levels.INFO)
        else
          -- 启用 Copilot
          vim.cmd("Copilot enable")
          vim.g.copilot_enabled = true
          vim.notify("Copilot 已启用", vim.log.levels.INFO)
        end
      end
      
      -- 添加状态查看功能
      local function show_copilot_status()
        local status = vim.g.copilot_enabled and "已启用" or "已禁用"
        vim.notify("Copilot: " .. status, vim.log.levels.INFO)
      end
      
      -- 设置快捷键
      vim.keymap.set("n", "<leader>cp", toggle_copilot, { 
        noremap = true, 
        silent = true, 
        desc = "Toggle Copilot" 
      })
      
      vim.keymap.set("n", "<leader>cs", show_copilot_status, { 
        noremap = true, 
        silent = true, 
        desc = "Show Copilot Status" 
      })
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      show_help = true,
      mappings = {
        close = "q",
        --reset = "<C-l>",
        --complete = "<Tab>",
        submit_prompt = "<CR>",
        accept_diff = "<C-a>",
        show_diff = "<C-s>",
      },
    },
    keys = {
      -- 添加键位映射以打开 Copilot Chat
      { "<leader>cc", "<cmd>CopilotChat<CR>", desc = "CopilotChat - Open" },
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
      { "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "CopilotChat - Fix code" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
    }, 
  },
  -- debug
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
      },
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python", -- Python DAP
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 虚拟文本
      require("nvim-dap-virtual-text").setup()

      -- mason 配置
      require("mason").setup()
      require("mason-nvim-dap").setup({ automatic_installation = true })

      -- dap-ui 配置
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- 快捷键
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

      -- ========== Python ==========
      local dap_python = require("dap-python")
      -- 指向系统 python-debugpy
      dap_python.setup("python")  -- 或者 python3

      -- ========== Rust/C++ ==========
      local mason_registry = require("mason-registry")
      local codelldb_path = vim.fn.exepath("codelldb") -- 如果用 AUR 安装
      if codelldb_path == "" then
        vim.notify("codelldb not found in PATH", vim.log.levels.WARN)
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = {"--port", "${port}"},
          detached = false,
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch Rust binary",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.cpp = dap.configurations.rust
      dap.configurations.c = dap.configurations.rust
    end,
  },

}
)
