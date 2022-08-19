require('lualine').setup{
  options = {
    theme = 'nord',
    component_separators = { left = '', right = ''},
  },
  tabline = {
    lualine_a = {
      {'buffers',
          mode = 2,
          buffers_color = {
            -- active    = {fg = '#000000', bg = '#112233'},
            inactive = { fg = '#E5E9F0' , bg = '#4C566A'},
          }
      },
  },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {'tabs',
          tabs_color = {
            -- active    = {fg = '#000000', bg = '#112233'},
            inactive = { fg = '#E5E9F0' , bg = '#4C566A'},
          },
      },
    }
  },
}
