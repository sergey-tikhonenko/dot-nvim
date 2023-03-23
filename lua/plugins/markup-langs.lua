-- see for example:
-- <https://github.com/alpha2phi/modern-neovim/blob/main/lua/plugins/extras/pde/notes/markdown.lua>
return {

  -- configure lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- listed servers will be automatically installed with mason and loaded with lspconfig
        -- https://github.com/artempyanykh/marksman/blob/main/docs/configuration.md
        marksman = {}, -- makrdown language server
      },
    },
  },

  -- Make Markdown support better: highlight codeblocks, headlines, decorate quotes
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
    ft = "markdown",
  },

  -- add commands (:GenTocGFM, ...) to generate ToC
  { "mzlogin/vim-markdown-toc", ft = { "markdown" } },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    -- dir = "/home/tserge/backup/configs/nvim/markdown-preview.nvim",
    -- dev = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {
          -- openMarker = "@startuml",
          -- closeMarker = "@enduml",
          -- diagramName = "planuml",
          imageFormat = "svg",
        },
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
    ft = "markdown",
  },
  -- markdown preview
  -- {
  -- 	"toppair/peek.nvim",
  -- 	build = "deno task --quiet build:fast",
  -- 	keys = {
  -- 		{
  -- 			"<leader>op",
  -- 			function()
  -- 				local peek = require("peek")
  -- 				if peek.is_open() then
  -- 					peek.close()
  -- 				else
  -- 					peek.open()
  -- 				end
  -- 			end,
  -- 			desc = "Peek (Markdown Preview)",
  -- 		},
  -- 	},
  -- 	opts = { theme = "light", app = "firefox" },
  -- },

  -- Еще один вариант Markdown preview
  -- {"ellisonleao/glow.nvim", branch = 'main'}

  -- YAML
  -- * Builtin Kubernetes manifest autodetection
  -- * Get/Set specific JSON schema per buffer
  -- * Extensible autodetection + Schema Store support
  -- {
  --   "someone-stole-my-name/yaml-companion.nvim",
  --   lazy = true,
  --   dependencies = {
  --     { "neovim/nvim-lspconfig" },
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim" },
  --   },
  --   config = function()
  --     require("telescope").load_extension("yaml_schema")
  --   end,
  -- },
}
