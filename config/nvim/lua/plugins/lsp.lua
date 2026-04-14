return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "kdl",
        "fish",
        "nu",
        "rust",
        "zig",
        "go",
        "cpp",
        "typst",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kdl = { "kdlfmt" },
        toml = { "taplo" },
        css = { "biome" },
        html = { "biome" },
        javascript = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        typescript = { "biome" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
        clangd = {},
        zls = {},
        gopls = {},
        ruff = {},
        ty = {},
        biome = {},
        nushell = {},
        tinymist = {
          single_file_support = true,
          settings = {
            formatterMode = "typstyle",
          },
        },
        typos_lsp = {},
      },
    },
  },
}
