return {
  -- add gruvbox
  { "lunacookies/vim-colors-xcode" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "xcodelight",
    },
  },
}
