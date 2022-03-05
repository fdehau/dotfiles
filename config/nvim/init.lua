vim.g.mapleader = " "

vim.cmd("filetype plugin on")
vim.cmd("syntax enable")

-- ui
vim.o.termguicolors = true
vim.wo.number = true
vim.o.cmdheight = 1
vim.o.ruler = true

-- scrolling
vim.wo.wrap = false
vim.wo.scrolloff = 10
vim.wo.sidescrolloff = 10

-- macros
vim.o.lazyredraw = true

-- backups
vim.o.backup = false
vim.o.wb = false
vim.bo.swapfile = false

-- no tabs and all tabs are 4 spaces
vim.cmd [[
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
]]

-- search
vim.o.ignorecase = true
vim.o.smartcase = true

-- replace
vim.o.inccommand = "nosplit"

-- key mappings
vim.o.mouse = "a"

function keymap(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymap("i", "jj", "<Esc>")
keymap("v", "jj", "<Esc>")
keymap("n", "<Leader>w", ":w<CR>")
keymap("n", "<Leader><Leader>", "V")
keymap("v", "<Leader><Leader>", "<Esc>")
keymap("n", "<CR>", "o<Esc>")

-- switch buffer
keymap("n", "<C-Right>", ":bnext<CR>")
keymap("n", "<C-Left>", ":bprev<CR>")

-- move around easily with shift and arrow keys
keymap("n", "<S-Left>", "b")
keymap("n", "<S-Right>", "w")
keymap("n", "<S-Up>", "10k")
keymap("n", "<S-Down>", "10j")

-- copy from and to system clipboard
keymap("v", "<Leader>y", '"+y')
keymap("n", "<Leader>p", '"+p')
keymap("n", "<Leader>P", '"+P')

-- plugins
local packer_exists = vim.cmd("packadd packer.nvim")
require("packer").startup(function()
    use {
        "wbthomason/packer.nvim",
        opt = true
    }

    -- colors
    use {
        "morhetz/gruvbox",
        config = function()
            vim.g.gruvbox_italic = 1
            vim.cmd("colorscheme gruvbox")
            vim.o.background = "dark"
            keymap("n", "<Leader>bg", ':let &background = ( &background == "dark" ? "light" : "dark")<CR>')
        end
    }

    -- edits
    use "tpope/vim-surround"
    use {
        "junegunn/vim-easy-align",
        config = function()
            -- start interactive EasyAlign in visual mode (e.g. vipga)
            keymap("x", "ga", '<Plug>(EasyAlign)', {noremap = false})
            -- start interactive EasyAlign for a motion/text object (e.g. gaip)
            keymap("v", "ga", '<Plug>(EasyAlign)', {noremap = false})
        end
    }
    use "tpope/vim-commentary"
    use "terryma/vim-expand-region"

    -- moving around
    use {
        "matze/vim-move",
        config = function()
            vim.g.move_map_keys = 0
            vim.g.move_auto_indent = 0
            keymap("v", "<C-Up>", "<Plug>MoveBlockUp", {noremap = false})
            keymap("v", "<C-Down>", "<Plug>MoveBlockDown", {noremap = false})
        end
    }
    use {
        "justinmk/vim-sneak",
        config = function()
            vim.g['sneak#streak'] = 1
        end
    }
    use "christoomey/vim-tmux-navigator"

    -- lsp
    use {
        "neovim/nvim-lspconfig",
        config = function()
            -- Global config
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    update_in_insert = false,
                }
            )

            -- Servers config
            lsp = require'lspconfig'
            lsp.rust_analyzer.setup{}
            lsp.gopls.setup{
                on_init = function(client)
                    if client.config.flags then
                        -- Send smaller diffs to gopls
                        client.config.flags.allow_incremental_sync = true
                    end
                end,
                root_dir = function(fname)
                    -- Avoid loading the world when working on big monorepo
                    return vim.fn.getcwd()
                end,
            }

            -- Keymaps
            keymap("n", "<leader>mn", '<cmd>lua vim.diagnostic.goto_prev()<CR>')
            keymap("n", "<leader>mp", '<cmd>lua vim.diagnostic.goto_next()<CR>')
            keymap("n", "<leader>ma", '<cmd>lua vim.lsp.buf.code_action()<CR>')
            keymap("n", "<leader>md", '<cmd>lua vim.lsp.buf.definition()<CR>')
            keymap("n", "<leader>mf", '<cmd>lua vim.lsp.buf.formatting()<CR>')
            keymap("n", "<leader>mh", '<cmd>lua vim.lsp.buf.hover()<CR>')
            keymap("n", "<leader>mr", '<cmd>lua vim.lsp.buf.references()<CR>')
            keymap("n", "<leader>mR", '<cmd>lua vim.lsp.buf.rename()<CR>')
            keymap("n", "<leader>ms", '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
        end
    }

    -- completion
    use {
        'shougo/deoplete.nvim',
        run = function()
            vim.fn["remote#host#UpdateRemotePlugins"]()
        end,
        config = function()
            keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
            keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
            vim.o.completeopt = 'menuone,noinsert,noselect'
            vim.g["deoplete#enable_at_startup"] = 1
            vim.fn["deoplete#custom#option"]({
                smart_case = true,
                max_list = 10,
            })
        end,
    }
    use "Raimondi/delimitMate"

    -- navigation
    use {
        "junegunn/fzf",
        run = function()
            vim.fn["fzf#install"]()
        end,
        config = function()
            keymap("n", "<Leader>f", ":Files <CR>", {silent = true})
            keymap("n", "<Leader>o", ":Buffers <CR>", {silent = true})
            keymap("n", "<Leader>l", ":BLines <CR>", {silent = true})
            keymap("n", "<Leader>L", ":BLines <C-R><C-W><CR>", {silent = true})
            keymap("n", "<Leader>rg", ":Rg <C-R><C-W><CR>", {silent = true})
        end
    }
    use "junegunn/fzf.vim"
    use {
        "ojroques/nvim-lspfuzzy",
        config = function()
            lspfuzzy = require "lspfuzzy"
            lspfuzzy.setup{}
        end,
    }

    -- ui
    use {
        "itchyny/lightline.vim",
        config = function()
            vim.g.lightline = {
                colorscheme = "gruvbox",
                enable = {
                    statusline = 1,
                    tabline = 1,
                },
                active = {
                    left = {
                        {"mode", "paste"},
                        {"readonly", "filename", "modified"},
                    },
                    right = {
                        {"lineinfo"},
                        {"percent"},
                        {"diagnostic_hints", "diagnostic_infos", "diagnostic_warnings", "diagnostic_errors"}
                    },
                    tabline = {
                        right = {{"close"}},
                    }
                },
                component_expand = {
                    diagnostic_errors = "v:lua.diagnostic_errors",
                    diagnostic_warnings = "v:lua.diagnostic_warnings",
                    diagnostic_infos = "v:lua.diagnostic_infos",
                    diagnostic_hints = "v:lua.diagnostic_hints",
                },
                component_type = {
                    diagnostic_errors = "error",
                    diagnostic_warnings = "warning",
                    diagnostic_infos = "warning",
                    diagnostic_hints = "warning",
                },
            }

            local diagnostic_callbacks = {
                {name = "diagnostic_errors", severity = vim.diagnostic.severity.ERROR, symbol = "E"},
                {name = "diagnostic_warnings", severity = vim.diagnostic.severity.WARN, symbol = "W"},
                {name = "diagnostic_infos", severity = vim.diagnostic.severity.INFO, symbol = "I"},
                {name = "diagnostic_hints", severity = vim.diagnostic.severity.HINT, symbol = "H"},
            }
            for _, l in pairs(diagnostic_callbacks) do
                _G[l["name"]] = function()
                    local diagnostics = vim.diagnostic.get(0, { severity = l["severity"] })
                    local count = table.getn(diagnostics)
                    if count == 0 then return "" end
                    return string.format("%s:%d", l["symbol"], count)
                end
            end

            vim.api.nvim_command('augroup diagnostic_aucmds')
            vim.api.nvim_command('au! * <buffer>')
            vim.api.nvim_command('au DiagnosticChanged * call lightline#update()')
            vim.api.nvim_command('augroup END')
        end
    }
    use {
        "mgee/lightline-bufferline",
        after = "lightline.vim",
        config = function()
            vim.o.showtabline = 2

            local lightline = vim.g.lightline or {}
            lightline.tabline = {
                left = {{"buffers"}}
            }
            lightline.component_expand.buffers = "lightline#bufferline#buffers"
            lightline.component_type.buffers = "tabsel"
            vim.g.lightline = lightline
        end
    }
    use "ntpeters/vim-better-whitespace"

    -- git
    use "airblade/vim-gitgutter"
    use {
        "jreybert/vimagit",
        cmd = {"Magit", "MagitOnly"}
    }
end)
