local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set vim options

-- Map leader to space
g.mapleader = " "

-- Bootstrap package manager
local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path })
end

-- Plugins
require "paq" {
  "savq/paq-nvim"; -- let Paq manage itself

  "tpope/vim-surround";
  "EdenEast/nightfox.nvim"; -- Nightfox theme
  "nvim-treesitter/nvim-treesitter"; -- Better syntax highlighting

  "nvim-lua/plenary.nvim"; -- dependency of telescope
  "nvim-telescope/telescope-fzy-native.nvim"; -- native fuzzy finder for Telescope
  "nvim-telescope/telescope.nvim"; -- Extensible fuzzy finder
}

-- Use spaces instead of tabs
local spaces = 2 -- Number of spaces to use
opt.expandtab = true
opt.softtabstop = spaces
opt.tabstop = spaces
opt.shiftwidth = spaces

-- Be smarter about indenting
opt.autoindent = true
opt.smartindent = true

-- Show trailing whitespace
opt.list = true
opt.listchars = { tab = "▸ ", trail = "▫" }

-- Show line numbers
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers

-- Better buffer search
opt.hlsearch = true   -- Highlight found searches
opt.ignorecase = true -- Ignore case
opt.smartcase = true  -- Except when explicitly searching with capitals
opt.incsearch = true  -- Show the match while typing (incremental searching)
opt.showmatch = true  -- Show matching parenthesis

-- Persist undo buffer across editor instances
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
opt.undolevels = 1000

-- Command menu ergonomics
opt.wildmenu = true                 -- Enhanced command line completion
opt.wildmode = 'longest:full,full'  -- Autocomplete matches sanely
opt.history = 1000                  -- Store 1000 previous history entries

-- View settings
opt.linebreak = true      -- Stop words being broken on wrap
opt.numberwidth = 5       -- Make the gutter wider by default
opt.scrolloff = 4         -- Lines of context
opt.sidescrolloff = 8     -- Columns of context
opt.wrap = true
opt.cursorline = true     -- Highlight the current line
opt.cursorcolumn = false  -- Highlight the current column

-- Misc other settings
opt.hidden = true -- Enable background buffers
opt.backspace = {"indent", "eol", "start"}
opt.joinspaces = false -- No double spaces with join
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.showmode = true                 -- Show what mode you are in
opt.autoread = true -- Reload files that have changed on disk
opt.clipboard = "unnamedplus" -- Allow copy/ pasting from system clipboard

-- Theme setup
local nightfox = require("nightfox")
nightfox.setup({
  fox = "nordfox",
  alt_nc = true,
  visual = true,
  search = true,
  styles = {
    comments = "italic",
    keywords = "bold",
    functions = "italic,bold",
  },
})
nightfox.load()

-- Custom key mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local NORMAL_MODE = "n"
local VISUAL_MODE = "v"
local INSERT_MODE = "i"
local LEADER = "<leader>"

-- Source nvimrc file
map(NORMAL_MODE, LEADER .. "sv", ":luafile %<CR>")

-- Edit nvimrc file
map(NORMAL_MODE, LEADER .. "ev", "<cmd>e $MYVIMRC<CR>")

-- Select all of a file
map(NORMAL_MODE, LEADER .. "sa", "ggVG<c-$>")

-- Treesitter (syntax highlighting) configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Telescope configuration
require("telescope").load_extension("fzy_native")
map(NORMAL_MODE, LEADER .. "t", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map(NORMAL_MODE, LEADER .. "b", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map(NORMAL_MODE, LEADER .. "f", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
require("telescope").setup({
  defaults = {
    winblend = 20,
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 140,
      },
      vertical = {
        preview_cutoff = 40,
        prompt_position = "bottom",
      },
      horizontal = {
        width = 0.9,
        height = 0.8,
      },
    },
  },
})

