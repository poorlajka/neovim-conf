-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '

vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- NOTE: First, some plugins that don't require any configuration
	--
	--

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	'ethanholz/nvim-lastplace',

	--Icons
	'nvim-tree/nvim-web-devicons',

	'ggandor/leap.nvim',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()
		end,
	},

	--Smartsplits
	{
		'mrjones2014/smart-splits.nvim'
	},

	{
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				theme = 'hyper',
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{
							desc = '󰊳 Update',
							group = '@property',
							action = 'Lazy update',
							key = 'u'
						},
						{
							icon = ' ',
							icon_hl = '@variable',
							desc = 'Files',
							group = 'Label',
							action = 'Telescope find_files',
							key = 'f',
						},
						{
							desc = ' Apps',
							group = 'DiagnosticHint',
							action = 'Telescope app',
							key = 'a',
						},
						{
							desc = ' dotfiles',
							group = 'Number',
							action = 'Telescope dotfiles',
							key = 'd',
						},
					},
					footer = {},
				},
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},


	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	--Nvimtree
	{
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	},
	{
		'tamton-aquib/staline.nvim'
	},
	{
		'toppair/peek.nvim'
	},

	-- Useful plugin to show you pending keybinds.
	--{ 'folke/which-key.nvim', opts = {} },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
				vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
				vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = '[P]review [H]unk' })
			end,
		}
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	--RBG color highlighting
	{
		'norcalli/nvim-colorizer.lua'
	},

	--Scrollbar
	{
		"petertriho/nvim-scrollbar"
	},

	--Bufferline
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons'
	},


	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},

	--[[
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
]] --

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			show_end_of_line = true,
			indentLine_enabled = 1,
			filetype_exclude = {
				"help",
				"terminal",
				"lazy",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"mason",
				"nvdash",
				"nvcheatsheet",
				"dashboard",
			},
			buftype_exclude = { "terminal" },
			show_trailing_blankline_indent = false,
			show_first_indent_level = false,
			show_current_context = true,
			show_current_context_start = true,
		},
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',         opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter', -- NOTE: Here is where you install your plugins.
		--  You can configure plugins using the `config` key.
		--
		--  You can also configure plugins after the setup call,
		--    as they will be available in your neovim runtime.

		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},


	-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
	--       These are some example plugins that I've included in the kickstart repository.
	--       Uncomment any of the lines below to enable them.
	--require 'autoformat',
	-- require 'kickstart.plugins.debug',

	-- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
	--    up-to-date with whatever is in the kickstart repo.
	--
	--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
	--{ import = 'custom.plugins' },
}, {})

require('leap').add_default_mappings()
require("bufferline").setup {}

-- default config:
require('peek').setup({
	auto_load = true,     -- whether to automatically load preview when
	-- entering another markdown buffer
	close_on_bdelete = true, -- close preview window on buffer delete

	syntax = true,        -- enable syntax highlighting, affects performance

	theme = 'dark',       -- 'dark' or 'light'

	update_on_change = true,

	--app = 'browser', -- 'webview', 'browser', string or a table of strings
	app = { 'chromium', '--new-window' },
	-- explained below

	filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

	-- relevant if update_on_change is true
	throttle_at = 200000, -- start throttling when file exceeds this
	-- amount of bytes in size
	throttle_time = 'auto', -- minimum amount of time in milliseconds
	-- that has to pass before starting new render
})
vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

require('smart-splits').setup({
	-- Ignored filetypes (only while resizing)
	ignored_filetypes = {
		'nofile',
		'quickfix',
		'prompt',
	},
	-- Ignored buffer types (only while resizing)
	ignored_buftypes = { 'NvimTree' },
	-- the default number of lines/columns to resize by at a time
	default_amount = 3,
	-- Desired behavior when your cursor is at an edge and you
	-- are moving towards that same edge:
	-- 'wrap' => Wrap to opposite side
	-- 'split' => Create a new split in the desired direction
	-- 'stop' => Do nothing
	-- function => You handle the behavior yourself
	-- NOTE: If using a function, the function will be called with
	-- a context object with the following fields:
	-- {
	--    mux = {
	--      type:'tmux'|'wezterm'|'kitty'
	--      current_pane_id():number,
	--      is_in_session(): boolean
	--      current_pane_is_zoomed():boolean,
	--      -- following methods return a boolean to indicate success or failure
	--      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
	--      next_pane(direction:'left'|'right'|'up'|'down'):boolean
	--      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
	--      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
	--    },
	--    direction = 'left'|'right'|'up'|'down',
	--    split(), -- utility function to split current Neovim pane in the current direction
	--    wrap(), -- utility function to wrap to opposite Neovim pane
	-- }
	-- NOTE: `at_edge = 'wrap'` is not supported on Kitty terminal
	-- multiplexer, as there is no way to determine layout via the CLI
	at_edge = 'wrap',
	-- when moving cursor between splits left or right,
	-- place the cursor on the same row of the *screen*
	-- regardless of line numbers. False by default.
	-- Can be overridden via function parameter, see Usage.
	move_cursor_same_row = false,
	-- whether the cursor should follow the buffer when swapping
	-- buffers by default; it can also be controlled by passing
	-- `{ move_cursor = true }` or `{ move_cursor = false }`
	-- when calling the Lua function.
	cursor_follows_swapped_bufs = false,
	-- resize mode options
	resize_mode = {
		-- key to exit persistent resize mode
		quit_key = '<ESC>',
		-- keys to use for moving in resize mode
		-- in order of left, down, up' right
		resize_keys = { 'h', 'j', 'k', 'l' },
		-- set to true to silence the notifications
		-- when entering/exiting persistent resize mode
		silent = false,
		-- must be functions, they will be executed when
		-- entering or exiting the resize mode
		hooks = {
			on_enter = nil,
			on_leave = nil,
		},
	},
	-- ignore these autocmd events (via :h eventignore) while processing
	-- smart-splits.nvim computations, which involve visiting different
	-- buffers and windows. These events will be ignored during processing,
	-- and un-ignored on completed. This only applies to resize events,
	-- not cursor movement events.
	--[[
	ignored_events = {
		'BufEnter',
		'WinEnter',
	},
	]] --
	-- enable or disable a multiplexer integration;
	-- automatically determined, unless explicitly disabled or set,
	-- by checking the $TERM_PROGRAM environment variable,
	-- and the $KITTY_LISTEN_ON environment variable for Kitty
	multiplexer_integration = nil,
	-- disable multiplexer navigation if current multiplexer pane is zoomed
	-- this functionality is only supported on tmux and Wezterm due to kitty
	-- not having a way to check if a pane is zoomed
	disable_multiplexer_nav_when_zoomed = true,
	-- Supply a Kitty remote control password if needed,
	-- or you can also set vim.g.smart_splits_kitty_password
	-- see https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password
	kitty_password = nil,
	-- default logging level, one of: 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
	log_level = 'info',
})

require 'nvim-web-devicons'.setup {
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		}
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore"
		}
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log"
		}
	},
}

local colors = require("tokyonight.colors").setup()

MOCHA = require('catppuccin.palettes').get_palette("frappe")
require("scrollbar").setup({
	handle = {
		color = MOCHA.text,
		text = " ",
		blend = 60,
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = false, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
		ale = false, -- Requires ALE
	},
})

require("nvim-tree").setup({
})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Set relative linenumber
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.tabstop = 4

-- Set wrapping line
--vim.cmd("set colorcolumn=80")

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


vim.opt.laststatus = 2
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

vim.keymap.set('n', '<C-c>', '<silent> <C-c>', { silent = true })

vim.keymap.set({ "n", "v" }, "<C-c>", "<Esc>")

--Remap carrot keybinds cause I hate reaching for it
vim.keymap.set('n', '<C-p>', '<C-^>')
vim.keymap.set('n', '0', '^')

vim.keymap.set('n', '0', '^')


--Buffer stuff
--vim.keymap.set('n', '<C-q>', ':bd <CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-q>', ':normal @q <CR>', { silent = true })

-- Autocmd for nvim-tree
bg = require('catppuccin.palettes').get_palette("mocha").mantle,
	vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=#040407")
--File explorer
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle <CR>", { silent = true })

vim.keymap.set("n", "<C-o>", "15<C-o>", { silent = true })
vim.keymap.set("n", "<C-d>", "15<C-d>", { silent = true })

-- resizing splits
vim.keymap.set('n', '<S-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<S-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<S-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<S-l>', require('smart-splits').resize_right)

-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

require("nvterm").setup({
	terminals = {
		shell = vim.o.shell,
		list = {},
		type_opts = {
			float = {
				relative = 'editor',
				row = 0.15,
				col = 0.1,
				width = 0.8,
				height = 0.7,
				border = "none",
			},
			horizontal = { location = "rightbelow", split_ratio = .3, },
			vertical = { location = "rightbelow", split_ratio = .5 },
		}
	},
	behavior = {
		autoclose_on_quit = {
			enabled = false,
			confirm = true,
		},
		close_on_exit = true,
		auto_insert = true,
	},
})

vim.keymap.set('n', '<C-t>',
	function()
		require("nvterm.terminal").toggle("float")
	end
)

-- swapping buffers between windows
vim.keymap.set('n', '<A-h>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').swap_buf_right)

vim.keymap.set('n', '<A-l>', require('smart-splits').swap_buf_right)

--local group = vim.api.nvim_create_augroup("ResumeBuffer", { clear = true })
--vim.api.nvim_create_autocmd({ "BufReadPost" }, { command = "'\"", group = group })

--Last position jump
local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
	"BufReadPost",
	{
		callback = function()
			local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
			vim.api.nvim_win_set_cursor(0, { row, col })
		end,
		group = group
	}
)


require 'staline'.setup {
	sections = {
		left  = {
			'- ', '-mode',
			'- ', "-file_name", "left_sep", 'branch', --'  ', 'branch'
		},
		mid   = { " " },                     --'lsp' },
		right = {
			'lsp', ' ',                      --'cool_symbol', ' ',     --'  ',
			vim.bo.fileencoding:upper(), 'right_sep', "-lsp_name", '-line_column'
		}
	},
	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		bg = require('catppuccin.palettes').get_palette("mocha").crust,
		inactive_bgcolor = "none", --require('catppuccin.palettes').get_palette("mocha").surface2,
		inactive_color = "none",

		--fg = require('tokyonight.colors').night.bg_dark,
		full_path = false,
		font_inactive = "none",
		branch_symbol = " "
	},
	inactive_sections = {
		left = {},
		mid = { 'file_name' },
		right = {},
	},
	mode_colors = {
		n = MOCHA.pink,
		i = MOCHA.red,
		ic = MOCHA.red,
		c = MOCHA.peach,
		v = MOCHA.teal,
		vil = MOCHA.flamingo,
	},
}
require 'nvim-lastplace'.setup {}


require('telescope').setup {
	defaults = {
		pickers = {
			find_files = {
				theme = "dropdown",
				hidden = false
			}
		},
		extensions = {
		},
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		mappings = {
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-j>"] = require("telescope.actions").move_selection_next,
			},
		},
	},

	extensions_list = { "themes", "terms" },

}

require 'colorizer'.setup()

--Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-e>', builtin.find_files)
vim.keymap.set('n', '<C-g>', builtin.live_grep)
vim.keymap.set('n', '<C-f>', builtin.buffers)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



local telescopeBorderless = function(flavor)
	local cp = require("catppuccin.palettes").get_palette(flavor)
	local bg = "#040407"
	local dark = "#000000"

	return {
		TelescopeBorder = { fg = bg, bg = bg }, --{ fg = cp.surface0, bg = cp.surface0 },
		TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
		TelescopeMatching = { fg = cp.peach },
		TelescopeNormal = { bg = bg },
		TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
		TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },

		TelescopeTitle = {}, --fg = cp.crust, }, --bg = cp.green },
		--TelescopePreviewTitle = { fg = cp.crust, bg = cp.red },
		--TelescopePromptTitle = { fg = cp.crust, bg = cp.mauve },

		TelescopePromptNormal = { fg = cp.flamingo, bg = dark },
		TelescopePromptBorder = { fg = dark, bg = dark },
	}
end

require("catppuccin").setup {
	transparent_background = false,
	highlight_overrides = {
		latte = telescopeBorderless('latte'),
		frappe = telescopeBorderless('frappe'),
		macchiato = telescopeBorderless('macchiato'),
		mocha = telescopeBorderless('mocha'),
	},
	color_overrides = {
		mocha = {
			--base = "#0F0F18",
			base = "#06060a",
		}
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		notify = false,
		mini = false,
		dashboard = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
}

vim.cmd.colorscheme("catppuccin-mocha")

vim.cmd("highlight LineNr guifg=#b3afc4")


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'haskell', },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<M-space>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	},
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-;>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	--nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	--nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	--nmap('<leader>wl', function()
	--print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	--end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	clangd = {},
	gopls = {},
	pyright = {},
	rust_analyzer = {},
	tsserver = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}

vim.cmd [[highlight IndentBlanklineIndent6 guifg=#f38ba8 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#fab387 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#a6e3a1 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#89dceb gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#89b4fa gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#f5c2e7 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent0 guifg=#313244 gui=nocombine]]
--[[
require("indent_blankline").setup {
  char_highlight_list = {
    --"IndentBlanklineIndent0",
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
]]
--
