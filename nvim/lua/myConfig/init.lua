require("myConfig.set")
require("myConfig.packer")
require("myConfig.telescope")
require("myConfig.lualine")
require("myConfig.nvimtree")
require("myConfig.debugger")
require("myConfig.git")
require("myConfig.colorizer")
require("myConfig.neotest")
require("myConfig.comment")
-- require("myConfig.colors")
require("myConfig.sidebar")
require("myConfig.barbar")
require("myConfig.neosolar")
require("myConfig.markdown")
require("myConfig.indentLine")
require("myConfig.lspsaga")


--vim.cmd.colorscheme("tokyonight-moon")
-- .conf syntax highlight configurations
vim.cmd([[autocmd BufRead,BufNewFile *.conf set filetype=dosini]])
-- Terrafrom configurations
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])

require("deploy").setup()
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
