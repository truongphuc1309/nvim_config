return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		local eslint_root_markers = {
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			"package.json",
			"tsconfig.json",
			".git",
		}

		local function get_eslint_root(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname == "" then
				return vim.fn.getcwd()
			end

			local matches = vim.fs.find(eslint_root_markers, {
				path = vim.fs.dirname(bufname),
				upward = true,
			})

			if #matches > 0 then
				return vim.fs.dirname(matches[1])
			end

			return vim.fn.getcwd()
		end

		local eslint_d = lint.linters.eslint_d
		local eslint_d_parser = eslint_d.parser

		eslint_d.parser = function(output, bufnr)
			local json_start = output:find("[%[{]")

			if json_start and json_start > 1 then
				output = output:sub(json_start)
			end

			return eslint_d_parser(output, bufnr)
		end

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function try_lint()
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo[bufnr].filetype

			if vim.tbl_contains({ "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" }, ft) then
				lint.try_lint(nil, { cwd = get_eslint_root(bufnr) })
				return
			end

			lint.try_lint()
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
