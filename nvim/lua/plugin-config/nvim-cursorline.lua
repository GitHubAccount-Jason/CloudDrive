return {
  "yamatsum/nvim-cursorline",
  config = function ()
    require('nvim-cursorline').setup {
      cursorline = {
      enable = true,
      timeout = 100,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = {
          bg = "#154360",
          underline = false,
      },
    }
  }
  end
}
