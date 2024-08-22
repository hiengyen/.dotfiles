return {
  {
    --01_For Golang
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          gopls = {
            keys = {
              -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
              {
                "<leader>td",
                "<cmd>lua require('dap-go').debug_test()<CR>",
                desc = "Debug Nearest (Go)",
              },
            },
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  -- assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  -- functionTypeParameters = true,
                  -- parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                -- usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = {
                  "-.git",
                  "-.vscode",
                  "-.idea",
                  "-.vscode-test",
                  "-node_modules",
                },
                semanticTokens = true,
              },
            },
          },
        },
        setup = {
          gopls = function(_, opts)
            -- workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            LazyVim.lsp.on_attach(function(client, _)
              if client.name == "gopls" then
                if not client.server_capabilities.semanticTokensProvider then
                  local semantic =
                    client.config.capabilities.textDocument.semanticTokens
                  client.server_capabilities.semanticTokensProvider = {
                    full = true,
                    legend = {
                      tokenTypes = semantic.tokenTypes,
                      tokenModifiers = semantic.tokenModifiers,
                    },
                    range = true,
                  }
                end
              end
            end)
            -- end workaround
          end,
        },
      },
    },
    --02_Python
    {
      "neovim/nvim-lspconfig",
      dependencies = {},
      opts = {
        servers = {
          pyright = {},
          pylsp = {
            mason = false,
            settings = {
              pylsp = {
                plugins = {
                  rope_autoimport = {
                    enabled = true,
                  },
                },
              },
            },
          },
          ruff_lsp = {
            -- handlers = {
            --   ["textDocument/publishDiagnostics"] = function() end,
            -- },
          },
          -- jedi_language_server = {},
        },
        setup = {
          ruff_lsp = function()
            require("lazyvim.util").lsp.on_attach(function(client, _)
              if client.name == "ruff_lsp" then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
              end
            end)
          end,
          pyright = function()
            require("lazyvim.util").lsp.on_attach(function(client, _)
              if client.name == "pyright" then
                -- disable hover in favor of jedi-language-server
                client.server_capabilities.hoverProvider = false
              end
            end)
          end,
        },
      },
    },

    --04 Typescript & Javascript wrapper
    {
      "neovim/nvim-lspconfig",
      opts = {
        -- make sure mason installs the server
        servers = {
          tsserver = {
            enabled = false,
          },
          vtsls = {
            -- explicitly add default filetypes, so that we can extend
            -- them in related extras
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            settings = {
              complete_function_calls = true,
              vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
            keys = {
              {
                "gD",
                function()
                  local params = vim.lsp.util.make_position_params()
                  LazyVim.lsp.execute({
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                    open = true,
                  })
                end,
                desc = "Goto Source Definition",
              },
              {
                "gR",
                function()
                  LazyVim.lsp.execute({
                    command = "typescript.findAllFileReferences",
                    arguments = { vim.uri_from_bufnr(0) },
                    open = true,
                  })
                end,
                desc = "File References",
              },
              {
                "<leader>co",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
              {
                "<leader>cM",
                LazyVim.lsp.action["source.addMissingImports.ts"],
                desc = "Add missing imports",
              },
              {
                "<leader>cu",
                LazyVim.lsp.action["source.removeUnused.ts"],
                desc = "Remove unused imports",
              },
              {
                "<leader>cD",
                LazyVim.lsp.action["source.fixAll.ts"],
                desc = "Fix all diagnostics",
              },
              {
                "<leader>cV",
                function()
                  LazyVim.lsp.execute({
                    command = "typescript.selectTypeScriptVersion",
                  })
                end,
                desc = "Select TS workspace version",
              },
            },
          },
        },
        setup = {
          tsserver = function()
            -- disable tsserver
            return true
          end,
          vtsls = function(_, opts)
            LazyVim.lsp.on_attach(function(client, buffer)
              client.commands["_typescript.moveToFileRefactoring"] = function(
                command,
                ctx
              )
                ---@type string, string, lsp.Range
                local action, uri, range = unpack(command.arguments)

                local function move(newf)
                  client.request("workspace/executeCommand", {
                    command = command.command,
                    arguments = { action, uri, range, newf },
                  })
                end

                local fname = vim.uri_to_fname(uri)
                client.request("workspace/executeCommand", {
                  command = "typescript.tsserverRequest",
                  arguments = {
                    "getMoveToRefactoringFileSuggestions",
                    {
                      file = fname,
                      startLine = range.start.line + 1,
                      startOffset = range.start.character + 1,
                      endLine = range["end"].line + 1,
                      endOffset = range["end"].character + 1,
                    },
                  },
                }, function(_, result)
                  ---@type string[]
                  local files = result.body.files
                  table.insert(files, 1, "Enter new path...")
                  vim.ui.select(files, {
                    prompt = "Select move destination:",
                    format_item = function(f)
                      return vim.fn.fnamemodify(f, ":~:.")
                    end,
                  }, function(f)
                    if f and f:find("^Enter new path") then
                      vim.ui.input({
                        prompt = "Enter move destination:",
                        default = vim.fn.fnamemodify(fname, ":h") .. "/",
                        completion = "file",
                      }, function(newf)
                        return newf and move(newf)
                      end)
                    elseif f then
                      move(f)
                    end
                  end)
                end)
              end
            end, "vtsls")
            -- copy typescript settings to javascript
            -- opts.settings.javascript = vim.tbl_deep_extend(
            --   "force",
            --   {},
            --   opts.settings.typescript,
            --   opts.settings.javascript or {}
            -- )
          end,
        },
      },
    },
    --
  },
}
