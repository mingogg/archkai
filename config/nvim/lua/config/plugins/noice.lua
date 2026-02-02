return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				signature = { enabled = false },
				progress = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = { event = "msg_show" },
					view = "notify",
					opts = { timeout = 1300 },
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
		keys = {
			{ "<leader>nl", function() require("noice").cmd("last") end, desc = "Último mensaje de Noice" },
			{ "<leader>nh", function() require("noice").cmd("history") end, desc = "Historial de Noice" },
			{ "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Cerrar notificaciones" },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					timeout = 1300,
					stages = "static",
				},
			},
		},
	},
}
