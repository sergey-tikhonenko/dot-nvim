-- debug.lua
-- Examples:
-- <https://github.com/appelgriebsch/Nv/blob/main/lua/plugins/dap.lua>
-- <https://github.com/alpha2phi/modern-neovim/blob/main/lua/plugins/dap/init.lua>
-- <https://gitlab.com/david_wright/nvim/-/blob/main/lua/plugins/debugging.lua>
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",
			"nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			-- Add your own debuggers here
			-- "mfussenegger/nvim-dap-python",
			-- "jbyuki/one-small-step-for-vimkind", -- debug any lua code running in a Neovim instance.
		},
		config = function(plugin, opts)
			-- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

			local dap, dapui = require("dap"), require("dapui")

			-- Dap UI setup. For more information, see |:help nvim-dap-ui|
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

			-- set up manual debugger configuration
			for k, _ in pairs(opts.setup) do
				opts.setup[k](plugin, opts)
			end

			-- require("dap").defaults.fallback.terminal_win_cmd = "enew | set filetype=dap-terminal"
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = "dap-repl",
			-- 	callback = function()
			-- 		require("dap.ext.autocompl").attach()
			-- 	end,
			-- })

			-- register keymap group for debugging
			require("which-key").register({
				["<leader>d"] = { name = "+debug" },
				["<leader>db"] = { name = "+breakpoints" },
				["<leader>ds"] = { name = "+steps" },
				["<leader>dv"] = { name = "+views" },
			})
		end,
    -- stylua: ignore
    keys = {
      { "<leader>dbc", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dbl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message")) end, desc = "Logpoint" },
      { "<leader>dbr", function() require("dap.breakpoints").clear() end, desc = "Remove All" },
      { "<leader>dbs", "<CMD>Telescope dap list_breakpoints<CR>", desc = "Show All" },
      { "<leader>dbt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<C-F8>",      function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },

      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<F9>",       function() require("dap").continue() end, desc = "Continue" },
      { "<leader>de", function() require("dap.ui.widgets").hover(nil, { border = "none" }) end, desc = "Evalutate Expression", mode = { "n", "v" } },
      { "<M-F8>",     function() require("dap.ui.widgets").hover(nil, { border = "none" }) end, desc = "Evalutate Expression", mode = { "n", "v" } },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover" },
      { "<C-F9>",     function() require("dap.ui.widgets").hover() end, desc = "Hover" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", "<CMD>Telescope dap configurations<CR>", desc = "Run" },

      { "<leader>dsb", function() require("dap").step_back() end, desc = "Step Back" },
      { "<leader>dsc", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<M-F9>",      function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dsi", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F7>",        function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dso", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F8>",        function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dsx", function() require("dap").step_out() end, desc = "Step Out" },
      { "<S-F8>",      function() require("dap").step_out() end, desc = "Step out" },

      { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate" },

      { "<leader>dvf", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames, { border = "none" }) end, desc = "Show Frames" },
      { "<leader>dvr", function() require("dap").repl.open(nil, "20split") end, desc = "Show Repl" },
      { "<leader>dvs", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, { border = "none" }) end, desc = "Show Scopes" },
      { "<leader>dvt", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads, { border = "none" }) end, desc = "Show Threads" },
    },
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {
			-- https://github.com/theHamsta/nvim-dap-virtual-text#readme
			highlight_changed_variables = true,
			-- highlight_new_as_changed = true,
			commented = true,
			all_references = true,
		},
	},
}
-- require("mason-nvim-dap").setup({
-- 	-- Makes a best effort to setup the various debuggers with reasonable debug configurations
-- 	automatic_setup = true,
-- 	-- You'll need to check that you have the required things installed
-- 	-- online, please don't ask me how to install them :)
-- 	ensure_installed = { -- Update this to ensure that you have the debuggers for the langs you want
-- 		"delve", -- golang debugger
-- 		"codelldb", -- codelldb for rust, ...
-- 		-- "python",
-- 	},
-- })
-- -- You can provide additional configuration to the handlers, see mason-nvim-dap README for more information
-- -- <https://github.com/jay-babu/mason-nvim-dap.nvim#setup-handlers-usage>
-- require("mason-nvim-dap").setup_handlers()
