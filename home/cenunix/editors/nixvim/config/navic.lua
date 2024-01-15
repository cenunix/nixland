require("nvim-navic").setup {
    icons = icons.kind,
    lsp = {
        auto_attach = true,
        preference = nil,
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = true,
    format_text = function(text)
        return text
    end,
}
