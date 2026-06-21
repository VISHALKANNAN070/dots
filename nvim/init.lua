vim.g.mapleader = " "

-- ── Basic Settings ─────────────────────────────────────────────

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.termguicolors = false
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.wrap = false
vim.opt.scrolloff = 4

vim.opt.laststatus = 3
vim.opt.showmode = false

-- ── Colors ────────────────────────────────────────────────────

vim.cmd([[
colorscheme default

highlight Normal       ctermbg=NONE guibg=NONE
highlight LineNr       ctermfg=8
highlight CursorLineNr ctermfg=7
highlight StatusLine   ctermfg=7 ctermbg=0
highlight VertSplit    ctermfg=8
highlight Visual       ctermbg=8
highlight Pmenu        ctermbg=0 ctermfg=7
highlight PmenuSel     ctermbg=8 ctermfg=15
highlight NormalFloat  ctermbg=0
highlight FloatBorder  ctermfg=8
]])

-- ── Lazy.nvim ─────────────────────────────────────────────────

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ── Lualine ────────────────────────────────────────────────

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  -- ── Treesitter ─────────────────────────────────────────────

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
        },

        highlight = {
          enable = true,
        },
      })
    end,
  },

  -- ── LSP ───────────────────────────────────────────────────
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })

    vim.lsp.enable("clangd")
  end,
},

  -- ── Completion ────────────────────────────────────────────

  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      window = {
        completion = { border = "single" },
        documentation = { border = "single" },
      },

      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
      },
    })
  end,
},

  -- ── Autopairs ─────────────────────────────────────────────

  {
    "windwp/nvim-autopairs",

    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- ── File Tree ─────────────────────────────────────────────

  {
    "nvim-tree/nvim-tree.lua",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              folder = false,
              file = false,
              folder_arrow = false,
            },
          },
        },

        view = {
          width = 28,
        },
      })
    end,
  },

  -- ── Formatter ─────────────────────────────────────────────

  {
    "stevearc/conform.nvim",

    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang_format" },
        },

        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      vim.keymap.set("n", "<leader>cf", function()
        require("conform").format()
      end, {
        desc = "Format file",
      })
    end,
  },

  -- ── Trouble ───────────────────────────────────────────────

  {
    "folke/trouble.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("trouble").setup({
      })
    end,
  },

  -- ── Surround ──────────────────────────────────────────────

  {
    "kylechui/nvim-surround",

    event = "VeryLazy",

    config = function()
      require("nvim-surround").setup()
    end,
  },
})

-- ── Keymaps ───────────────────────────────────────────────────

vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")

vim.keymap.set(
  "n",
  "<leader>zz",
  "<cmd>Trouble diagnostics toggle<cr>"
)
