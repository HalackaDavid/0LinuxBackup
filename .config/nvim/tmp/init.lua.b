----------------------
-- MUST BE VALID LUA--
----------------------
local NvimDefaultPath = os.getenv("HOME").."/.config/nvim/nvim_plugins"
local lazypath = vim.fn.expand(NvimDefaultPath.. "/lazy.nvim")
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
-- s:^:<comment symbol>:
-- s:^<comment symbol>:

-- Keymaps
vim.keymap.set('n', '<Space>', '', { noremap = true })
vim.keymap.set('n', 'ZZ', '', { noremap = true})
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Space>e','<cmd>Explore<CR>')
vim.keymap.set('n', '<A-j>', '<C-e>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<C-y>', { noremap = true, silent = true })
vim.g.mapleader = " "


-- highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


vim.api.nvim_create_user_command(
    'Format', 
    function(opts)
        local indent_width = tonumber(opts.args)
        if not indent_width then
            print("Usage: :Format <indent_width>")
            return
        end

        local function count_indent(line)
            local count = 0
            for i = 1, #line do
                local c = line:sub(i,i)
                if c == " " then
                    count = count + 1
                elseif c == "\t" then
                    count = count + indent_width  -- treat tab as N spaces
                else
                    break
                end
            end
            return count
        end

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local new_lines = {}
        local indent_stack = {}
        local prev_indent = 0

        for _, line in ipairs(lines) do
            local raw_indent = count_indent(line)
            local content = line:match("^%s*(.*)$")

            -- Handle indent level changes
            if raw_indent > prev_indent then
                table.insert(indent_stack, raw_indent)
            elseif raw_indent < prev_indent then
                while #indent_stack > 0 and indent_stack[#indent_stack] > raw_indent do
                    table.remove(indent_stack)
                end
            end

            local level = #indent_stack
            table.insert(new_lines, string.rep(" ", level * indent_width) .. content)
            prev_indent = raw_indent
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
        print("Formatted with indent width: " .. indent_width .. ", tabs replaced with spaces.")
    end, 
    {
        nargs = 1,
    }
)

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
        { -- Fuzzy Finder (files, lsp, etc)
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
                -- [[ Configure Telescope ]]
                -- See `:help telescope` and `:help telescope.setup()`
                require('telescope').setup {
                    defaults = {
                        scroll_strategy = "limit";
                        file_ignore_patterns = { ".git/[^h]" };
                        --initial_mode= "normal";
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

-- github.com/neovim/nvim-lspconfig
-- github.com/mason-org/mason.nvim
-- github.com/mason-org/mason-lspconfig.nvim
-- github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--        {
--            'neovim/nvim-lspconfig',
--            dependencies = {
--                { 'mason-org/mason.nvim', 
--                    opts = {
--                        ui = {
--                            icons = {
--                                package_installed = "✓",
--                                package_pending = "➜",
--                                package_uninstalled = "✗"
--                            }
--                        }
--		              }
--                },
--                'mason-org/mason-lspconfig.nvim',
--                'WhoIsSethDaniel/mason-tool-installer.nvim',
--            },
--            config = function()
--                vim.api.nvim_create_autocmd('LspAttach', {
--                    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
--                    callback = function(event)
--                        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
--                        vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })
--                        vim.keymap.set('n', 'grr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
--                        vim.keymap.set('n', 'gri', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
--                        vim.keymap.set('n', 'grd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
--                        vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
--                        vim.keymap.set('n', 'gO', require('telescope.builtin').lsp_document_symbols, { desc = 'Open Document Symbols' })
--                        vim.keymap.set('n', 'gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'Open Workspace Symbols' })
--                        vim.keymap.set('n', 'grt', require('telescope.builtin').lsp_type_definitions, { desc = '[G]oto [T]ype Definition' })
--
--
--                        ---@param client vim.lsp.Client
--                        ---@param method vim.lsp.protocol.Method
--                        ---@param bufnr? integer some lsp support methods only in specific files
--                        ---@return boolean
--                        local function client_supports_method(client, method, bufnr)
--                            if vim.fn.has 'nvim-0.11' == 1 then
--                                return client:supports_method(method, bufnr)
--                            else
--                                return client.supports_method(method, { bufnr = bufnr })
--                            end
--                        end
--
--                        local client = vim.lsp.get_client_by_id(event.data.client_id)
--                        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
--                            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
--                            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--                                buffer = event.buf,
--                                group = highlight_augroup,
--                                callback = vim.lsp.buf.document_highlight,
--                            })
--
--                            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--                                buffer = event.buf,
--                                group = highlight_augroup,
--                                callback = vim.lsp.buf.clear_references,
--                            })
--
--                            vim.api.nvim_create_autocmd('LspDetach', {
--                                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
--                                callback = function(event2)
--                                    vim.lsp.buf.clear_references()
--                                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
--                                end,
--                            })
--                        end
--
--                        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
--                            vim.keymap.set('n', '<leader>th', function() 
--                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) 
--                            end, { desc = '[T]oggle Inlay [H]ints' })
--                        end
--                    end,
--                })
--
--                local servers = {
--                    --clangd = {},
--                    --bashls = {},
--                    -- ... etc. see `:help lspconfig-all` for a list of all the pre-configured lsps
--
----                    lua_ls = {
----                        -- cmd = { ... },
----                        -- filetypes = { ... },
----                        -- capabilities = {},
----                        settings = {
----                            lua = {
----                                completion = {
----                                    callsnippet = 'replace',
----                                },
----                                -- you can toggle below to ignore lua_ls's noisy `missing-fields` warnings
----                                diagnostics = { disable = { 'missing-fields' } },
----                            },
----                        },
----                    },
--                }
--
--                local ensure_installed = vim.tbl_keys(servers or {})
----                vim.list_extend(ensure_installed, {
----                    'stylua', -- Used to format Lua code
----                })
--                require('mason-tool-installer').setup { ensure_installed = ensure_installed }
--
--                require('mason-lspconfig').setup {
--                    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
--                    automatic_installation = false,
--                    handlers = {
--                        function(server_name)
--                            local server = servers[server_name] or {}
--                            -- This handles overriding only values explicitly passed
--                            -- by the server configuration above. Useful when disabling
--                            -- certain features of an LSP (for example, turning off formatting for ts_ls)
--                            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--                            require('lspconfig')[server_name].setup(server)
--                        end,
--                    },
--                }
--
--            end,
--        },
    },
    { --Options for Lazy.nvim
        --Path to lazy plugins
            root = vim.fn.expand(NvimDefaultPath),
    }
)
