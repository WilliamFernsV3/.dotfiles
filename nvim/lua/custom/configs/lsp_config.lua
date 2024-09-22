local config = require("plugins.configs.lspconfig")
local get_ruff_config_path = require("custom.custom_functions").get_ruff_config_path

local on_attach = config.on_attach
local capabilities = config.capabilities
local lspconfig = require("lspconfig")

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- local function filter_tsserver_diagnostics(_, result, ctx, conf)
--   if result.diagnostics == nil then
--     return
--   end
--
--   -- Array of codes to ignore
--   local ignore_codes = { 80001, 7016 } -- Add more codes as needed
--
--   local idx = 1
--   while idx <= #result.diagnostics do
--     local entry = result.diagnostics[idx]
--     -- Check if the entry code is in the ignore_codes array
--     if vim.tbl_contains(ignore_codes, entry.code) then
--       table.remove(result.diagnostics, idx)
--     else
--       idx = idx + 1
--     end
--   end
--
--   vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, conf)
-- end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.defer_fn(function()
          vim.cmd("EslintFixAll")
        end, 200)
      end,
    })
  end,
  capabilities = capabilities,
  on_new_config = function(c, new_root_dir)
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(new_root_dir),
      name = vim.fn.fnamemodify(new_root_dir, ':t')
    }
  end,
})

------------------------------

lspconfig.lua_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    }
  }
}

lspconfig.prismals.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.tailwindcss.setup({
  filetypes = { "html", "javascriptreact", "typescriptreact" },
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.jedi_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.pylsp.setup {
  cmd = { "pylsp", "-v", "--log-file", "/tmp/nvim-pylsp.log" },
  settings = {
    pylsp = {
      plugins = {
        -- Disable all linting
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = { enabled = false },

        jedi_completion = { fuzzy = true },
        rope_autoimport = { enabled = true },
        jedi_rename = { enabled = false },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
--
-- Flag to avoid re-triggering BufWritePre
local should_format = true

lspconfig.ruff.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local config_path = get_ruff_config_path()
    if config_path then
      vim.notify("Successfully selected ruff config from: " .. config_path, vim.log.levels.INFO)
    end

    -- Setup BufWritePre autocmd
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        if should_format then
          should_format = false -- Set flag to false to prevent re-triggering

          -- Execute Neovim commands
          vim.cmd("RuffAutofix")

          -- Wait for a short while before executing the next command
          vim.defer_fn(function()
            vim.cmd("RuffOrganizeImports")

            -- Wait for the format command to be done
            vim.defer_fn(function()
              local filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
              local command = "ruff format '" .. filename .. "'"

              -- Run the system command asynchronously
              vim.fn.jobstart(command, {
                on_exit = function()
                  -- Save the buffer after ruff formatting completes
                  vim.cmd('silent write!')

                  -- Restore the flag to allow further format operations
                  should_format = true

                  -- Notify the user or take other actions
                  print("Ruff formatting completed and file saved.")
                end
              })
            end, 400) -- Adjust delay if necessary
          end, 100)   -- Adjust delay if necessary
        end
      end
    })

    -- Optionally, set up a BufWritePost autocmd for post-format actions
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = function()
        -- This autocmd can be used for further processing after saving
        -- For example: Run additional commands or checks
      end
    })
  end,
  capabilities = capabilities,
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
    }
  },
  commands = {
    RuffAutofix = {
      function()
        local ruff_client = vim.lsp.get_active_clients({ name = "ruff" })[1]
        if ruff_client then
          ruff_client.request('workspace/executeCommand', {
            command = 'ruff.applyAutofix',
            arguments = {
              {
                uri = vim.uri_from_bufnr(0),
                version = vim.lsp.util.buf_versions[vim.api.nvim_get_current_buf()],
              },
            },
          }, function(err, _, _)
            if err then
              vim.notify("Error executing Ruff autofix: " .. err.message, vim.log.levels.ERROR)
            end
          end)
        else
          vim.notify("Ruff LSP not available", vim.log.levels.ERROR)
        end
      end,
      description = 'Ruff: Fix all auto-fixable problems',
    },
    RuffOrganizeImports = {
      function()
        local ruff_client = vim.lsp.get_active_clients({ name = "ruff" })[1]
        if ruff_client then
          ruff_client.request('workspace/executeCommand', {
            command = 'ruff.applyOrganizeImports',
            arguments = {
              {
                uri = vim.uri_from_bufnr(0),
                version = vim.lsp.util.buf_versions[vim.api.nvim_get_current_buf()],
              },
            },
          }, function(err, _, _)
            if err then
              vim.notify("Error executing Ruff organize imports: " .. err.message, vim.log.levels.ERROR)
            end
          end)
        else
          vim.notify("Ruff LSP not available", vim.log.levels.ERROR)
        end
      end,
      description = 'Ruff: Format imports',
    }
  }
})

------------------------------

lspconfig.html.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  capabilities = capabilities,
})

lspconfig.cssls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  capabilities = capabilities,
})

lspconfig.css_variables.setup({})

lspconfig.emmet_language_server.setup({
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  }
})
