if not vim.fn.exists('g:neovide') then
  return
end

-- See https://neovide.dev/configuration.html

-- vim.g.neovide_refresh_rate = 120

vim.g.neovide_cursor_vfx_mode = 'railgun'
-- vim.g.neovide_cursor_vfx_mode = "torpedo"
-- vim.g.neovide_cursor_vfx_mode = 'pixiedust'
-- vim.g.neovide_cursor_vfx_mode = "sonicboom"
-- vim.g.neovide_cursor_vfx_mode = "ripple"
-- vim.g.neovide_cursor_vfx_mode = "wireframe"

-- vim.g.neovide_cursor_vfx_opacity = 200.0
-- vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
-- vim.g.neovide_cursor_vfx_particle_density = 200
-- vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- only for railgun
-- vim.g.neovide_cursor_vfx_particle_curl = 8.0 -- only for railgun
-- vim.g.neovide_cursor_vfx_particle_speed = 10.0

vim.g.neovide_cursor_antialiasing = true

-- vim.g.neovide_text_gamma = 0.0
-- vim.g.neovide_text_contrast = 0.5

-- local padding = 16
-- vim.g.neovide_padding_top = padding
-- vim.g.neovide_padding_bottom = padding
-- vim.g.neovide_padding_right = 0  -- padding
-- vim.g.neovide_padding_left = padding

-- vim.g.neovide_floating_blur_amount_x = 2.0
-- vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- vim.g.neovide_transparency = 1.0

vim.g.neovide_show_border = true -- for mac

-- vim.g.neovide_scroll_animation_length = 0.3
-- vim.g.neovide_scroll_animation_far_lines = 1

vim.g.neovide_hide_mouse_when_typing = true

-- vim.g.neovide_fullscreen = false

vim.g.neovide_profiler = false

-- vim.g.neovide_cursor_animation_length = 0.13
-- vim.g.neovide_cursor_trail_size = 0.8

-- vim.g.neovide_cursor_antialiasing = true

-- vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.o.guicursor = (function(source)
  vim.g.neovide_cursor_smooth_blink = true
  local result = {}
  for _, v in ipairs(vim.split(source, '\n')) do
    v = vim.trim(v)
    if 0 < #v then
      table.insert(result, v)
    end
  end
  return vim.fn.join(result, ',')
end)([[
  n-v-c:block
  i-ci-ve:ver25
  r-cr:hor20
  o:hor50
  a:blinkwait1200-blinkoff900-blinkon750-Cursor/lCursor
  sm:block-blinkwait175-blinkoff150-blinkon175
]])
