return {
  "williamboman/mason.nvim",
  dependencies = {"williamboman/mason-lspconfig.nvim"} ,
  lazy = true,
  cmd = "Mason",
  event = "LspAttach",
  config = function()
    -- :h mason-default-settings
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded"
      },
    })
    -- mason-lspconfig uses the `lspconfig` server names in the apis it exposes - not `mason.nvim` package names
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
    require("mason-lspconfig").setup({
      -- 确保安装，根据需要填写
      ensure_installed = {
        -- "sumneko_lua",
        -- "clangd",
      },
    })
    -- setup language servers.
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup {}
    lspconfig.lua_ls.setup{  settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },}
    lspconfig.tsserver.setup{}

    -- global mappings.
    -- see `:help vim.diagnostic.*` for documentation on any of the below functions
    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- use lspattach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('lspattach', {
      group = vim.api.nvim_create_augroup('userlspconfig', {}),
      callback = function(ev)
        -- enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- buffer local mappings.
        -- see `:help vim.lsp.*` for documentation on any of the below functions
        -- local opts = { buffer = ev.buf }
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        -- vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<space>f', function()
        --   vim.lsp.buf.format { async = true }
        -- end, opts)
      end,
    })
  end
}
