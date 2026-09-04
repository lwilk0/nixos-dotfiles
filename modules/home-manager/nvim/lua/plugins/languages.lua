return {
  -- 1. Rust
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lazyvim.plugins.extras.lang.rust",
      },
    },
  },

  -- 2. Bash
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lazyvim.plugins.extras.lang.bash",
      },
    },
  },

  -- 3. YAML
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lazyvim.plugins.extras.lang.yaml",
      },
    },
  },

  -- 4. Nix (No official LazyVim extra, so we define it manually)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {}, -- Uses the nil LSP installed via Nix
      },
    },
  },

  -- 5. Makefile (Just needs Treesitter, no LSP needed)
  -- LazyVim automatically installs Treesitter parsers if you open a file
  -- of that type, but we can force it here:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "make", "nix" })
      end
    end,
  },

  -- Configure Nix formatters (using alejandra installed via Nix)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
        sh = { "shfmt" },
        yaml = { "prettierd" },
      },
    },
  },
}
