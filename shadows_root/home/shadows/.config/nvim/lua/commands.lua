-- 编译 LaTeX 文档
vim.api.nvim_create_user_command(
  'CompileLatex',
  function()
    vim.cmd('w')
    -- 使用 latexmk 编译，指定输出文件与 .tex 同目录，辅助文件在 ./aux 目录
    vim.cmd('!latexmk -pdf -xelatex -shell-escape -verbose -file-line-error -interaction=nonstopmode -synctex=1 -outdir=. -auxdir=aux %:t')
  end,
  {}
)
-- 用 zathura 打开 PDF 预览
vim.api.nvim_create_user_command(
  'ViewPDF',
  function()
    vim.cmd('!zathura %:r.pdf &')
  end,
  {}
)
-- 使用 <leader>cc 编译 LaTeX 文档
vim.api.nvim_set_keymap('n', '<leader>lc', ':CompileLatex<CR>', { noremap = true, silent = true })
-- 使用 <leader>vv 打开 PDF 预览
vim.api.nvim_set_keymap('n', '<leader>lv', ':ViewPDF<CR>', { noremap = true, silent = true })


-- 定义前向搜索命令
vim.api.nvim_create_user_command(
  'ForwardSearch',
  function()
    local filename = vim.fn.expand('%:p')  -- 获取当前文件的绝对路径
    local line = vim.fn.line('.')             -- 获取当前光标所在的行
    -- 使用 vim.fn.system 执行命令，确保没有输出
    vim.fn.system('zathura --synctex-forward ' .. line .. ':1:' .. filename .. ' ' .. filename:gsub('.tex$', '.pdf') .. ' &')
  end,
  {}
)

-- 使用 <leader>fs 作为快捷键来执行前向搜索命令
vim.api.nvim_set_keymap('n', '<leader>]', ':ForwardSearch<CR>', { noremap = true, silent = true })

