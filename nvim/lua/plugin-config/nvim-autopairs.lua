return {
  "windwp/nvim-autopairs",
  config = function()
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    npairs.setup({
      enable_check_bracket_line = true,
      ignored_next_char = ""
    })
  end
}
