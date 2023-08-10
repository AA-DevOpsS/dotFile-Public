require("myConfig")
-- terraform configs
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])
vim.api.nvim_command('autocmd BufRead,BufNewFile *.tf set filetype=terraform')

-- Disable horizontal scrolling
vim.api.nvim_command("nnoremap <ScrollWheelLeft> <Nop>")
vim.api.nvim_command("nnoremap <ScrollWheelRight> <Nop>")
