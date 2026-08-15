-- Consistent styling applied on top of ANY colorscheme (Rose Pine, Gruvbox,
-- Tomorrow Night, ...). Defined once here instead of per-theme, and re-applied
-- on every :colorscheme switch via the ColorScheme autocmd below.

-- How dim comments become: weight of the theme's comment color vs. the
-- background when blending. Lower = dimmer (closer to the background).
local COMMENT_DIM = 0.55

-- Blend two colors (nvim_get_hl returns fg/bg as 0xRRGGBB integers).
-- alpha = weight of `fg`; the rest is `bg`. Blending toward the background
-- dims correctly for both dark and light themes.
local function blend(fg, bg, alpha)
  local function split(c)
    return math.floor(c / 65536) % 256, math.floor(c / 256) % 256, c % 256
  end
  local fr, fg_, fb = split(fg)
  local br, bg_, bb = split(bg)
  local r = math.floor(fr * alpha + br * (1 - alpha) + 0.5)
  local g = math.floor(fg_ * alpha + bg_ * (1 - alpha) + 0.5)
  local b = math.floor(fb * alpha + bb * (1 - alpha) + 0.5)
  return r * 65536 + g * 256 + b
end

-- Add a style (bold/italic/...) to a highlight group WITHOUT losing the theme's
-- existing colors. A plain nvim_set_hl() *replaces* the group, which would strip
-- the fg color, so we read the resolved highlight and merge the style into it.
local function add_style(group, style)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  for k, v in pairs(style) do
    hl[k] = v
  end
  vim.api.nvim_set_hl(0, group, hl)
end

local function apply_highlights()
  -- NO transparency: leave Normal / NormalFloat backgrounds to the active theme.
  -- To make the background transparent instead, add:
  --   vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

  local normal  = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  local orig_fg = comment.fg -- capture BEFORE we dim Comment

  -- Unused variables use DiagnosticUnnecessary, which links to Comment by
  -- default -- so once we dim Comment they'd stay indistinguishable. Pin it to
  -- the ORIGINAL comment color so unused code keeps its faded look while sitting
  -- a notch brighter than the (now dimmer) comments. Only touch it when it's
  -- actually relying on that default link, so themes that already style it
  -- distinctly are left alone.
  local du = vim.api.nvim_get_hl(0, { name = "DiagnosticUnnecessary" })
  if du.link == "Comment" and orig_fg then
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = orig_fg })
  end

  -- Dim comments: blend the theme's own comment color toward the background.
  local dim_fg = orig_fg
  if orig_fg and normal.bg then
    dim_fg = blend(orig_fg, normal.bg, COMMENT_DIM)
  end
  vim.api.nvim_set_hl(0, "Comment",  { fg = dim_fg, italic = true })
  vim.api.nvim_set_hl(0, "@comment", { fg = dim_fg, italic = true })

  add_style("@keyword",  { bold = true })
  add_style("@function", { bold = true })
  add_style("@type",     { bold = true })
  add_style("@constant", { bold = true })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_highlights,
})

-- Apply immediately for the colorscheme that is already active at startup.
apply_highlights()
