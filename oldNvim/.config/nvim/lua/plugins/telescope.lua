return {

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  --telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local transform_mod = require("telescope.actions.mt").transform_mod

      local trouble = require("trouble")
      local trouble_telescope = require("trouble.sources.telescope")

      -- or create your custom action
      local custom_actions = transform_mod({
        open_trouble_qflist = function(prompt_bufnr)
          trouble.toggle("quickfix")
        end,
      })

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist
                + custom_actions.open_trouble_qflist,
              ["<C-t>"] = trouble_telescope.open,
            },
            n = {
              ["qq"] = actions.close,
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
            },
          },
        },
      })

      telescope.load_extension("fzf")

      -- set keymaps
      local keymap = vim.keymap

      keymap.set(
        "n",
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        { desc = "Fuzzy find files in cwd" }
      )
      keymap.set(
        "n",
        "<leader>fr",
        "<cmd>Telescope oldfiles<cr>",
        { desc = "Fuzzy find recent files" }
      )
      keymap.set(
        "n",
        "<leader>fs",
        "<cmd>Telescope live_grep<cr>",
        { desc = "Find string in cwd" }
      )
      keymap.set(
        "n",
        "<leader>fc",
        "<cmd>Telescope grep_string<cr>",
        { desc = "Find string under cursor in cwd" }
      )
    end,
  },
}
