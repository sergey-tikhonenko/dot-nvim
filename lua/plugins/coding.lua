-- Coding related plugins
return {
  -- configure functions / methods jumps
  {
    "nvim-treesitter/nvim-treesitter",
    -- stylua: ignore
    keys = {
      { ";", require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_next, mode = { "n", "x", "o", }, desc = "Repeat last move next" },
      { ",", require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_previous, mode = { "n", "x", "o", }, desc = "Repeat last move previous" },
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
    -- additional LSP keymaps
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gR",
        function()
          require("trouble").open("lsp_references")
        end,
        desc = "References (Trouble)",
      }
    end,
  },

  -- add symbols-outline - enabled by extras
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

  -- to have block comments
  { "numToStr/Comment.nvim", opts = {}, lazy = false },
  -- disable it due to the lack of support for block comments
  { "echasnovski/mini.comment", enabled = false },
  -- { -- Comment line by Ctrl+/ TODO: used by LazyVim terminal now
  --   "echasnovski/mini.comment",
  --   keys = { { "<C-/>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" } },
  -- },
}
