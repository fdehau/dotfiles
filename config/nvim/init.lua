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

-- lsp
if vim.g.vscode then
	keymap("n", "<leader>mn", "<cmd>lua require('vscode').call('editor.action.marker.next')<CR>")
	keymap("n", "<leader>mp", "<cmd>lua require('vscode').call('editor.action.marker.prev')<CR>")
else
	keymap("n", "<leader>mn", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
	keymap("n", "<leader>mp", "<cmd>lua vim.diagnostic.goto_next()<CR>")
end

keymap("n", "<leader>ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
keymap("n", "<leader>md", "<cmd>lua vim.lsp.buf.definition()<CR>")
keymap("n", "<leader>mf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
keymap("n", "<leader>mh", "<cmd>lua vim.lsp.buf.hover()<CR>")
keymap("n", "<leader>mr", "<cmd>lua vim.lsp.buf.references()<CR>")
keymap("n", "<leader>mR", "<cmd>lua vim.lsp.buf.rename()<CR>")
keymap("n", "<leader>ms", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")

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
		cond = not vim.g.vscode,
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

	-- lsp
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		config = function()
			-- Global config
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					update_in_insert = false,
				})

			-- Servers config
			vim.lsp.config("gopls", {
				root_dir = function(bufnr, on_dir)
					-- Avoid loading the world when working on big monorepo
					return on_dir(vim.fn.getcwd())
				end,
				settings = {
					gopls = {
						["local"] = "github.com/DataDog",
					},
				},
			})
			vim.lsp.enable({ "rust_analyzer", "gopls" })

			-- Keymaps
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
	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.comment").setup()
			require("mini.move").setup()
			require("mini.align").setup()
			require("mini.trailspace").setup()

			if vim.g.vscode then
				return
			end

			require("mini.pairs").setup()
			require("mini.completion").setup()
			require("mini.git").setup()
			require("mini.diff").setup()
			local map_multistep = require("mini.keymap").map_multistep
			map_multistep("i", "<Tab>", { "pmenu_next" })
			map_multistep("i", "<S-Tab>", { "pmenu_prev" })
			map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
			map_multistep("i", "<BS>", { "minipairs_bs" })
		end,
	},

	-- navigation
	{
		"junegunn/fzf",
		cond = not vim.g.vscode,
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
	{
		"junegunn/fzf.vim",
		cond = not vim.g.vscode,
	},

	-- ui
	{
		"nvim-lualine/lualine.nvim",
		cond = not vim.g.vscode,
		opts = {
			options = {
				icons_enabled = false,
			},
			tabline = {
				lualine_a = { "buffers" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "lsp_status", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

	-- selection
	"terryma/vim-expand-region",

	-- git
	{
		"jreybert/vimagit",
		cond = not vim.g.vscode,
		cmd = { "Magit", "MagitOnly" },
	},

	-- tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		cond = not vim.g.vscode,
		opts = {
			highlight = {
				enable = { "fish", "lua", "terraform" },
			},
		},
	},
})
