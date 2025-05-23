return {
  {
    --syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cmake",
        "gitignore",
        "rust",
        --For Go
        "go",
        "gomod",
        "gowork",
        "gosum",
        --For Python
        "ninja",
        "python",
        "toml",
        --For Typescript
        "typescript",
        "tsx",
        -- Nix language
      })
    end,
  },
}
