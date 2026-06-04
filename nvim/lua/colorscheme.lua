vim.opt.termguicolors = true

-- Gruvbox Dark palette
local gruvbox = {
  bg        = "#282828",
  bg_dark   = "#1D2021",
  fg        = "#EBDBB2",
  fg_dark   = "#7C6F64",
  red       = "#FB4934",
  green     = "#B8BB26",
  yellow    = "#FABD2F",
  blue      = "#83A598",
  magenta   = "#D3869B",
  cyan      = "#8EC07C",
  orange    = "#FE8019",
}

-- Clear & reset
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "gruvbox_custom"

local hl = vim.api.nvim_set_hl

-- Core UI
hl(0, "Normal",       { fg = gruvbox.fg, bg = gruvbox.bg })
hl(0, "CursorLine",   { bg = gruvbox.bg_dark })
hl(0, "LineNr",       { fg = gruvbox.fg_dark })
hl(0, "CursorLineNr", { fg = gruvbox.yellow, bold = true })
hl(0, "SignColumn",   { bg = gruvbox.bg })
hl(0, "VertSplit",    { fg = gruvbox.bg_dark })
hl(0, "Visual",       { bg = gruvbox.fg_dark })
hl(0, "Search",       { fg = gruvbox.bg, bg = gruvbox.yellow })
hl(0, "IncSearch",    { fg = gruvbox.bg, bg = gruvbox.orange })

-- Syntax
hl(0, "Comment",      { fg = gruvbox.fg_dark, italic = true })
hl(0, "String",       { fg = gruvbox.green })
hl(0, "Number",       { fg = gruvbox.orange })
hl(0, "Boolean",      { fg = gruvbox.orange })
hl(0, "Function",     { fg = gruvbox.blue })
hl(0, "Keyword",      { fg = gruvbox.magenta })
hl(0, "Type",         { fg = gruvbox.yellow })
hl(0, "Identifier",   { fg = gruvbox.cyan })
hl(0, "Operator",     { fg = gruvbox.magenta })

-- Diagnostics (LSP)
hl(0, "DiagnosticError", { fg = gruvbox.red })
hl(0, "DiagnosticWarn",  { fg = gruvbox.yellow })
hl(0, "DiagnosticInfo",  { fg = gruvbox.blue })
hl(0, "DiagnosticHint",  { fg = gruvbox.cyan })

-- Floating / popup
hl(0, "NormalFloat", { fg = gruvbox.fg, bg = gruvbox.bg_dark })
hl(0, "FloatBorder", { fg = gruvbox.blue, bg = gruvbox.bg_dark })
