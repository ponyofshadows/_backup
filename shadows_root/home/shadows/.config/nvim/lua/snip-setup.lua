require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true, -- 开启自动展开
})

-- load snippets
require("luasnip.loaders.from_lua").lazy_load({
  paths = "~/.config/nvim/snippets/tex",
  ft = {"tex", "latex"}
})
