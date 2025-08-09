-- 设置剪贴板提供者为 wl-clipboard
vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste --no-newline',
    ['*'] = 'wl-paste --no-newline',
  },
  cache_enabled = 0,
}

-- 设置默认使用系统剪贴板
vim.opt.clipboard = 'unnamedplus'
