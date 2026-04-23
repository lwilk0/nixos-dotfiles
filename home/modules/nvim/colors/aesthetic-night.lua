-- File: colors/aesthetic-night.lua
local p = {
  black = "#1C252C",
  bright_black = "#484E5B",
  red = "#DF5B61",
  bright_red = "#F16269",
  green = "#78B892",
  bright_green = "#8CD7AA",
  yellow = "#DE8F78",
  bright_yellow = "#E9967E",
  blue = "#6791C9",
  bright_blue = "#79AAEB",
  magenta = "#BC83E3",
  bright_magenta = "#C488EC",
  cyan = "#67AFC1",
  bright_cyan = "#7ACFE4",
  white = "#D9D7D6",
  bright_white = "#E5E5E5",
}

-- Set terminal colors
for i, c in ipairs({
  p.black, p.red, p.green, p.yellow,
  p.blue, p.magenta, p.cyan, p.white,
  p.bright_black, p.bright_red, p.bright_green, p.bright_yellow,
  p.bright_blue, p.bright_magenta, p.bright_cyan, p.bright_white,
}) do
  vim.g["terminal_color_" .. (i - 1)] = c
end

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "aesthetic-night"

-- Helper function for setting highlights (FIXED TYPO: 'end' instead of 'hi')
local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ==========================================
-- Editor Settings
-- ==========================================
hi("Normal", { fg = p.white, bg = p.black })
hi("NormalFloat", { fg = p.white, bg = p.bright_black })
hi("FloatBorder", { fg = p.bright_black, bg = p.bright_black })
hi("FloatTitle", { fg = p.bright_white, bg = p.bright_black })
hi("NormalNC", { fg = p.white, bg = p.black })
hi("Cursor", { fg = p.black, bg = p.bright_white })
hi("CursorLine", { bg = p.bright_black })
hi("CursorColumn", { bg = p.bright_black })
hi("ColorColumn", { bg = p.bright_black })
hi("LineNr", { fg = p.bright_black })
hi("CursorLineNr", { fg = p.bright_white })
hi("SignColumn", { fg = p.bright_black, bg = p.black })
hi("VertSplit", { fg = p.bright_black, bg = p.black })
hi("WinSeparator", { fg = p.bright_black, bg = p.black })

-- ==========================================
-- Syntax Highlighting
-- ==========================================
hi("Comment", { fg = p.bright_black, italic = true })
hi("Constant", { fg = p.yellow })
hi("String", { fg = p.green })
hi("Character", { fg = p.green })
hi("Number", { fg = p.yellow })
hi("Boolean", { fg = p.yellow })
hi("Float", { fg = p.yellow })
hi("Identifier", { fg = p.white })
hi("Function", { fg = p.blue })
hi("Statement", { fg = p.magenta })
hi("Conditional", { fg = p.magenta })
hi("Repeat", { fg = p.magenta })
hi("Label", { fg = p.magenta })
hi("Operator", { fg = p.yellow })
hi("Keyword", { fg = p.magenta })
hi("Exception", { fg = p.red })
hi("PreProc", { fg = p.cyan })
hi("Include", { fg = p.cyan })
hi("Define", { fg = p.cyan })
hi("Macro", { fg = p.cyan })
hi("Type", { fg = p.cyan })
hi("StorageClass", { fg = p.cyan })
hi("Structure", { fg = p.cyan })
hi("Typedef", { fg = p.cyan })
hi("Special", { fg = p.bright_magenta })
hi("SpecialChar", { fg = p.bright_yellow })
hi("Tag", { fg = p.blue })
hi("Delimiter", { fg = p.bright_black })
hi("Debug", { fg = p.red })

-- ==========================================
-- UI Elements
-- ==========================================
hi("Directory", { fg = p.blue })
hi("Title", { fg = p.blue, bold = true })
hi("Substitute", { fg = p.black, bg = p.yellow })
hi("MatchParen", { fg = p.black, bg = p.bright_black, bold = true })
hi("NonText", { fg = p.bright_black })
hi("Whitespace", { fg = p.bright_black })

hi("Search", { fg = p.black, bg = p.yellow })
hi("IncSearch", { fg = p.black, bg = p.bright_yellow })
hi("CurSearch", { fg = p.black, bg = p.bright_yellow })

hi("Visual", { bg = p.bright_black })
hi("VisualNOS", { bg = p.bright_black })

hi("Pmenu", { fg = p.white, bg = p.bright_black })
hi("PmenuSel", { fg = p.black, bg = p.blue })
hi("PmenuSbar", { bg = p.bright_black })
hi("PmenuThumb", { fg = p.white, bg = p.bright_black })

hi("TabLine", { fg = p.bright_black, bg = p.black })
hi("TabLineFill", { fg = p.black, bg = p.black })
hi("TabLineSel", { fg = p.bright_white, bg = p.bright_black })

hi("StatusLine", { fg = p.white, bg = p.bright_black })
hi("StatusLineNC", { fg = p.bright_black, bg = p.black })

-- ==========================================
-- Diagnostics
-- ==========================================
hi("DiagnosticError", { fg = p.red })
hi("DiagnosticWarn", { fg = p.yellow })
hi("DiagnosticInfo", { fg = p.blue })
hi("DiagnosticHint", { fg = p.cyan })
hi("DiagnosticOk", { fg = p.green })
hi("DiagnosticUnderlineError", { fg = p.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { fg = p.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { fg = p.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { fg = p.cyan, undercurl = true })

-- ==========================================
-- Git
-- ==========================================
hi("GitSignsAdd", { fg = p.green })
hi("GitSignsChange", { fg = p.yellow })
hi("GitSignsDelete", { fg = p.red })
hi("DiffAdd", { bg = p.green, fg = p.black })
hi("DiffChange", { bg = p.yellow, fg = p.black })
hi("DiffDelete", { bg = p.red, fg = p.black })
hi("DiffText", { bg = p.blue, fg = p.black })

-- ==========================================
-- LazyVim UI Overrides
-- ==========================================
hi("LazyNormal", { fg = p.white, bg = p.bright_black })
hi("LazyButton", { fg = p.white, bg = p.black })
hi("LazyButtonActive", { fg = p.black, bg = p.blue })
hi("LazyH1", { fg = p.blue, bold = true })

hi("MasonNormal", { fg = p.white, bg = p.bright_black })
hi("MasonHeader", { fg = p.black, bg = p.blue, bold = true })
hi("MasonHeaderSecondary", { fg = p.black, bg = p.green, bold = true })

hi("TelescopeNormal", { fg = p.white, bg = p.bright_black })
hi("TelescopeBorder", { fg = p.bright_black, bg = p.bright_black })
hi("TelescopePromptNormal", { fg = p.white, bg = p.black })
hi("TelescopePromptBorder", { fg = p.black, bg = p.black })
hi("TelescopeSelection", { fg = p.black, bg = p.blue })
hi("TelescopeSelectionCaret", { fg = p.red, bg = p.blue })

hi("NotifyBackground", { bg = p.bright_black })
hi("NotifyERRORBorder", { fg = p.red })
hi("NotifyWARNBorder", { fg = p.yellow })
hi("NotifyINFOBorder", { fg = p.blue })
hi("NotifyHINTBorder", { fg = p.cyan })
hi("NotifyERRORBody", { fg = p.white, bg = p.bright_black })
hi("NotifyWARNBody", { fg = p.white, bg = p.bright_black })
hi("NotifyINFOBody", { fg = p.white, bg = p.bright_black })
hi("NotifyHINTBody", { fg = p.white, bg = p.bright_black })

hi("WhichKeyFloat", { fg = p.white, bg = p.bright_black })
hi("NoicePopup", { fg = p.white, bg = p.bright_black })
hi("NoicePopupBorder", { fg = p.bright_black, bg = p.bright_black })

hi("TreesitterContext", { bg = p.bright_black })
hi("TreesitterContextLineNumber", { fg = p.bright_white })
