-- File: lua/plugins/colorscheme.lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("aesthetic-night")
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- Define the palette directly here for Lualine
      local p = {
        black = "#1C252C",
        bright_black = "#484E5B",
        red = "#DF5B61",
        green = "#78B892",
        yellow = "#DE8F78",
        blue = "#6791C9",
        magenta = "#BC83E3",
        cyan = "#67AFC1",
        white = "#D9D7D6",
        bright_white = "#E5E5E5",
      }

      opts.options.theme = {
        normal = {
          a = { fg = p.black, bg = p.blue, gui = "bold" },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
        insert = {
          a = { fg = p.black, bg = p.green, gui = "bold" },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
        visual = {
          a = { fg = p.black, bg = p.magenta, gui = "bold" },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
        replace = {
          a = { fg = p.black, bg = p.red, gui = "bold" },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
        command = {
          a = { fg = p.black, bg = p.yellow, gui = "bold" },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
        inactive = {
          a = { fg = p.white, bg = p.bright_black },
          b = { fg = p.white, bg = p.bright_black },
          c = { fg = p.white, bg = p.bright_black },
        },
      }
    end,
  },
}
