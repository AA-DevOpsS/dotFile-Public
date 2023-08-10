 require('neosolarized').setup({
    comment_italics = true,
    background_set = false,
  })

local cb = require('colorbuddy.init')
local Color = cb.Color
local colors = cb.colors
local Group = cb.Group
local groups = cb.groups
local styles = cb.styles

Color.new('white', '#ffffff')
Color.new('black', '#000000')
Color.new('base1', '#F8F8F8')
Color.new('base0', '#eee8d5')
Color.new("cyan1", '#00f1f5')

Group.new('Normal', colors.base1, colors.NONE, styles.NONE)
Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.cyan1, colors.black, styles.NONE, colors.base1)
Group.new('Visual', colors.none, colors.base03, styles.reverse)

local cError = groups.Error.fg
local cInfo = groups.Information.fg
local cWarn = groups.Warning.fg
local cHint = groups.Hint.fg

Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)

-- helper - color from the plugin.
-- Color.new("base03", "#002b36")
-- Color.new("base02", "#073642")
-- Color.new("base01", "#586e75")
-- Color.new("base00", "#657b83")
-- Color.new("base0", "#839496")
-- Color.new("base1", "#93a1a1")
-- Color.new("base2", "#eee8d5")
-- Color.new("base3", "#fdf6e3")
-- Color.new("yellow", "#b58900")
-- Color.new("orange", "#cb4b16")
-- Color.new("red", "#dc322f")
-- Color.new("magenta", "#d33682")
-- Color.new("violet", "#6c71c4")
-- Color.new("blue", "#268bd2")
-- Color.new("cyan", "#2aa198")
-- Color.new("green", "#719e07")
--
    --NOTE: base hints:
    --base1 - titles parms.
    --base0 - params
--
--
--more colors
    -- grey1 = "#262626",
    -- grey2 = "#424242",
    -- grey3 = "#8B8B8B",
    -- grey4 = "#bdbdbd",
    -- grey5 = "#F8F8F8",
    -- violet = "#D484FF",
    -- blue = "#2f628e",
    -- cyan = "#00f1f5",
    -- green = "#A9FF68",
    -- dark_green = "#142818",
    -- yellow = "#FFF59D",
    -- orange = "#F79000",
    -- red = "#F70067",
    -- dark_red = "#3F0001",
    -- float_background = "#132434",
    -- background = "NONE",
