local Remap = require("myConfig.keymap")
local map = vim.api.nvim_set_keymap

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local snoremap = Remap.snoremap
local sinoremap = Remap.sinoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

local function kmap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local builtin = require('telescope.builtin')
local neogit = require('neogit')
local ls = require('luasnip')
local neotest = require('neotest')

local dap = require('dap')
local telescopeDap = require('telescope').extensions.dap
local dapui = require("dapui")

function Execute()
    local type = vim.bo.filetype
    local progsByExtention = {
        ["javascript"] = "node",
        ["lua"] = "lua",
        ["php"] = "php",
        ["sh"] = "bash",
        ["py"] = "python",
        ["go"] = "go run"
    }
    local prog = progsByExtention[type]
    if prog then
        vim.cmd.write()
        vim.cmd("! " .. prog .. " %")
    else
        print(type)
    end
end

-- General
inoremap("<C-c>", "<Esc>")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
nnoremap("<C-j>", "<cmd>cnext<CR>zz")
nnoremap("<C-k>", "<cmd>cprev<CR>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

xnoremap("<leader>p", "\"_dP")

nnoremap('<leader>n', nil, nil, 'Nvim General')
-- Neovim Tree
nnoremap("<leader>t", function() vim.cmd.NvimTreeToggle() end, { silent = false }, "Toggle Nvim Tree")

-- undo tree
nnoremap("<leader>nu", function() vim.cmd.UndotreeToggle() end, { silent = false }, "Undo Tree")

-- Telescope
nnoremap("<leader>p", nil, nil, "File")
nnoremap('<leader>pp', function() require 'telescope'.extensions.project.project() end, {}, "Projects")
nnoremap('<leader>ff', function() builtin.find_files() end, {}, 'Find File')
nnoremap('<leader>fc', function() builtin.find_files({ cwd = "~/.config/nvim" }) end, {}, 'Find nvim Config file ')
nnoremap('<leader>fg', function() builtin.live_grep() end, {}, 'Live Grep')
nnoremap('<leader>fb', function() builtin.buffers() end, {}, 'Buffers')
nnoremap('<leader>fh', function() builtin.help_tags() end, {}, 'Help Tags')
nnoremap('<leader>fw', function() builtin.grep_string() end, {}, '[S]earch current [W]ord')
nnoremap('<leader>?', function() builtin.oldfiles() end, {}, '[?] Find recently opened files')
nnoremap('<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
    })
end, {}, '[/] Fuzzily search in current buffer]')

-- Upload
nnoremap('<leader>u', nil, nil, 'Deployment')
nnoremap("<leader>uf", function() vim.cmd.UploadFile() end, { silent = false }, "Upload File")
nnoremap("<leader>ud", function() vim.cmd.DownloadFile() end, { silent = false }, "Download File")
nnoremap("<leader>us", function() vim.cmd.SyncRemote() end, { silent = false }, "Sync Remote")
nnoremap("<leader>ur", function() vim.cmd.ExecuteRemoteFile() end, { silent = false }, "Sync Remote")

-- Git
--nnoremap("<leader>g", nil, nil, "Git")
nnoremap("<leader>gg", function() neogit.open() end, { silent = false })
nnoremap("<leader>gl", function() vim.cmd.LazyGit() end, { silent = false })
nnoremap('<leader>gB', function() builtin.git_branches() end, {}, "Branches")
nnoremap('<leader>gs', function() builtin.git_status() end, {}, "Status")
nnoremap('<leader>gb', function() vim.cmd.GitBlameToggle() end, {}, "Git Blame")


--nnoremap("<leader>gd", nil, nil, "Diff")
nnoremap('<leader>gdo', " <cmd>DiffviewOpen<CR>", {}, "Open")
nnoremap('<leader>gdc', " <cmd>DiffviewClose<CR>", {}, "Close")
nnoremap('<leader>gdb', " <cmd>DiffviewFileHistory<CR>", {}, "Branch")
nnoremap('<leader>gdf', " <cmd>DiffviewFileHistory %<CR>", {}, "File")
nnoremap('<leader>gdt', " <cmd>DiffviewToggleFiles<CR>", {}, "Toggle Diff Files")
nnoremap('<leader>gdr', " <cmd>DiffviewRefresh<CR>", {}, "Refresh")

-- Debugger
--nnoremap("<leader>d", nil, nil, "Debugger")
nnoremap("<leader>db", function() dap.toggle_breakpoint() end, { silent = true }, "Add/Remove Breakpoint")
nnoremap("<leader>dr", function() dapui.toggle({}) end, { silent = true }, "Open/Close Dap UI")
nnoremap("<leader>dR", function() dap.run_last() end, { silent = true }, "Run Last")
nnoremap("<leader>dk", function() dapui.eval() end, { silent = true }, "")
nnoremap("<leader>dK", function() dapui.eval(vim.fn.input('Eval Expression: '), {}) end, { silent = true }, "")
nnoremap("<Leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true },
    "")
nnoremap("<Leader>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { silent = true }, "")

nnoremap("<F1>", function() dap.continue() end, { silent = true }, "Debug/Continue")
nnoremap("<F2>", function() dap.step_into() end, { silent = true }, "Step Into")
nnoremap("<F3>", function() dap.step_over() end, { silent = true }, "Step Over")
nnoremap("<F4>", function() dap.step_out() end, { silent = true }, "Step Out")

nnoremap("<leader>dlb", function() telescopeDap.list_breakpoints() end, { silent = true }, "Breakpoints List")
nnoremap("<leader>dlv", function() telescopeDap.variables() end, { silent = true }, "Variables List")

nnoremap("<leader>di", function() telescopeDap.configurations() end, { silent = true }, "Config")
nnoremap("<leader>dC", function() telescopeDap.commands() end, { silent = true }, "Commands")
nnoremap("<leader>dlf", function() telescopeDap.frames() end, { silent = true })

-- lsp
--nnoremap("<leader>l", nil, nil, "LSP")
nnoremap("<leader>li", function() vim.cmd.Mason() end, { silent = true }, "Lsp Install Info")

-- Snippets
sinoremap("<c-k>", function() if ls.expand_or_jumpable() then ls.expand_or_jump() end end, { silent = true }, "")
sinoremap("<C-j>", function() if ls.jumpable(-1) then ls.jump(-1) end end, { silent = true }, "")
sinoremap("<C-l>", function() if ls.choice_active() then ls.change_choice(1) end end, { silent = true }, "")


nnoremap("<leader><leader>s", function() vim.cmd.source("~/.config/nvim/after/plugin/luasnip.lua") end, { silent = true },
"Load snippets")

function LspKeyMap()
    -- Tests
    --nnoremap('<leader>t', nil, nil, 'Tests')
    -- nnoremap('<leader>to', function() neotest.output_panel.toggle() end, nil, 'Panel Toggle')
    -- nnoremap('<leader>tr', function() neotest.run.run() end, nil, 'Start')
    -- nnoremap('<leader>tf', function() neotest.run.run(vim.fn.expand("%:@:p")) end, nil, 'Start Current File')
    -- nnoremap('<leader>tF', function() neotest.run.run(vim.fn.expand("%:p:h")) end, nil, 'Start Current Folder')
    -- nnoremap('<leader>td', function() neotest.run.run({ vim.fn.expand("%:@:p"), dap = true }) end, nil, 'Debug Current File')
    -- nnoremap('<leader>ts', function() neotest.run.stop() end, nil, 'Stop')
    -- nnoremap('<leader>tk', function() neotest.output.open() end, nil, 'Output')
    -- nnoremap('<leader>tt', function() neotest.summary.toggle() end, nil, 'Adapters')

    -- General LSP config
    nnoremap("gd", function() vim.lsp.buf.definition() end, {}, "Definition")
    nnoremap("gD", function() vim.lsp.buf.declaration() end, {}, "Declaration")
    nnoremap("gr", function() builtin.lsp_references() end, {}, "References")
    nnoremap("gi", function() vim.lsp.buf.implementation() end, {}, "Implementation")

    nnoremap('<leader>ls', function() builtin.lsp_document_symbols() end, {}, '[D]ocument [S]ymbols')
    nnoremap('<leader>la', function() vim.lsp.buf.code_action() end, {}, '[D]ocument [S]ymbols')
    nnoremap('<leader>lr', function() vim.lsp.buf.rename() end, {}, '[D]ocument [S]ymbols')
    nnoremap("K", function() vim.lsp.buf.hover() end)

    nnoremap("<leader>lh", function() vim.lsp.buf.signature_help() end, {}, "Signature Help")
    nnoremap("<leader>lR", function() vim.lsp.buf.workspace_symbol() end, {}, "Workspace")
    nnoremap('<leader>lS', function() builtin.lsp_dynamic_workspace_symbols() end, {}, '[W]orkspace [S]ymbols')
    -- Diagnostics
    nnoremap("<leader>eo", function() vim.diagnostic.open_float() end, {}, "Floating Diagnostic")
    nnoremap("<leader>en", function() vim.diagnostic.goto_next() end, {}, "Next Issue")
    nnoremap("<leader>ep", function() vim.diagnostic.goto_prev() end, {}, "Prev Issue")
    nnoremap('<leader>ed', function() builtin.diagnostics() end, {}, 'Diagnostics List')

    -- Code Assists
    nnoremap('<leader>c', nil, nil, 'Code')
    nnoremap('<leader>cc', function() vim.cmd.ColorizerToggle() end, nil, 'Color')
    nnoremap("<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true }, "chmod +x")
    nnoremap("<leader>cr", function() Execute() end, { silent = false }, "Execute")
    nnoremap("<leader>cf", function() vim.lsp.buf.format() end, {}, "Format")
    -- nnoremap("<leader>cf", function() vim.lsp.buf.format() end, {}, "Format")
    nnoremap("<leader>cn", function() vim.lsp.buf.rename() end, {}, "Rename")
    nnoremap("<leader>cs", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {}, "Replace Current Word")
end

    nnoremap('<tab>j', function() vim.cmd.BufferPrevious() end, nil)
    nnoremap('<tab>k', function() vim.cmd.BufferNext() end, nil)
local opts = { noremap = true, silent = true }
--barbar
-- map('n', '<A-j>', '<Cmd>BufferPrevious<CR>', opts)
-- map('n', '<A-k>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout    
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
vim.api.nvim_set_keymap('n', '<C-w><N>', '<NOP>', { noremap = true, silent = true })

-- Windows Navigationset clipboard+=unnamedplus
-- kmap("n", "<C-h>", "<C-w>h")
-- kmap("n", "<C-l>", "<C-w>l")
-- kmap("n", "<C-k>", "<C-w>k")
-- kmap("n", "<C-j>", "<C-w>j")

-- Resize Windows
kmap("n", "<C-Right>", "<C-w><")
kmap("n", "<C-Left>", "<C-w>>")
kmap("n", "<C-Down>", "<C-w>+")
kmap("n", "<C-Up>", "<C-w>-")


-- Ctrl + c copy to clipboard
-- KDE Wayland
-- map('v', '<C-c>', ':%y+<CR>', opts)
-- KDE X11 Ensure xclip is installed
map('v', '<C-c>', '"+y', { noremap = true })
-- Gnome Wayland Ensure wl-clipboard is installed
-- map('v', '<C-c>', ':w !wl-copy<CR>', opts)

-- markdown preview
map('n', '<Space>mp', '<Cmd>MarkdownPreviewToggle<CR>', opts)
-- disable Horizontal Scroll
map('n', '<ScrollWheelRight>', '<Nop>', { silent = true })
map('n', '<ScrollWheelLeft>', '<Nop>', { silent = true })

