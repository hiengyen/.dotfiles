return {
	{
		"Mofiqul/dracula.nvim",

		lazy = false,
		priority = 1000,
		name = "dracula",
		opts = {
			transparent = true,
			background = "light",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = {
					enabled = true,
					custom_bg = "lualine",
				},
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				snacks = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
		config = function(_, opts)
			vim.cmd("colorscheme dracula")
		end,
	},
}
