-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { -- Configure neo-tree for additional key mappings
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
  },
  -- { -- Comment line by Ctrl+/ TODO: used by LazyVim terminal now
  --   "echasnovski/mini.comment",
  --   keys = { { "<C-/>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" } },
  -- },

  -- Better ESC
  { "max397574/better-escape.nvim", config = true },

  { -- Configure Color Scheme
    "folke/tokyonight.nvim",
    opts = {
      transparent = true, -- Make TokyoNight Transparent
      styles = {
        sidebars = "transparent",
        -- floats = "transparent",
      }, -- see [Theme definition](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/theme.lua)
      on_highlights = function(hl, c)
        hl.Folded = { -- Change Folded Highlight Group
          -- bg = "#002B36",
          bg = c.none,
          fg = c.blue,
        }
      end,
    },
  },
  -- To prevent complaits like: Highlight group 'NotifyBackground' has no background highlight
  { "rcarriga/nvim-notify", opts = { background_colour = "#002B36" } },

  -- show colors cmd: ColorizerAttachToBuffer
  { "norcalli/nvim-colorizer.lua", event = "VeryLazy", setup = true },

  -- Отключение русской раскладки при выходе из Insert Mode
  { "ivanesmantovich/xkbswitch.nvim", config = true },

  -- переносы в длинных строках - commands: SoftWrapMode, ToggleWrapMode, keys: [ow (soft wrap mode), yow (toggle wrap mode)
  { "andrewferrier/wrapping.nvim", config = true },

  { -- Toggleterm
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },

  -- { -- telescope extension and additonal customization
  --   "telescope.nvim",
  --   dependencies = {
  --     -- { -- sets vim.ui.select to telescope, see https://github.com/simrat39/rust-tools.nvim/issues/232
  --     --   "nvim-telescope/telescope-ui-select.nvim",
  --     --   config = function()
  --     --     require("telescope").load_extension("ui-select")
  --     --   end,
  --     -- }, -- dressing.nvim is an alternavive
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --       config = function()
  --         require("telescope").load_extension("fzf")
  --       end,
  --     },
  --   },
  --   opts = {
  --     defaults = {
  --       -- initial_mode = "normal",
  --       layout_config = { width = 0.9, preview_width = 0.7, preview_cutoff = 60 },
  --       -- preview = {
  --       -- 	hide_on_startup = true, -- hide previewer when picker starts
  --       -- },
  --       mappings = {
  --         -- https://github.com/nvim-telescope/telescope.nvim#default-mappings
  --         n = {
  --           ["<a-i>"] = require("lazyvim.util").telescope("find_files", { no_ignore = true }),
  --           ["<a-h>"] = require("lazyvim.util").telescope("find_files", { hidden = true }),
  --           ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
  --         },
  --         i = {
  --           ["<C-j>"] = require("telescope.actions").move_selection_next,
  --           ["<C-k>"] = require("telescope.actions").move_selection_previous,
  --           ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
  --         },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>sX",
  --       require("lazyvim.util").telescope("lsp_dynamic_workspace_symbols", {
  --         symbols = {
  --           "Class",
  --           "Function",
  --           "Method",
  --           "Constructor",
  --           "Interface",
  --           "Module",
  --           "Struct",
  --           "Trait",
  --           "Field",
  --           "Property",
  --         },
  --       }),
  --       desc = "Goto Symbol (Workspace, dynamic)",
  --     },
  --   },
  -- },

  { -- scrollbar
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  },

  -- "ahmedkhalf/project.nvim"

  -- floating winbar { "b0o/incline.nvim", event = "BufReadPre", }

  -- auto-resize windows { "anuvyklack/windows.nvim", event = "WinNew",
  --   dependencies = { { "anuvyklack/middleclass" }, { "anuvyklack/animation.nvim", enabled = false }, },
  --   keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
  -- }
}
