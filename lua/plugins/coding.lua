return {
  -- add more treesitter parsers, see defaults here:
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua#L38>
  -- available parsers:
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/parsers.lua
  -- https://tree-sitter.github.io/tree-sitter/#parsers (a bit outdated)
  -- see ./extras/lang/rust.lua and markup-langs.lua for examples

  -- configure functions / methods jumps
  {
    "nvim-treesitter/nvim-treesitter",
    -- stylua: ignore
    keys = {
      { ";", require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_next, mode = { "n", "x", "o" }, desc = "Repeat last move next" },
      { ",", require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_previous, mode = { "n", "x", "o" }, desc = "Repeat last move previous" },
    },
    opts = {
      textobjects = { -- configuration : https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-move
        move = { -- textobjects classes : https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/scripts/minimal_init.lua#L105
          enable = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_next_end = {
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
          },
          goto_previous_end = {
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
          },
        },
      },
    },
  },

  -- configuration of language servers, see for default keymamp:
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua>
  {
    "neovim/nvim-lspconfig",
    dependencies = { "telescope.nvim" },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- listed servers will be automatically installed with mason and loaded with lspconfig
        lemminx = {}, -- xml language server
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- Tools to be installed in addition to base:
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua#L153>
  -- Implementations Language Servers: https://microsoft.github.io/language-server-protocol/implementors/servers/
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     -- add codelldb and ...
  --     vim.list_extend(opts.ensure_installed, { "codelldb" })
  --   end,
  -- },

  -- for typescript and some others languages, LazyVim also includes extra specs to properly setup
  -- lspconfig, treesitter, mason and typescript.nvim. ../config/lazy.lua
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua>
  -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/json.lua>
  -- Rust <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/rust.lua>
  -- Go <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/go.lua>

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },

  -- add cmp-emoji
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-emoji" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  --   end,
  -- }
}
