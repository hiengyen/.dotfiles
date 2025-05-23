return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			vim.cmd("colorscheme tokyonight-moon")
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lualine/lualine.nvim", lazy = true },
	{ "akinsho/bufferline.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
