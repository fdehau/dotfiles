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
vim.cmd([[
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
]])

-- search
vim.o.ignorecase = true
vim.o.smartcase = true

-- replace
vim.o.inccommand = "nosplit"

-- key mappings
vim.o.mouse = "a"

function keymap(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymap("i", "jj", "<Esc>")
keymap("v", "jj", "<Esc>")
keymap("n", "<Leader>w", ":w<CR>")
keymap("n", "<Leader>wq", ":wq<CR>")
keymap("n", "<Leader>q", ":q<CR>")
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
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	msg = table.concat({
		"lazy.nvim is not installed, please run:",
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}, " ")
	vim.print(msg)
	return
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- colors
	{
		"morhetz/gruvbox",
		config = function()
			function set_colorschme(mode)
				if mode == "dark" then
					vim.o.background = "dark"
					vim.fn.setenv("BAT_THEME", "gruvbox-dark")
				else
					vim.o.background = "light"
					vim.fn.setenv("BAT_THEME", "gruvbox-light")
				end
			end

			-- defaults
			vim.g.gruvbox_italic = 1
			vim.cmd("colorscheme gruvbox")
			vim.o.background = "dark"

			-- override with light colorscheme if MacOS is not in dark mode
			local sys_name = vim.loop.os_uname().sysname
			if sys_name == "Darwin" then
				local apple_interface_style = vim.fn.trim(vim.fn.system({
					"defaults",
					"read",
					"-g",
					"AppleInterfaceStyle",
				}))
				if apple_interface_style ~= "Dark" then
					set_colorschme("light")
				end
			end

			-- keymap to toggle colorscheme
			vim.keymap.set("n", "<Leader>bg", function()
				if vim.o.background == "dark" then
					set_colorschme("light")
				else
					set_colorschme("dark")
				end
			end)
		end,
	},

	-- edits
	"tpope/vim-surround",
	{
		"junegunn/vim-easy-align",
		config = function()
			-- start interactive EasyAlign in visual mode (e.g. vipga)
			keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false })
			-- start interactive EasyAlign for a motion/text object (e.g. gaip)
			keymap("v", "ga", "<Plug>(EasyAlign)", { noremap = false })
		end,
	},
	"tpope/vim-commentary",
	"terryma/vim-expand-region",

	-- moving around
	{
		"justinmk/vim-sneak",
		config = function()
			vim.g["sneak#streak"] = 1
		end,
	},
	"christoomey/vim-tmux-navigator",

	-- lsp
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Global config
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					update_in_insert = false,
				})

			-- Servers config
			lsp = require("lspconfig")
			lsp.rust_analyzer.setup({})
			lsp.gopls.setup({
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
				settings = {
					gopls = {
						["local"] = "github.com/DataDog",
					},
				},
			})

			-- Keymaps
			keymap("n", "<leader>mn", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
			keymap("n", "<leader>mp", "<cmd>lua vim.diagnostic.goto_next()<CR>")
			keymap("n", "<leader>ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
			keymap("n", "<leader>md", "<cmd>lua vim.lsp.buf.definition()<CR>")
			keymap("n", "<leader>mf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
			keymap("n", "<leader>mh", "<cmd>lua vim.lsp.buf.hover()<CR>")
			keymap("n", "<leader>mr", "<cmd>lua vim.lsp.buf.references()<CR>")
			keymap("n", "<leader>mR", "<cmd>lua vim.lsp.buf.rename()<CR>")
			keymap("n", "<leader>ms", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
			vim.keymap.set("n", "<Leader>mi", function()
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.organizeImports" } }
				timeout_ms = 10000
				local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
				for cid, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
							vim.lsp.util.apply_workspace_edit(r.edit, enc)
						end
					end
				end
			end)
		end,
	},

	-- completion
	{
		"shougo/deoplete.nvim",
		build = function()
			vim.fn["remote#host#UpdateRemotePlugins"]()
		end,
		config = function()
			keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
			keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
			vim.o.completeopt = "menuone,noinsert,noselect"
			vim.fn["deoplete#custom#option"]({
				smart_case = true,
				max_list = 10,
			})
			vim.fn["deoplete#enable"]()
		end,
	},
	"Raimondi/delimitMate",

	-- navigation
	{
		"junegunn/fzf",
		build = function()
			vim.fn["fzf#install"]()
		end,
		config = function()
			vim.g.fzf_colors = {
				fg = { "fg", "Normal" },
				bg = { "bg", "Normal" },
				hl = { "fg", "Comment" },
				["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
				["bg+"] = { "bg", "CursorLine", "CursorColumn" },
				["hl+"] = { "fg", "Statement" },
				info = { "fg", "PreProc" },
				border = { "fg", "Ignore" },
				prompt = { "fg", "Conditional" },
				pointer = { "fg", "Exception" },
				marker = { "fg", "Keyword" },
				spinner = { "fg", "Label" },
				header = { "fg", "Comment" },
			}
		end,
		keys = {
			{ "<leader>f", ":Files<CR>" },
			{ "<leader>o", ":Buffers <CR>" },
			{ "<leader>l", ":BLines <CR>" },
			{ "<leader>L", ":BLines <C-R><C-W><CR>" },
			{ "<leader>rg", ":Rg <C-R><C-W><CR>" },
		},
	},
	"junegunn/fzf.vim",
	{
		"ojroques/nvim-lspfuzzy",
		keys = {
			{ "<leader>mD", ":LspDiagnostics 0<CR>" },
		},
	},

	-- ui
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
			},
			tabline = {
				lualine_a = { "buffers" },
			},
		},
	},
	"ntpeters/vim-better-whitespace",

	-- git
	"airblade/vim-gitgutter",
	{
		"jreybert/vimagit",
		cmd = { "Magit", "MagitOnly" },
	},

	-- tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = { "fish", "lua", "terraform" },
			},
		},
	},
	{
		"github/copilot.vim",
		cmd = { "Copilot" },
	},
})
