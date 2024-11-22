return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.ruby_lsp.setup({
        cmd = {"/Users/max/.rbenv/shims/ruby-lsp"}
      })
    end,
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover documentation LSP" }),
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = "GOTO Definition LSP" }),
  }
}

