-- A slightly altered version of catppucchin mocha
-- stylua: ignore
local mocha = {
   rosewater = '#f5e0dc',
   flamingo  = '#f2cdcd',
   pink      = '#f5c2e7',
   mauve     = '#cba6f7',
   red       = '#f38ba8',
   maroon    = '#eba0ac',
   peach     = '#fab387',
   yellow    = '#f9e2af',
   green     = '#a6e3a1',
   teal      = '#94e2d5',
   sky       = '#89dceb',
   sapphire  = '#74c7ec',
   blue      = '#89b4fa',
   lavender  = '#b4befe',
   text      = '#cdd6f4',
   subtext1  = '#bac2de',
   subtext0  = '#a6adc8',
   overlay2  = '#9399b2',
   overlay1  = '#7f849c',
   overlay0  = '#6c7086',
   surface2  = '#585b70',
   surface1  = '#45475a',
   surface0  = '#313244',
   base      = '#1f1f28',
   mantle    = '#181825',
   crust     = '#11111b',
}

local colorscheme = {
   foreground = mocha.text,
   background = mocha.base,
   cursor_bg = mocha.rosewater,
   cursor_border = mocha.rosewater,
   cursor_fg = mocha.crust,
   selection_bg = mocha.surface2,
   selection_fg = mocha.text,
   -- ANSI 0-15 采用 Catppuccin Mocha 官方终端映射（catppuccin/kitty themes/mocha.conf）。
   -- 原先是 Windows "Campbell" 色板，与 Mocha 的窗口/标签栏不是一套东西：
   -- git diff、ls --color 的饱和红绿蓝会和背景明显打架。
   ansi = {
      '#45475a', -- black   surface1
      '#f38ba8', -- red
      '#a6e3a1', -- green
      '#f9e2af', -- yellow
      '#89b4fa', -- blue
      '#f5c2e7', -- magenta (Mocha 用 pink)
      '#94e2d5', -- cyan    (Mocha 用 teal)
      '#bac2de', -- white   subtext1
   },
   brights = {
      '#585b70', -- black   surface2
      '#f38ba8', -- red
      '#a6e3a1', -- green
      '#f9e2af', -- yellow
      '#89b4fa', -- blue
      '#f5c2e7', -- magenta
      '#94e2d5', -- cyan
      '#a6adc8', -- white   subtext0
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.4)',
      active_tab = {
         bg_color = mocha.surface2,
         fg_color = mocha.text,
      },
      inactive_tab = {
         bg_color = mocha.surface0,
         fg_color = mocha.subtext1,
      },
      inactive_tab_hover = {
         bg_color = mocha.surface0,
         fg_color = mocha.text,
      },
      new_tab = {
         bg_color = mocha.base,
         fg_color = mocha.text,
      },
      new_tab_hover = {
         bg_color = mocha.mantle,
         fg_color = mocha.text,
         italic = true,
      },
   },
   visual_bell = mocha.red,
   indexed = {
      [16] = mocha.peach,
      [17] = mocha.rosewater,
   },
   scrollbar_thumb = mocha.surface2,
   split = mocha.overlay0,
   compose_cursor = mocha.flamingo,
}

return colorscheme
