local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu-adapter')
local colors = require('colors.custom')
local fonts = require('config.fonts')

---@type Config
return {
   max_fps = 120,
   front_end = 'WebGpu', ---@type 'WebGpu' | 'OpenGL' | 'Software'
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick_best(),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Dx12', 'IntegratedGpu'),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Gl', 'Other'),
   underline_thickness = '1.5pt',

   -- cursor
   animation_fps = 120,
   cursor_blink_ease_in = 'EaseOut',
   cursor_blink_ease_out = 'EaseOut',
   default_cursor_style = 'BlinkingBar',
   cursor_blink_rate = 650,

   -- color scheme
   colors = colors,

   -- background
   background = {
      {
         source = { File = wezterm.config_dir .. '/backdrops/tree.png' },
         horizontal_align = 'Center',
         vertical_align = 'Middle',
      },
      {
         source = { Color = '#11111b' },
         height = '120%',
         width = '120%',
         vertical_offset = '-10%',
         horizontal_offset = '-10%',
         opacity = 0.96,
      },
   },

   -- scrollbar
   enable_scroll_bar = true,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = true, ---@type 'true' 会让 INTEGRATED_BUTTONS 以 Windows 原生比例渲染
   tab_max_width = 23,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- command palette
   command_palette_fg_color = '#b4befe',
   command_palette_bg_color = '#11111b',
   command_palette_font_size = 12,
   command_palette_rows = 25,

   -- window
   window_decorations = 'INTEGRATED_BUTTONS|RESIZE', -- 去掉原生标题栏，最小化/最大化/关闭按钮由 tab bar 渲染
   integrated_title_button_style = 'Windows',
   integrated_title_button_color = 'Auto',
   integrated_title_button_alignment = 'Right',
   window_padding = {
      left = 0,
      right = 0,
      top = 10,
      bottom = 7.5,
   },
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   window_frame = {
      active_titlebar_bg = '#11111b', -- Mocha crust（原 #090909 不属任何色板）
      inactive_titlebar_bg = '#11111b',
      font = fonts.font, -- fancy tab bar / 标题栏文字字体（含 Nerd Font 图标）
      font_size = fonts.font_size,
   },
   inactive_pane_hsb = {
      saturation = 1,
      brightness = 1,
   },

   visual_bell = {
      fade_in_function = 'EaseIn',
      fade_in_duration_ms = 250,
      fade_out_function = 'EaseOut',
      fade_out_duration_ms = 250,
      target = 'CursorColor',
   },
}
