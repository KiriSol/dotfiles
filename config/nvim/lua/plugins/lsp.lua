return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "editorconfig",
        "just",
        "kdl",
        "typst",
        "fish",
        "nu",
        "go",
        "rust",
        "zig",
        "cpp",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        just = { "just" },
        kdl = { "kdlfmt" },
        toml = { "taplo" },
        nu = { "nufmt" },
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
        typos_lsp = {},
        just = {},
        tinymist = {
          single_file_support = true,
          settings = {
            formatterMode = "typstyle",
          },
        },
        nushell = {},
        rust_analyzer = {},
        zls = {},
        clangd = {},
        gopls = {},
        biome = {},
        ruff = {},
        ty = {},
      },
    },
  },
}
