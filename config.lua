--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
vim.cmd [[set mouse=""]]
vim.cmd [[set cmdheight=1]]

vim.cmd [[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]

vim.o.syntax = 'on'
vim.wo.relativenumber = true
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "gruvbox"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.transparent_window = true
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- lvim.keys.normal_mode["<C-o>"] = ":bd<CR>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["<space>t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"

lvim.builtin.bufferline.options.show_buffer_close_icons = false

lvim.builtin.notify.active = true

lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = true

lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.options.theme = "gruvbox-material"
lvim.builtin.lualine.sections.lualine_c = { "lsp_progress" }


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
require('lsp.ccls')

-- local clangd_flags = {
--   -- "--all-scopes-completion",
--   "--suggest-missing-includes",
--   "--background-index",
--   "--pch-storage=disk",
--   "--cross-file-rename",
--   "--log=info",
--   "--completion-style=detailed",
--   "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
--   "--clang-tidy",
--   -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
--   "--fallback-style=Google",
--   -- "--header-insertion=never",
--   "--compile-commands-dir=build",
--   "--query-driver=/usr/local/bin/gcc-11, /usr/local/bin/g++-11"
-- }

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ccls" })
-- local custom_on_attach = function(client, bufnr)
--   require("lvim.lsp").common_on_attach(client, bufnr)
--   -- local opts = { noremap = true, silent = true }
--   -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
-- end

-- local ccls_cmd = "ccls"

-- local opts = {
--   cmd = {ccls_cmd},
--   on_attach = custom_on_attach,
--   init_options = {
-- 		highlight = {
--       lsRanges = true;
--     };
--     cache = {
--       directory = ".ccls-cache";
--     };
-- 		clang = {
-- 			extraArgs = {"-stdc++=20, -Wall, -Werror, --gcc-toolchain=/usr/local/include/c++/11.2.0/"};
--       excludeArgs = {'-frounding-math'} ;
--     };
-- 		compilationDatabaseDirectory = "build";
-- 		filetypes = { "c", "cpp"};
--   }
-- }

-- require("lvim.lsp.manager").setup("ccls", opts)


-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
-- { exe = "clang-format", args = {} },
--}
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- set additional linters
--local linters = require "lvim.lsp.null-ls.ljinters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { 'fatih/vim-go' },
  { 'sainnhe/gruvbox-material' },
  { 'arkav/lualine-lsp-progress' },
  { 'luisiacc/gruvbox-baby' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'folke/tokyonight.nvim' },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  },
  { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup(require('code.indent'))
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require('rust-tools').setup(require('lsp.rust'))
    end,
    ft = { "rust", "rs" },
  },
  {
    'folke/todo-comments.nvim',
    config = function()
      require("todo-comments").setup(require('code.todo_comment'))
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.lua", "setlocal ts=2 sw=2" },
}
