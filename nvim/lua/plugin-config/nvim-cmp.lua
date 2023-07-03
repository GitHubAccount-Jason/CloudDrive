local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = "BufEnter",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",


    }

    local cmp = require'cmp'
    local types = require('cmp.types')
    cmp.setup({

      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      window = {
        completion = {
          border ='rounded',
          winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
          zindex = 1001,
          scrolloff = 0,
          col_offset = 0,
          side_padding = 1,
          maxwidth = 50,
          maxheight = 16,
        },
        documentation = {
          border ='rounded',
          winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
          zindex = 1001,
          scrolloff = 0,
          col_offset = 0,
          side_padding = 1,
          maxwidth = 50,
          maxheight = 16,
        }
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            ultisnips = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          local MAX_LABEL_WIDTH = 50
          local MIN_LABEL_WIDTH = 10
          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
          if truncated_label ~= label then
            label = truncated_label .. "..."
          elseif string.len(label) < MIN_LABEL_WIDTH then
            local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            vim_item.abbr = label .. padding
          end
          while string.sub(label, 1, 1) == " " do
            label = string.sub(label, 2, -1)
          end
          label = string.format(" %s", label)
          vim_item.abbr = label
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
      ,
      sources =
        {
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
          { name = 'path'},
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp_signature_help' },

        }
      ,
      experimental = {
        ghost_text = true
      },

    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources(
        {
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        },
        {
          { name = 'buffer' },
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        }
      )
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
          { name = 'cmdline' }
        })
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require('lspconfig')['clangd'].setup {
      root_dir = function(fname)
        return [[
        'E:/SH_Directory/compile_flags.txt',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
      ]]
      end,
      cmd = {
        "clangd",
        "--clang-tidy",
        "--completion-style=bundled",
        "--function-arg-placeholders=false",
        "--ranking-model=heuristics",
        "--header-insertion=never",
        "--pch-storage=memory",
        "--log=error",
        "--j=4",
        "--background-index",
        "--query-driver=E:/SH_Directory/MinGW/mingw64/bin/*"
      }
    }
    require'lspconfig'.lua_ls.setup {
      settings = {
        Lua = {

          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
    local cap_html = vim.lsp.protocol.make_client_capabilities()
    cap_html.textDocument.completion.completionItem.snippetSupport = true

    require'lspconfig'.html.setup {
      capabilities = cap_html,
    }
    cmp.event:on(
      'confirm_done',
      require('nvim-autopairs.completion.cmp').on_confirm_done()
    )
    require("plugin-config.lsp.handlers").setup()
    -- use lspsaga
    -- require("plugin-config.lsp.keybinding")

  end
}
