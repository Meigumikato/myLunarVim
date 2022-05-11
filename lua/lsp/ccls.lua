vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ccls" })
local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  -- local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local ccls_cmd = "ccls"

local opts = {
  cmd = {ccls_cmd},
  on_attach = custom_on_attach,
  init_options = {
		highlight = {
      lsRanges = true;
    };
    cache = {
      directory = ".ccls-cache";
    };
		clang = {
			extraArgs = {"-stdc++=20, -Wall, -Werror, --gcc-toolchain=/usr/local/include/c++/11.2.0/"};
      excludeArgs = {'-frounding-math'} ;
    };
		compilationDatabaseDirectory = "build";
		filetypes = { "c", "cpp"};
  }
}

require("lvim.lsp.manager").setup("ccls", opts)
