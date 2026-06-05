require("lualine").setup({
  options = {
    theme = "gruvbox",
    section_separators   = { left = "|", right = "|" },
    component_separators = { left = "|", right = "|" },
    refresh = {
      statusline = 1000,
      tabline    = 1000,
      winbar     = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
