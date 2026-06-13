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
		cmd = { "Git", "G", "Gdiffsplit" },
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "[G]it [S]tatus" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "[G]it [B]lame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "[G]it [D]iff Split" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "[G]it [C]ommit" },
		},
		config = function()
			local fugitive_diff_augroup = vim.api.nvim_create_augroup("fugitive_diff_readonly", { clear = true })
			local edit_keys = { "i", "I", "a", "A", "o", "O", "c", "C", "s", "S", "r", "R" }

			local function is_fugitive_buffer(buf)
				local name = vim.api.nvim_buf_get_name(buf)

				return name:match("^fugitive:") or vim.b[buf].fugitive_type ~= nil
			end

			local function lock_fugitive_diff_buffer(buf)
				if not is_fugitive_buffer(buf) then
					return
				end

				vim.bo[buf].modifiable = false
				vim.bo[buf].readonly = true
				vim.diagnostic.enable(false, { bufnr = buf })

				for _, key in ipairs(edit_keys) do
					vim.keymap.set("n", key, function()
						vim.notify("This Fugitive diff buffer is readonly", vim.log.levels.WARN)
					end, { buffer = buf, silent = true, desc = "Readonly Fugitive diff buffer" })
				end
			end

			vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "WinEnter" }, {
				group = fugitive_diff_augroup,
				callback = function()
					vim.schedule(function()
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
							if vim.wo[win].diff then
								lock_fugitive_diff_buffer(vim.api.nvim_win_get_buf(win))
							end
						end
					end)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = fugitive_diff_augroup,
				pattern = "fugitive",
				callback = function(event)
					if vim.wo.diff then
						lock_fugitive_diff_buffer(event.buf)
					end
				end,
			})
		end,
	},
}
