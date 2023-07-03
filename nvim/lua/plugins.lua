
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = { import = "plugin-config" },
  ui = {
   border = "rounded"
  },
  {"equalsraf/neovim-gui-shim"},
  {"navarasu/onedark.nvim"},
  {"windwp/nvim-autopairs"},
  {"nvim-telescope/telescope.nvim"},
  {"nvim-treesitter/nvim-treesitter", lazy = true, event = "BufEnter"},
  {"nvim-treesitter/playground", lazy = true, dependencies = {"nvim-treesitter/nvim-treesitter"}},
  {"neovim/nvim-lspconfig"},
  {"williamboman/mason.nvim"},
  {"hrsh7th/nvim-cmp"},
  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    branch = "main",
    event = "LspAttach",
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    },
  },
  {"nvim-tree/nvim-tree.lua"},
  {"akinsho/bufferline.nvim", dependecies= "nvim-tree/nvim-web-devicons", lazy = true, event = "BufEnter"},
  {"nvim-lualine/lualine.nvim"},
  {"terrortylor/nvim-comment", lazy = true},
  {"phaazon/hop.nvim", lazy = true},
  {
    "iamcco/markdown-preview.nvim",
    -- I've already done it by myself.
    -- init = function() vim.fn["mkdp#util#install"]() end,
  },
  { "lukas-reineke/indent-blankline.nvim" },
  {"HiPhish/nvim-ts-rainbow2"},
  {"kylechui/nvim-surround"},
  {"yamatsum/nvim-cursorline"},
  {
    "folke/which-key.nvim",

  },
})


require ("keybindings")
