# Avoid flake8 errors
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

"""
~/.qutebrowser/config.py

git clone https://github.com/tinted-theming/base16-qutebrowser.git ~/.qutebrowser/base16-qutebrowser
"""

# Don't autoplay
c.content.autoplay = False

# Font family and size
c.fonts.default_family = ['JetBrainsMono Nerd Font']
c.fonts.default_size = '18pt'

# Padding
c.statusbar.padding = {"bottom": 4, "left": 0, "right": 0, "top": 5}
c.tabs.padding = {"bottom": 6, "left": 5, "right": 5, "top": 5}

# Hide OS window decorations
c.window.hide_decoration = True

# Disable tabs indicators
c.tabs.indicator.width = 0

# Only show statusbar when in modes other than  normal mode
c.statusbar.show = 'in-mode'

# Only show tabs while switching
c.tabs.show = 'switching'

# Auto enter insert mode when an editable element is focused upon loading page
c.input.insert_mode.auto_load = True

# Limit fullscreen to the browser window
c.content.fullscreen.window = True

# Use zathura as default downloads preview command
c.downloads.open_dispatcher = 'zathura'

# Pseudo dark mode
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "smart")

# Colors (Nord)
config.source('base16-qutebrowser/themes/minimal/base16-nord.config.py')

# Toggle dark mode and restart
config.bind(',', 'config-cycle colors.webpage.darkmode.enabled ;; restart')

# Load customization done via :set, :bind, :unbind, etc.
# Useful to toggle the dark mode
config.load_autoconfig()
