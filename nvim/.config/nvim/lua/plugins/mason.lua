return {
  {
    "williamboman/mason.nvim",

    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        --For Typescript ..
        "typescript-language-server",
        "css-lsp",
        "js-debug-adapter",
        --For Go
        "gopls",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",
        --For Python
        "pyright",
        "ruff",
        --Rust
      })
    end,
  },
}
