return {
  {
    "williamboman/mason.nvim",

    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- For Lua
        "stylua",
        "selene",
        -- "luacheck",
        -- For any Shell
        "shellcheck",
        "shfmt",
        --For Bash
        "bash-language-server",
        -- For C/C++
        "clangd",
        "clang-format",
        --For Python
        -- "python-lsp-server ",
        "pyright",
        "ruff",
        --For Typescript ..
        "typescript-language-server",
        "css-lsp",
        "js-debug-adapter",
        --For Go
        "gopls",
        "goimports",
        "gofumpt",
      })
    end,
  },
}
