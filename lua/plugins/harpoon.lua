return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Set a vim motion to <Shift>m to mark a file with harpoon
        vim.keymap.set("n", "<s-m>", function()
            harpoon:list():add()
        end, { desc = "Harpoon Mark File" })

        -- Set a vim motion to the tab key to open the harpoon menu to easily navigate frequented files
        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon Toggle Menu" })

        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<S-h>", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<S-h>", function()
            harpoon:list():next()
        end)
    end,
}
