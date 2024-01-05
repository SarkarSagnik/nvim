require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    {
        'rose-pine/neovim' ,
        as = 'rose-pine' ,
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },


    'theprimeagen/harpoon',
    'mbbill/undotree',


    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function()
            require'nvim-treesitter.configs'.setup{
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "c", "lua", "vim", "rust", "python", "typescript" },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },

    -- completion
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
})

