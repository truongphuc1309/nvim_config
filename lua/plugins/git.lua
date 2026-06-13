return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			-- setup gitsigns with default properties
			require("gitsigns").setup({})

			-- Set a vim motion to <Space> + g + h to preview changes to the file under the cursor in normal mode
			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gg", "<cmd>Git<CR>", desc = "[G]it Status" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "[G]it [B]lame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "[G]it [D]iff Split" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "[G]it [C]ommit" },
		},
	},
}
