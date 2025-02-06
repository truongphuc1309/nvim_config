return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			-- auto install
			auto_install = true,
			-- add language you want to highlight in code
			ensure_installed = {
				"c",
                "cpp",
				"lua",
				"vim",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"java",
				"json",
                "python",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
    end
}
