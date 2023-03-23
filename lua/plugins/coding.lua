return {
  -- add more treesitter parsers, see defaults here:
  -- <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua#L38>
  -- available parsers:
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/parsers.lua
  -- https://tree-sitter.github.io/tree-sitter/#parsers (a bit outdated)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- map the html parser to be used when using xml files
      local parser_mapping = require("nvim-treesitter.parsers").filetype_to_parsername
      parser_mapping.xml = "html"
    end,
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

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim.
  -- see <https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua>
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- Rust support
  { import = "plugins.extras.lang.rust" },

  -- Go support
  { import = "plugins.extras.lang.golang" },

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
