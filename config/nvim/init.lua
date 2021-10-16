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

-- history
vim.bo.undofile = true
vim.o.history = 50

-- no tabs and all tabs are 4 spaces
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

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
            vim.cmd("colorscheme gruvbox")
            vim.o.background = "dark"

            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_contrast_dark = "medium"
            keymap("n", "<Leader>bg", ':let &background = ( &background == "dark" ? "light" : "dark")<CR>')
        end
    }

    -- edits
    use "tpope/vim-surround"
    use {
        "junegunn/vim-easy-align",
        config = function()
            -- start interactive EasyAlign in visual mode (e.g. vipga)
            keymap("x", "ga", '<Plug>(EasyAlign)')
            -- start interactive EasyAlign for a motion/text object (e.g. gaip)
            keymap("v", "ga", '<Plug>(EasyAlign)')
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
            keymap("v", "<C-Up>", "<Plug>MoveBlockUp")
            keymap("v", "<C-Down>", "<Plug>MoveBlockDown")
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
            keymap("n", "<leader>mn", '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
            keymap("n", "<leader>mp", '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
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
                        {"lsp_hints", "lsp_infos", "lsp_warnings", "lsp_errors"}
                    },
                    tabline = {
                        right = {{"close"}},
                    }
                },
                component_expand = {
                    lsp_errors = "v:lua.lsp_errors",
                    lsp_warnings = "v:lua.lsp_warnings",
                    lsp_infos = "v:lua.lsp_infos",
                    lsp_hints = "v:lua.lsp_hints",
                },
                component_type = {
                    lsp_errors = "error",
                    lsp_warnings = "warning",
                    lsp_infos = "info",
                    lsp_hints = "info",
                },
            }

            local lsp_callbacks = {
                {name = "lsp_errors", severity = [[Error]], symbol = "E"},
                {name = "lsp_warnings", severity = [[Warning]], symbol = "W"},
                {name = "lsp_infos", severity = [[Info]], symbol = "I"},
                {name = "lsp_hints", severity = [[Hint]], symbol = "H"},
            }
            for _, l in pairs(lsp_callbacks) do
                _G[l["name"]] = function()
                    local count = vim.lsp.diagnostic.get_count(0, l["severity"])
                    if count == 0 then return "" end
                    return string.format("%s:%d", l["symbol"], count)
                end
            end

            vim.api.nvim_command('augroup lsp_aucmds')
            vim.api.nvim_command('au! * <buffer>')
            vim.api.nvim_command('au User LspDiagnosticsChanged call lightline#update()')
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
        cmd = {"Magit", "MagitOnly"}
    }
end)
