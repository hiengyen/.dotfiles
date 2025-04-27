return {
  -- devicons
  {
    "echasnovski/mini.nvim",
    version = "*",
    require("mini.icons").setup(), -- use default config
  },

  --add notify
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      --add borders for HoverDoc
      opts.presets.lsp_doc_border = true
    end,
  },
  -- modify timeout notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 7000,
    },
  },

  --statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "dracula",
      },
    },
  },
}
