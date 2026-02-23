return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure this loads before other plugins
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha" -- Options: latte, frappe, macchiato, mocha
    end,
  },
}
