return function()
  -- 关闭缩进
  vim.g.vimtex_indent_enabled = 0
  -- 使用 Zathura 作为 PDF 查看器
  vim.g.vimtex_view_method = 'zathura'
  -- 设置编译方法为 latexmk
  vim.g.vimtex_build_method = 'latexmk'
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
      '-auxdir=build',
    },
    engine = 'lualatex'
  }
  -- 启用 vimtex 补全
  vim.g.vimtex_complete_enabled = 1
  -- 启动 folding
  vim.g.vimtex_fold_enabled = 1
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "vimtex#fold#level()"
  vim.g.vimtex_fold_types = {
    envs = {
      blacklist = { "itemize", "enumerate", "description", "equation", "align", "align*", "gather", "multline" }
    },
  }
  
  -- 启动 vimtex 遮盖（conceal）
  vim.g.vimtex_syntax_conceal = {
    -- accents = 1,
    -- ligatures = 1,
    -- cites = 1,
    -- fancy = 1,
    -- spacing = 1,
    -- greek = 1,
    -- math_bounds = 1,
    -- math_delimiters = 1,
    -- math_fracs = 1,
    -- math_super_sub = 1,
    -- math_symbols = 1,
    sections = 1,
    -- styles = 1
  }
  vim.opt.conceallevel = 2
  -- vim.opt.concealcursor = ""
  vim.cmd [[
    highlight Conceal guifg=#ffffff guibg=NONE
    syntax match texMath "\\neq\>" conceal cchar=≠
  ]]
end
