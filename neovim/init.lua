local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set vim options

-- Map leader to space
g.mapleader = " "

-- Set shell to bash to avoid performance issues
-- so far, this has only happened to me with the nvim-tree plugin
opt.shell = "/bin/bash"

-- Keep treesitter parsers in sync with the plugin when it updates
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Plugins (managed by the built-in vim.pack; update with :lua vim.pack.update())
local gh = function(repo) return "https://github.com/" .. repo end
vim.pack.add({
  gh("tpope/vim-surround"),                       -- Vim grammer extension for surrounding characters
  { src = gh("catppuccin/nvim"), name = "catppuccin" }, -- Catppuccin theme
  gh("nvim-lualine/lualine.nvim"),                -- Statusline
  gh("nvim-tree/nvim-tree.lua"),                  -- File tree viewer
  gh("nvim-tree/nvim-web-devicons"),              -- Prettier icons
  gh("smoka7/hop.nvim"),                          -- Easily hop around a file
  gh("nvim-treesitter/nvim-treesitter"),          -- Better syntax highlighting

  gh("nvim-lua/plenary.nvim"),                    -- Lua helper functions (dependency of telescope)
  gh("nvim-telescope/telescope-fzy-native.nvim"), -- native fuzzy finder for Telescope
  gh("nvim-telescope/telescope.nvim"),            -- Extensible fuzzy finder
}, { confirm = false })

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
opt.showmode = true                 -- Show what mode you are in
opt.autoread = true -- Reload files that have changed on disk
opt.clipboard = "unnamedplus" -- Allow copy/ pasting from system clipboard
opt.mouse = "a" -- enable the mouse

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

map(NORMAL_MODE, LEADER .. "sv", ":luafile %<CR>")            -- Source nvimrc file
map(NORMAL_MODE, LEADER .. "ev", "<cmd>e $MYVIMRC<CR>")       -- Edit nvimrc file
map(NORMAL_MODE, LEADER .. "sa", "ggVG<c-$>")                 -- Select all of a file
map(NORMAL_MODE, "<esc>", ":noh<cr><esc>", { silent = true }) -- After searching, pressing escape stops the highlight

-- Easier Split Management
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
map(NORMAL_MODE, LEADER .. "j", "<C-W><C-J>", { silent = true })
map(NORMAL_MODE, LEADER .. "k", "<C-W><C-K>", { silent = true })
map(NORMAL_MODE, LEADER .. "l", "<C-W><C-L>", { silent = true })
map(NORMAL_MODE, LEADER .. "h", "<C-W><C-H>", { silent = true })

-- Theme setup
local theme = require("catppuccin")
theme.setup({
  flavour = "frappe",
  transparent_background = true,
})
vim.cmd.colorscheme "catppuccin"

-- Lualine configuration
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = ' ', right = ' '},
    section_separators = { left = "│", right = "│" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Nvim Tree configuration
require'nvim-tree'.setup {
  sync_root_with_cwd = true
}
map(NORMAL_MODE, LEADER .. "d", ":NvimTreeToggle<CR>", { silent = true })

-- Hop configuration
require'hop'.setup{
  jump_on_sole_occurrence = true
}
map(NORMAL_MODE, LEADER .. " ", ":HopChar2<CR>")

-- Treesitter (syntax highlighting) configuration
-- Requires the tree-sitter CLI (brew install tree-sitter-cli) to build parsers
local ts = require'nvim-treesitter'
local ignore_install = { "javascript", "haskell" } -- List of parsers to skip installing
local highlight_disable = { "c", "rust" }         -- List of languages to not highlight with treesitter
ts.install(vim.tbl_filter(function(lang)          -- Installs asynchronously; already installed parsers are skipped
  return not vim.list_contains(ignore_install, lang)
end, ts.get_available()))
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.list_contains(highlight_disable, args.match) then return end
    pcall(vim.treesitter.start, args.buf) -- No-op for filetypes without an installed parser
  end,
})

-- Telescope configuration
require("telescope").load_extension("fzy_native")
map(NORMAL_MODE, LEADER .. "t", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map(NORMAL_MODE, LEADER .. "b", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map(NORMAL_MODE, LEADER .. "f", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
require("telescope").setup({
  defaults = {
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

