----------------------
-- MUST BE VALID LUA--
----------------------
local NvimDefaultPluginPath = os.getenv("HOME").."/.config/nvim/nvim_plugins"
local lazypath = vim.fn.expand(NvimDefaultPluginPath.. "/lazy.nvim")
spaceWidth = 4

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = spaceWidth
vim.opt.softtabstop = spaceWidth
vim.opt.shiftwidth = spaceWidth
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"
--vim.opt.swapfile = false

-- Keymaps
vim.keymap.set('n', '<Space>', '', { noremap = true })
vim.keymap.set('n', 'ZZ', '', { noremap = true})
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Space>e','<cmd>Explore<CR>')
vim.keymap.set('n', '<A-j>', '<C-e>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<C-y>', { noremap = true, silent = true })
vim.g.mapleader = " "

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-------------
-- Plugins --
-------------
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    { --Plugins from/for Lazy.nvim
        { --Telescope
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            dependencies = {
                'nvim-lua/plenary.nvim', 
                'BurntSushi/ripgrep',
                'sharkdp/fd',
                { -- If encountering errors, see telescope-fzf-native README for installation instructions
                    'nvim-telescope/telescope-fzf-native.nvim',
            
                    build = 'make',
                
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
                'nvim-telescope/telescope-ui-select.nvim'

            },
            config = function()
                require('telescope').setup {
                    defaults = {
                        scroll_strategy = "limit";
                        file_ignore_patterns = { ".git/[^h]" };
                    },
                    pickers = {
                        find_files = {
                            hidden = true;
                        },
                        buffers = {
                            sort_mru = true;
                        }
                    },
                    extensions = {
                        ['ui-select'] = {
                            require('telescope.themes').get_dropdown(),
                        },
                    },
                }
                
                -- Enable Telescope extensions if they are installed
                pcall(require('telescope').load_extension, 'fzf')
                pcall(require('telescope').load_extension, 'ui-select')
                
                -- See `:help telescope.builtin`
                local builtin = require 'telescope.builtin'
                vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
                vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
                vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
                vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
                vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
                vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
                vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
                vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
                vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
                vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

                -- Slightly advanced example of overriding default behavior and theme
                vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
                end, { desc = '[/] Fuzzily search in current buffer' })

                vim.keymap.set('n', '<leader>s/', function()
                    builtin.live_grep {
                        grep_open_files = true,
                        prompt_title = 'Live Grep in Open Files',
                    }
                end, { desc = '[S]earch [/] in Open Files' })

            end,
        },
---------
-- LSP --
---------
        {
            "mason-org/mason.nvim",
            opts={}
        },
        { -- Mason bridge to LSP
            "mason-org/mason-lspconfig.nvim",
            dependencies = { "mason-org/mason.nvim" },
            opts = {
--                ensure_installed = { "clangd" },
            },
        },
        { -- Completion engine
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
            },
            config = function()
                local cmp = require("cmp")

                cmp.setup({
                    mapping = cmp.mapping.preset.insert({
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    }),
                    sources = {
                        { name = "nvim_lsp" },
                    },
                })
            end,
        },
    },
    { --Options for Lazy.nvim
        --Path to lazy plugins
        root = vim.fn.expand(NvimDefaultPluginPath),
    }
)

---------------
-- LSP Setup --
---------------

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config(
    "clangd", {
        cmd = {
            "clangd",
            "--background-index",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "asm" },
        capabilities = capabilities,
    }
)

vim.lsp.enable("clangd")
