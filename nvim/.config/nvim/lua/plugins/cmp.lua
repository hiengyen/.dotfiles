return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local _, luasnip = pcall(require, "luasnip")
    local lspkind = require("lspkind")
    local colorizer = require("tailwindcss-colorizer-cmp").formatter

    local lsp_kinds = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    }

    local select_next_item = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    local select_prev_item = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- config nvim cmp to work with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        completion = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
      },

      -- autocompletion sources
      sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        { name = "nvim_lsp" },
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "tailwindcss-colorizer-cmp" },
      }),

      mapping = cmp.mapping.preset.insert({
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),

        ["<C-p>"] = cmp.mapping(select_prev_item),
        ["<C-n>"] = cmp.mapping(select_next_item),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),

        -- Trigger completion menu
        ["<C-CR>"] = cmp.mapping.complete(),
      }),

      -- setup lspkind for vscode pictograms in autocompletion dropdown menu
      formatting = {
        format = function(entry, vim_item)
          -- Add custom lsp_kinds icons
          vim_item.kind = string.format(
            "%s %s",
            lsp_kinds[vim_item.kind] or "",
            vim_item.kind
          )

          -- add menu tags (e.g., [Buffer], [LSP])
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          -- use lspkind and tailwindcss-colorizer-cmp for additional formatting
          vim_item = lspkind.cmp_format({
            maxwidth = 25,
            ellipsis_char = "...",
          })(entry, vim_item)

          if entry.source.name == "nvim_lsp" then
            vim_item = colorizer(entry, vim_item)
          end

          return vim_item
        end,
      },
    })
  end,
}
