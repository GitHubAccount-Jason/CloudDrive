return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = "BufEnter",
  dependencies = {
    "HiPhish/nvim-ts-rainbow2"
  },
  config = function ()
    require'nvim-treesitter.configs'.setup {
      -- 安装 language parser
      -- :TSInstallInfo 命令查看支持的语言
      ensure_installed = {"c","cpp","javascript","lua","tsx","typescript","vim","python","css"},
      -- 启用代码高亮功能
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      -- 启用增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = '<TAB>',
        }
      },
      -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
      indent = {
        enable = true
      },
      rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = 'rainbow-parens',
        -- Highlight the entire buffer all at once
        strategy = require('ts-rainbow').strategy.global,
        hlgroups = {
          'TSRainbowYellow',
          'TSRainbowBlue',
          'TSRainbowOrange',
          'TSRainbowGreen',
          'TSRainbowViolet',
          'TSRainbowCyan',
          'TSRainbowRed',
        },
      }
    }
    require("nvim-treesitter.install").prefer_git = true
  end
}
