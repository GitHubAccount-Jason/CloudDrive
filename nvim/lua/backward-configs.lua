for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
end
vim.cmd('hi! link SagaNormal NONE')
vim.cmd('hi! SagaNormal guibg=f44747')
vim.cmd("imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")
vim.cmd("smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")
vim.cmd('set nosmd')

