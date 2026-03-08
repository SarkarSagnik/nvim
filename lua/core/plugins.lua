require("lazy").setup({
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true, timeout = 3000 },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Word", mode = { "n", "t" } },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Word", mode = { "n", "t" } },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    _G.dd = function(...) Snacks.debug.inspect(...) end
                    vim.print = _G.dd
                    Snacks.toggle.option("spell"):map("<leader>us")
                    Snacks.toggle.option("wrap"):map("<leader>uw")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    },

    { "theprimeagen/harpoon", branch = "v2", dependencies = { "nvim-lua/plenary.nvim" } },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "c", "lua", "vim", "rust", "python", "typescript", "go" },
                highlight = { enable = true },
            })
        end,
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { "rust_analyzer", "pyright", "ts_ls", "clangd" },
                handlers = { lsp.default_setup },
            })

            local cmp = require("cmp")
            cmp.setup(lsp.defaults.cmp_config({
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                },
            }))

            require("luasnip.loaders.from_vscode").lazy_load()
            vim.diagnostic.config({ virtual_text = true })
        end,
    },

    {
        "sainnhe/everforest",
        config = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    vim.cmd.colorscheme("everforest")
                    local groups = {
                        "Normal", "NormalFloat", "FloatBorder", "Pmenu",
                        "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
                        "NeoTreeNormal", "NeoTreeNormalNC", "NvimTreeNormal",
                        "SignColumn", "Folded", "EndOfBuffer",
                    }
                    for _, group in ipairs(groups) do
                        vim.api.nvim_set_hl(0, group, { bg = "none" })
                    end
                end,
            })
        end,
    },
})
