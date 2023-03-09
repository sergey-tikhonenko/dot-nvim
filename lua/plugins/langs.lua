return {
	-- Rust support
	{ "simrat39/rust-tools.nvim" },

	{
		"Saecki/crates.nvim",
		-- event = { "BufRead Cargo.toml" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("crates").setup()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({ sources = { { name = "crates" } } })
					-- define per buffer keymaps
					local map = vim.keymap.set
					local bufnr = vim.api.nvim_get_current_buf()
          -- stylua: ignore
					map( "n", "<leader>ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cu", ":lua require('crates').update_crate()<cr>", { desc = "Update a crate", buffer = bufnr })
          -- stylua: ignore
					map( "v", "<leader>cu", ":lua require('crates').update_crates()<cr>", { desc = "Update selected crates", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate", buffer = bufnr })
          -- stylua: ignore
					map( "v", "<leader>cU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>ca", ":lua require('crates').update_all_crates()<cr>", { desc = "Update all crates", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates", buffer = bufnr })
          -- stylua: ignore
					map( "n", "K", ":lua require('crates').show_crate_popup()<cr>", { desc = "Show crate details.", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cf", ":lua require('crates').show_features_popup()<cr>", { desc = "Show crate features.", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cd", ":lua require('crates').show_dependencies_popup()<cr>", { desc = "Show crate dependencies.", buffer = bufnr })
          -- stylua: ignore
					map( "n", "<leader>cv", ":lua require('crates').show_versions_popup()<cr>", { desc = "Show crate versions.", buffer = bufnr })
				end,
			})
		end,
	},

	-- add rust-analyzer to lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- listed servers will be automatically installed with mason and loaded with lspconfig
				rust_analyzer = {}, -- rust language server
				marksman = {}, -- makrdown language server
				lemminx = {}, -- xml language server
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with rust-tools
				rust_analyzer = function(_, opts)
					-- these override the defaults set by rust-tools.nvim
					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
					-- https://rust-analyzer.github.io/manual.html#features
					-- opts = {
					--   cargo = { -- loadOutDirsFromCheck = true, allFeatures = true, },
					--   checkOnSave = { command = "clippy", },
					--   inlayHints = { lifetimeElisionHints = { enable = true, useParameterNames = true, }, },
					--   lens = { enable = true, run = { enable = true, } },
					--   experimental = { procAttrMacros = true, }, },
					require("lazyvim.util").on_attach(function(client, bufnr)
						if client.name == "rust_analyzer" then
              -- [LSP] Accessing client.resolved_capabilities is deprecated, update your plugins or configuration to access client.server_capabilities instead.The new key/value pairs in server_capabilities directly match those defined in the language server protocol
							-- if client.resolved_capabilities["code_lens"] then
                -- stylua: ignore
                vim.keymap.set("n", "<leader>cL", ":lua vim.lsp.codelens.refresh()<cr>", { desc = "Code lens refresh", buffer = bufnr })
                -- stylua: ignore
                vim.keymap.set("n", "<leader>cA", ":lua vim.lsp.codelens.run()<cr>", { desc = "Code lens run", buffer = bufnr })
              -- end
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cR", ":lua require('rust-tools.runnables').runnables()<cr>", { desc = "List Rust runnables", buffer = bufnr })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cH", ":lua require('rust-tools.hover_actions').hover_actions()<cr>", { desc = "Rust Hover Actions", buffer = bufnr })
							-- stylua: ignore
							vim.keymap.set("n", "<leader>cC", ":lua require('rust-tools.open_cargo_toml').open_cargo_toml()<cr>", { desc = "Open Cargo.toml", buffer = bufnr })
						end
					end)

					local mason_registry = require("mason-registry")
					local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
					local codelldb_path = codelldb_root .. "adapter/codelldb"
					local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

					require("rust-tools").setup({
						tools = { hover_actions = { auto_focus = true } },
						server = opts,
						dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
					})
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},

	-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
	-- treesitter, mason and typescript.nvim.
	{ import = "lazyvim.plugins.extras.lang.typescript" },

	-- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
	{ import = "lazyvim.plugins.extras.lang.json" },

	-- add any tools you want to have installed below
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- add codelldb and ...
			vim.list_extend(opts.ensure_installed, { "codelldb" })
		end,
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

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "rust", "toml" })
			end
			-- map the html parser to be used when using xml files
			local parser_mapping = require("nvim-treesitter.parsers").filetype_to_parsername
			parser_mapping.xml = "html"
		end,
	},
}
