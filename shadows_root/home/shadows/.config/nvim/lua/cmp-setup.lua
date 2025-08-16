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
