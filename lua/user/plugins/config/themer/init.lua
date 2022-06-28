local colors = require("themer.modules.core.api").get_cp(SCHEME)
local utils = require("user.plugins.config.themer.utils")
local darken = require("themer.utils.colors").darken

colors.bg.lighter = utils.adjust_color(colors.bg.base, 5)
colors.bg.darker = darken(colors.bg.base, 0.9, "#000000")

require("themer").setup({
    colorscheme = SCHEME,
    styles = {
        comment = { style = "italic" },
        ["function"] = { style = "bold" },
    },
    remaps = {
        highlights = {
            globals = {
                themer = {
                    ThemerBorder = { fg = colors.bg.darker, bg = colors.bg.darker },
                    ThemerNormalFloat = { bg = colors.bg.darker },
                    ThemerSelected = { bg = darken(colors.bg.base, 0.8, colors.magenta) },
                },
                base = {
                    Folded = { fg = utils.adjust_color(colors.fg, -80), bg = colors.bg.lighter },
                    FoldColumn = { fg = colors.blue, bg = colors.bg.base },
                    LineNr = { fg = colors.blue, bg = colors.bg.base },
                    LineNrAbove = { link = "ThemerDimmed" },
                    LineNrBelow = { link = "ThemerDimmed" },
                    MatchParen = { fg = colors.diagnostic.warn, bg = "None", style = "underline" },
                    TabLineFill = { fg = colors.bg.lighter, bg = colors.bg.lighter },
                    SpellBad = { fg = "#ee6d85", bg = "black", style = "bold" },
                    SpellCap = { fg = colors.green, bg = "black", style = "bold" },
                    SpellLocal = { fg = colors.blue, bg = "black", style = "bold" },
                    SpellRare = { fg = colors.magenta, bg = "black", style = "bold" },
                    VertSplit = { fg = colors.bg.lighter, bg = "None", style = "None" },
                    StatusLine = { link = "VertSplit", style = "None" },
                    StatusLineNC = { link = "VertSplit", style = "None" },
                    NormalFloat = { bg = colors.bg.darker },
                    FloatBorder = { link = "ThemerBorder" },
                    PmenuSel = { bg = colors.syntax.comment or colors.dimmed.subtle },
                    Comment = { fg = utils.adjust_color(colors.bg.base, 60) },
                },
                plugins = {
                    virtcolumn = {
                        VirtColumn = { fg = utils.adjust_color(colors.red, -50), bg = "None" },
                    },
                    indentline = {
                        IndentBlanklineChar = { fg = utils.adjust_color(colors.bg.base, 20) },
                    },
                    cmp = {
                        CmpItemMenu = { fg = colors.syntax.comment or colors.dimmed.subtle, bg = colors.pum.bg },
                        CmpDocumentation = { fg = colors.pum.fg, bg = colors.pum.bg },
                        CmpDocumentationBorder = { bg = colors.pum.bg },
                        CmpItemAbbr = { fg = colors.fg, style = "NONE" },
                        CmpItemAbbrDeprecated = { fg = colors.fg },
                        CmpItemAbbrMatch = { fg = colors.green, style = "bold" },
                        CmpItemAbbrMatchFuzzy = { fg = colors.blue },
                        CmpItemKindText = { fg = colors.orange },
                        CmpItemKindMethod = { fg = colors.blue },
                        CmpItemKindFunction = { fg = colors.blue },
                        CmpItemKindConstructor = { fg = colors.yellow },
                        CmpItemKindField = { fg = colors.blue },
                        CmpItemKindClass = { fg = colors.yellow },
                        CmpItemKindInterface = { fg = colors.yellow },
                        CmpItemKindModule = { fg = colors.blue },
                        CmpItemKindProperty = { fg = colors.blue },
                        CmpItemKindValue = { fg = colors.orange },
                        CmpItemKindEnum = { fg = colors.yellow },
                        CmpItemKindKeyword = { fg = colors.purple },
                        CmpItemKindSnippet = { fg = colors.green },
                        CmpItemKindFile = { fg = colors.blue },
                        CmpItemKindEnumMember = { fg = colors.cyan },
                        CmpItemKindConstant = { fg = colors.orange },
                        CmpItemKindStruct = { fg = colors.yellow },
                        CmpItemKindTypeParameter = { fg = colors.yellow },
                    },
                    telescope = {
                        TelescopeTitle = { bg = colors.blue, style = "bold" },
                        TelescopePromptPrefix = { fg = colors.red },
                        TelescopeNormal = { link = "ThemerNormalFloat" },
                    },
                    vimtex = {
                        texStatement = { link = "ThemerField" },
                        texOnlyMath = { link = "ThemerPunctuation" },
                        texDefName = { link = "ThemerType" },
                        texNewCmd = { link = "ThemerOperator" },
                        texCmdName = { link = "ThemerPunctuation" },
                        texBeginEnd = { link = "ThemerInclude" },
                        texBeginEndName = { link = "ThemerPunctuation" },
                        texDocType = { link = "ThemerStruct" },
                        texDocTypeArgs = { link = "ThemerOperator" },
                        texCmd = { link = "ThemerField" },
                        texCmdClass = { link = "ThemerStruct" },
                        texCmdTitle = { link = "ThemerStruct" },
                        texCmdAuthor = { link = "ThemerStruct" },
                        texCmdPart = { link = "ThemerStruct" },
                        texCmdBib = { link = "ThemerStruct" },
                        texCmdPackage = { link = "ThemerType" },
                        texCmdNew = { link = "ThemerType" },
                        texArgNew = { link = "ThemerOperator" },
                        texPartArgTitle = { link = "ThemerConstantBuiltIn" },
                        texFileArg = { link = "ThemerConstantBuiltIn" },
                        texEnvArgName = { link = "ThemerConstantBuiltIn" },
                        texMathEnvArgName = { link = "ThemerConstantBuiltIn" },
                        texTitleArg = { link = "ThemerConstantBuiltIn" },
                        texAuthorArg = { link = "ThemerConstantBuiltIn" },
                    },
                    lsp = {
                        DiagnosticUnderlineHint = { style = "underline" },
                        DiagnosticUnderlineInfo = { style = "underline" },
                        DiagnosticUnderlineWarn = { style = "underline" },
                        DiagnosticUnderlineError = { style = "underline" },
                    },
                    neotree = {
                        NeoTreeRootName = { link = "ThemerMatch" },
                        NeoTreeDirectoryName = { link = "ThemerMatch" },
                        NeoTreeNormal = { bg = colors.bg.darker },
                        NeoTreeNormalNC = { bg = colors.bg.darker },
                    },
                },
            },
        },
    },
})
