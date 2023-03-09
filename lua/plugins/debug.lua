-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			-- Add your own debuggers here
			"leoluz/nvim-dap-go",
			-- "mfussenegger/nvim-dap-python",
			-- "jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with reasonable debug configurations
				automatic_setup = true,
				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = { -- Update this to ensure that you have the debuggers for the langs you want
					"delve", -- golang debugger
					"codelldb", -- codelldb for rust, ...
					-- "python",
				},
			})

			local sign = vim.fn.sign_define
			-- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

			local mason_registry = require("mason-registry")
			local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
			local codelldb_path = codelldb_root .. "adapter/codelldb"
			local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

			dap.adapters.rust = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

			-- You can provide additional configuration to the handlers, see mason-nvim-dap README for more information
			require("mason-nvim-dap").setup_handlers()

			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				show_stop_reason = true,
				commented = true,
				only_first_definition = true,
				all_references = true,
				display_callback = function(variable, _buf, _stackframe, _node)
					return " " .. variable.name .. " = " .. variable.value .. " "
				end,
				-- experimental features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			})

			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug continue" })
			vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug step into" })
			vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug step over" })
			vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug step out" })
			vim.keymap.set("n", "<leader>cb", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
			vim.keymap.set("n", "<leader>cB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug breakpoint condition" })

			-- Dap UI setup
			-- For more information, see |:help nvim-dap-ui|
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "□",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			-- Install golang specific config
			require("dap-go").setup()
		end,
	},
}
