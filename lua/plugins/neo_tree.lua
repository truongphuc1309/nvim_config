return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },

    config = function()
        vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", { silent = true })
        require("neo-tree").setup({
            window = {
                position = "float",
                width = 40,
            },
            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },

            default_component_configs = {
                git_status = {
                    symbols = {
                        added = "✚",
                        modified = "",
                        deleted = "✖",
                        renamed = "➜",
                        untracked = "★",
                        ignored = "◌",
                        unstaged = "!",
                        staged = "✓",
                        conflict = "",
                    },
                },
            },
        })
    end,
}
