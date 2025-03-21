return {
	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- Call the autopairs setup function to configure how we want autopairs to work
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					java = false,
				},
			})

			-- Get access to auto pairs completion and cmp plugins
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			-- Whenever we accept a choice from an autocompletion, make sure that any pairs are automatically closed
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Auto tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},

	-- Commenting
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- plugin to allow us to automatically comment tsx elements with the comment plugin
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- Set a vim motion to <Space> + / to comment the line under the cursor in normal mode
			vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
			-- Set a vim motion to <Space> + / to comment all the lines selected in visual mode
			vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })

			-- gain access to the comment plugins functions
			local comment = require("Comment")
			-- gain access to tsx commenting plugins functions
			local ts_context_comment_string = require("ts_context_commentstring.integrations.comment_nvim")

			-- setup the comment plugin to use ts_context_comment_string to check if we are attempting to comment out a tsx element
			-- if we are use ts_context_comment_string to comment it out
			comment.setup({
				pre_hook = ts_context_comment_string.create_pre_hook(),
			})
		end,
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",

		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"roobert/tailwindcss-colorizer-cmp.nvim",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
}
