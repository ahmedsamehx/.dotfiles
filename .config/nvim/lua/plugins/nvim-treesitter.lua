return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = ":TSUpdate",
    dependencies = {
        {"nvim-treesitter/nvim-treesitter-textobjects"}, -- Syntax aware text-objects
        {
            "nvim-treesitter/nvim-treesitter-context", -- Show code context
			  config = function()
    			require("treesitter-context").setup({
     			enable = true,
      		mode = "topline",
      		line_numbers = true,
    			})
  				end
        }
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"markdown"},
			 	callback = function()
    			local ok, context = pcall(require, "treesitter-context")
    			if ok then context.disable() end
  				end
        })

        treesitter.setup({
            ensure_installed = {
                "gitignore", "go", "gomod", "gosum",
                "gowork", "lua", "markdown"
            },
            indent = {enable = true},
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = {"csv"} -- preferring chrisbra/csv.vim
            },
            textobjects = {select = {enable = true, lookahead = true}}
        })
    end
}
