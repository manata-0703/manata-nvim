return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- LSP サーバーの設定
      lspconfig.pyright.setup({})
      lspconfig.emmet_ls.setup({})
      lspconfig.ts_ls.setup({})

      -- ESLint の設定に on_attach を追加
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          -- 自動修正のためのコマンドを設定
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      lspconfig.cssls.setup({
        capabilities = capabilities
      })
      
      lspconfig.lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
    end
  }
}

