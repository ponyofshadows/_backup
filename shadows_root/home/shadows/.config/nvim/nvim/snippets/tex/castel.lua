local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local d = ls.dynamic_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- 处理 A12 -> A_{12}
  s({
    trig = "([A-Za-z])_(%d)(%d)",  -- 触发条件：字母_数字+数字
    regTrig = true,               -- 启用正则匹配
    wordTrig = false,             -- 允许匹配单词的一部分
    snippetType = "autosnippet",  -- 让其自动替换
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. snip.captures[3] .. "}"
    end)
  }),

  -- 处理 A1 -> A_1
  s({
    trig = "([A-Za-z])(%d)",  -- 触发条件：字母+单个数字
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return snip.captures[1] .. "_" .. snip.captures[2]
    end)
  }),
}
