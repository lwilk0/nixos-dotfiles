return {
  -- Disable Mason entirely
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  
  -- Ensure LSP config still works without mason
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Remove the mason setup hook
      servers = {
        rust_analyzer = {},
        bashls = {},
        nil_ls = {},
        yamlls = {},
      },
      setup = {},
    },
  },
}
