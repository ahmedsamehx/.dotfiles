return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000, -- load early
    config = function()
        vim.opt.termguicolors = true

        -- optional settings for gruvbox-material
        vim.g.gruvbox_material_background = "medium" -- soft, medium, hard
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_transparent_background = 0

        -- apply the colorscheme
        vim.cmd.colorscheme("gruvbox-material")
    end
}

