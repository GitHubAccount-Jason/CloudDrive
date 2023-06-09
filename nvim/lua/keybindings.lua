
local opt ={noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>sl', ":Lspsaga show_line_diagnostics<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>gD', ":Lspsaga peek_definition<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>gd', ":Lspsaga goto_definition<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>K',  ":Lspsaga hover_doc<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>gT', ":Lspsaga peek_type_definition<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>gt', ":Lspsaga goto_type_definition<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>rn', ":Lspsaga rename<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>ca', ":Lspsaga code_action<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>lf', ":Lspsaga lsp_finder<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>gr', ":lua vim.lsp.references<CR>", opt)
vim.api.nvim_set_keymap('v', '<Leader>cm', ":CommentToggle<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>hw', ":HopWord<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>hc', ":HopChar1<CR>", opt)
vim.api.nvim_set_keymap('i', '<C-h>w', "<cmd>HopWord<CR>", opt)
vim.api.nvim_set_keymap('i', '<C-h>c', "<cmd>HopChar1<CR>", opt)
vim.api.nvim_set_keymap('n', 'gt', "<cmd>bn<CR>", opt)
vim.api.nvim_set_keymap('n', 'gT', "<cmd>bp<CR>", opt)
vim.api.nvim_set_keymap('n', '<Leader>h', "<cmd>bp<CR>", opt)

