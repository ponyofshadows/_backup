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
      '-file-line-error',
      '-interaction=nonstopmode',
      '-synctex=1',
      '-pv',
      '-silent',
      '-auxdir=build',
    },
    engine = 'pdflatex'
  }

  -- 使用默认的 quickfix 方法
  vim.g.vimtex_quickfix_method = 'latexlog'  -- 改为 latexlog（默认方法）
  vim.g.vimtex_quickfix_enabled = 1
  vim.g.vimtex_quickfix_mode = 2
  vim.g.vimtex_quickfix_autoclose_after_keystrokes = 0
  vim.g.vimtex_quickfix_open_on_warning = 0

  -- 过滤无用警告
  vim.g.vimtex_quickfix_ignore_filters = {
    'Underfull \\hbox',
    'Overfull \\hbox',
    'Package hyperref Warning',
    'Package babel Warning',
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
