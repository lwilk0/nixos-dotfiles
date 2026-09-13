{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };
  };

  programs.nixvim = {
    enable = true;

    # Basic editor behavior
    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      cursorline = true;
      termguicolors = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      ignorecase = true;
      smartcase = true;
      splitbelow = true;
      splitright = true;
      clipboard = "unnamedplus";
      updatetime = 250;
      timeoutlen = 400;
    };

    globals.mapleader = " ";
    colorschemes.tokyonight.enable = true;

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      which-key.enable = true;

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
      };

      neo-tree = {
        enable = true;
        filesystem = {
          followCurrentFile = {
            enabled = true;
          };
          filteredItems = {
            hideDotfiles = false;
            hideGitignored = false;
          };
        };
        window = {
          width = 32;
        };
      };

      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "rust"
            "toml"
            "nix"
            "bash"
            "lua"
            "json"
            "yaml"
            "markdown"
          ];

          highlight.enable = true;
          indent.enable = true;
        };
      };

      luasnip = {
        enable = true;

        fromVscode = [
          {}
        ];
      };
      
      cord = {
        enable = true;

        settings = {
          editor = {
            client = "neovim";
          };

          display = {
            theme = "default";
            flavor = "dark";
          };

          idle = {
            enabled = false;
          };

          timer = {
            enable = true;
          };
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;

      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";

            "<Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require("luasnip")

                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif vim.fn.col(".") > 1 and
                      vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s") == nil then
                  cmp.complete()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require("luasnip")

                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
          bashls.enable = true;

          # rustaceanvim owns Rust LSP setup
          rust-analyzer.enable = false;
        };
      };

      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      rustaceanvim
      friendly-snippets
    ];

    extraPackages = with pkgs; [
      # Language servers
      rust-analyzer
      nixd
      bash-language-server

      # Formatters and linters
      rustfmt
      alejandra
      shfmt
      shellcheck

      # Navigation and editor utilities
      ripgrep
      fd

      # Rust debugging
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];
    
    extraConfigLua = ''
      local map = vim.keymap.set

      -- File navigation
      map("n", "<leader>e", "<cmd>Neotree toggle<CR>",
        { desc = "Toggle file tree" })

      map("n", "<leader>o", "<cmd>Neotree focus<CR>",
        { desc = "Focus file tree" })

      -- Telescope
      map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",
        { desc = "Find files" })

      map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",
        { desc = "Search project" })

      map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",
        { desc = "Find buffers" })

      map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",
        { desc = "Document symbols" })

      -- Automatically save regular, modified buffers.
      local autosave_group = vim.api.nvim_create_augroup(
        "autosave",
        { clear = true }
      )

      vim.api.nvim_create_autocmd({
        "InsertLeave",
        "FocusLost",
        "BufLeave",
      }, {
        group = autosave_group,
        pattern = "*",

        callback = function(args)
          local buf = args.buf

          if vim.bo[buf].buftype == ""
            and vim.bo[buf].modifiable
            and vim.bo[buf].modified
          then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("silent update")
            end)
          end
        end,
      })

      -- Configure diagnostics.
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,

        float = {
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
      })

      -- Show diagnostics for the current line when the cursor stops moving.
      local diagnostic_group = vim.api.nvim_create_augroup(
        "diagnostic_float",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("CursorHold", {
        group = diagnostic_group,

        callback = function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
            close_events = {
              "BufLeave",
              "CursorMoved",
              "InsertEnter",
            },
          })
        end,
      })

      -- Show the diagnostic under the cursor manually.
      map("n", "<leader>ed", function()
        vim.diagnostic.open_float(nil, {
          focus = true,
          scope = "cursor",
          border = "rounded",
        })
      end, { desc = "Show diagnostic" })

      -- Navigate between diagnostics.
      map("n", "[d", vim.diagnostic.goto_prev,
        { desc = "Previous diagnostic" })

      map("n", "]d", vim.diagnostic.goto_next,
        { desc = "Next diagnostic" })

      -- Show all diagnostics in the location list.
      map("n", "<leader>xx", vim.diagnostic.setloclist,
        { desc = "Diagnostics list" })

      -- Set LSP key mappings when an LSP server attaches to a buffer.
      local lsp_group = vim.api.nvim_create_augroup(
        "lsp_keymaps",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,

        callback = function(event)
          local opts = {
            buffer = event.buf,
            silent = true,
          }

          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gD", vim.lsp.buf.declaration, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)

          map("n", "<leader>lf", function()
            vim.lsp.buf.format({
              async = true,
              bufnr = event.buf,
            })
          end, opts)
        end,
      })

      -- Configure the Rust debugger.
      local dap = require("dap")
      local dapui = require("dapui")

      map("n", "<F5>", dap.continue,
        { desc = "Debug: continue/start" })

      map("n", "<F10>", dap.step_over,
        { desc = "Debug: step over" })

      map("n", "<F11>", dap.step_into,
        { desc = "Debug: step into" })

      map("n", "<F12>", dap.step_out,
        { desc = "Debug: step out" })

      map("n", "<leader>db", dap.toggle_breakpoint,
        { desc = "Debug: toggle breakpoint" })

      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: conditional breakpoint" })

      map("n", "<leader>du", dapui.toggle,
        { desc = "Debug: toggle debugger UI" })

      map("n", "<leader>dt", dap.terminate,
        { desc = "Debug: terminate" })

      -- Open the debugger UI when a debugging session starts.
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Close the debugger UI when a debugging session ends.
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Configure Rust Analyzer and CodeLLDB.
      vim.g.rustaceanvim = function()
        local cfg = require("rustaceanvim.config")

        return {
          server = {
            default_settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                },

                check = {
                  command = "clippy",
                },

                procMacro = {
                  enable = true,
                },

                inlayHints = {
                  bindingModeHints = {
                    enable = true,
                  },

                  closureReturnTypeHints = {
                    enable = "with_block",
                  },

                  lifetimeElisionHints = {
                    enable = "skip_trivial",
                  },
                },
              },
            },
          },

          dap = {
            adapter = cfg.get_codelldb_adapter(
              "codelldb",
              nil
            ),
          },
        }
      end
    '';
  };
}
