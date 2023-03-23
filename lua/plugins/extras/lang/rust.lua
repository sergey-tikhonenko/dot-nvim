-- see also for example:
-- <https://github.com/alpha2phi/modern-neovim/tree/main/lua/plugins/extras/lang>
-- <https://github.com/appelgriebsch/Nv/blob/main/lua/plugins/extras/lang/rust.lua#L34>
return {
	-- add rust, toml to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"rust",
					"toml",
					-- Rust Object Notation (RON) grammar for tree-sitter https://github.com/amaanq/tree-sitter-ron
					-- , "ron"
				})
			end
		end,
	},

	-- correctly setup mason lsp / dap extensions
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"codelldb",
				"rust-analyzer",
				-- "taplo", -- TOML validation (LSP), formatting, see https://github.com/tamasfe/taplo
			})
		end,
	},
	-- { "simrat39/rust-tools.nvim" },

	-- configure lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"simrat39/rust-tools.nvim",
			-- "rust-lang/rust.vim"
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- listed servers will be automatically installed with mason and loaded with lspconfig
				rust_analyzer = { -- rust language server
					-- these override the defaults set by rust-tools.nvim
					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
					-- https://rust-analyzer.github.io/manual.html#features
					-- settings = {
					--        ["rust-analyzer"] = {
					--          cargo = {  loadOutDirsFromCheck = true, allFeatures = true, },
					--          checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } },
					--          inlayHints = { lifetimeElisionHints = { enable = true, useParameterNames = true, }, },
					--          lens = { enable = true, run = { enable = true, } },
					--          experimental = { procAttrMacros = true, },
					--        },
					--      },
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with rust-tools
				rust_analyzer = function(_, opts)
					require("lazyvim.util").on_attach(function(client, bufnr)
            -- stylua: ignore
						if client.name == "rust_analyzer" then
              -- [LSP] Accessing client.resolved_capabilities is deprecated, update your plugins or configuration to access client.server_capabilities instead.The new key/value pairs in server_capabilities directly match those defined in the language server protocol
							-- if client.resolved_capabilities["code_lens"] then
                vim.keymap.set("n", "<leader>cL", ":lua vim.lsp.codelens.refresh()<cr>", { desc = "Code lens refresh", buffer = bufnr })
                vim.keymap.set("n", "<leader>cx", ":lua vim.lsp.codelens.run()<cr>", { desc = "Code lens execute this", buffer = bufnr })
              -- end
              vim.keymap.set("n", "<leader>cR", ":lua require('rust-tools').runnables.runnables()<cr>", { desc = "List Rust Runnables", buffer = bufnr })
              vim.keymap.set("n", "<leader>cD", ":lua require('rust-tools').debuggables.debuggables()<cr>", { desc = "List Rust Debuggables", buffer = bufnr })
              vim.keymap.set("n", "<leader>cH", ":lua require('rust-tools').hover_actions.hover_actions().<cr>", { desc = "Rust Hover Actions", buffer = bufnr })
              vim.keymap.set("n", "<leader>cC", ":lua require('rust-tools').open_cargo_toml.open_cargo_toml()<cr>", { desc = "Open Cargo.toml", buffer = bufnr })
						end
					end)

					local mason_registry = require("mason-registry")
					local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
					local codelldb_path = codelldb_root .. "adapter/codelldb"
					local liblldb_path = vim.fn.has("mac") == 1 and codelldb_root .. "lldb/lib/liblldb.dylib"
						or codelldb_root .. "lldb/lib/liblldb.so"

					require("rust-tools").setup({
						tools = {
							-- executor = require("rust-tools.executors").toggleterm,
							on_initialized = function()
								vim.notify("RustTools initialized")
								vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
									group = vim.api.nvim_create_augroup("RustTootsLspRefresh", { clear = true }),
									pattern = { "*.rs" },
									callback = function()
										vim.lsp.codelens.refresh()
									end,
								})
							end,
							hover_actions = { border = "solid", auto_focus = true },
						},
						server = opts,
						dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
					})
					-- require("notify")(vim.inspect(require("dap").adapters))
					return true
				end,
			},
		},
	},

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
        -- stylua: ignore
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({ sources = { { name = "crates" } } })
          -- or
          -- opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "crates" }, }))

          -- register keymap group for debugging
          require("which-key").register({
            ["<leader>cc"] = { name = "+crates" },
          })
					-- define per buffer keymaps
					local map = vim.keymap.set
					local bufnr = vim.api.nvim_get_current_buf()
          map( "n", "<leader>ch", ":lua require('crates').show_crate_popup()<cr>", { desc = "Show crate details.", buffer = bufnr })
					map( "n", "<leader>ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information", buffer = bufnr })
					map( "n", "<leader>cu", ":lua require('crates').update_crate()<cr>", { desc = "Update a crate", buffer = bufnr })
					map( "v", "<leader>cu", ":lua require('crates').update_crates()<cr>", { desc = "Update selected crates", buffer = bufnr })
					map( "n", "<leader>cU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate", buffer = bufnr })
					map( "v", "<leader>cU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates", buffer = bufnr })
          map( "n", "<leader>ccr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io", buffer = bufnr })
					map( "n", "<leader>cca", ":lua require('crates').update_all_crates()<cr>", { desc = "Update all crates", buffer = bufnr })
					map( "n", "<leader>ccA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates", buffer = bufnr })
					map( "n", "<leader>ccf", ":lua require('crates').show_features_popup()<cr>", { desc = "Show crate features.", buffer = bufnr })
					map( "n", "<leader>ccd", ":lua require('crates').show_dependencies_popup()<cr>", { desc = "Show crate dependencies.", buffer = bufnr })
					map( "n", "<leader>ccv", ":lua require('crates').show_versions_popup()<cr>", { desc = "Show crate versions.", buffer = bufnr })
				end,
			})
		end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"simrat39/rust-tools.nvim",
		},
		opts = {
			setup = {
				codelldb = function()
					local dap = require("dap")
					dap.configurations.rust = {
						{
							name = "Rust debug",
							type = "rt_lldb",
							request = "launch",
							program = function()
	               -- stylua: ignore
	               return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
							end,
							cwd = "${workspaceFolder}",
							stopOnEntry = true,
						},
					}
				end,
			},
		},
	},
}
-- dap.adapters.codelldb = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = codelldb_path,
--     args = { "--port", "${port}" },
--
--     -- On windows you may have to uncomment this:
--     -- detached = false,
--   },
-- }
-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--   },
-- }
--
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
