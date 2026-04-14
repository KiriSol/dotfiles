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
        astro = { "biome" },
        css = { "biome" },
        graphql = { "biome" },
        html = { "biome" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        svelte = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        vue = { "biome" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
