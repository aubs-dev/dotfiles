local wezterm = require("wezterm")

local config = {
    -- Appearance
    animation_fps = 180,
    max_fps = 180,

    cursor_blink_rate = 500,
    default_cursor_style = "BlinkingBar",
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    force_reverse_video_cursor = false,

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    color_scheme = "Gruvbox dark, medium (base16)",

    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_max_width = 25,
    show_tab_index_in_tab_bar = true,
    switch_to_last_active_tab_when_closing_tab = true,

    window_close_confirmation = "NeverPrompt",

    -- Fonts
    font = wezterm.font("JetBrainsMono Nerd Font Mono"),
    font_size = 14,

    -- General
    automatically_reload_config = true,
    exit_behavior = "CloseOnCleanExit",
    status_update_interval = 1000,
    check_for_updates = true,

    scrollback_lines = 4096,

    -- Launch
    default_prog = { "cmd.exe", "/K", "vcvarsall.bat x64 > nul", "&&", "powershell.exe", "-nologo" },
    -- default_prog = { "powershell.exe", "-nologo" },

    colors = {
        cursor_bg = "#ebdbb2",
        cursor_fg = "#3c3836",
        cursor_border = "#ebdbb2",
        selection_fg = "#ebdbb2",
        selection_bg = "#3c3836",
    },
}

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" then
        config.front_end = "WebGpu"
        config.webgpu_preferred_adapter = gpu
        config.webgpu_power_preference = "HighPerformance"
        break
    end
end

return config
