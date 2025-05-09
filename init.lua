require("config.lazy")

if vim.g.neovide then
    vim.o.guifont = "Hasklug Nerd Font Mono:h14"

    vim.g.neovide_position_animation_length = 0.05
    vim.g.neovide_scroll_animation_length = 0.2

    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_short_animation_length = 0
end
