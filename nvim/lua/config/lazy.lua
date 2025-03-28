local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
	{
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        -- Snacks configuration options
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        notifier = {
          enabled = true,
          timeout = 3000,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            wo = { wrap = true } -- Wrap notifications
          }
        }
      },
      keys = {
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
        { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        {
          "<leader>N",
          desc = "Neovim News",
          function()
            Snacks.win({
              file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
              width = 0.6,
              height = 0.6,
              wo = {
                spell = false,
                wrap = false,
                signcolumn = "yes",
                statuscolumn = " ",
                conceallevel = 3,
              },
            })
          end,
        }
      },
      init = function()
        -- Set up debugging functions
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            _G.dd = function(...)
              Snacks.debug.inspect(...)
            end
            _G.bt = function()
              Snacks.debug.backtrace()
            end
            vim.print = _G.dd -- Override print to use snacks for `:=` command

            -- Create toggle mappings
            Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
            Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
            Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
            Snacks.toggle.diagnostics():map("<leader>ud")
            Snacks.toggle.line_number():map("<leader>ul")
            Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
            Snacks.toggle.treesitter():map("<leader>uT")
            Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
            Snacks.toggle.inlay_hints():map("<leader>uh")
          end,
        })
      end,
    },

    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "everforest",
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },

    -- Import any extras modules here
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lsp.neoconf" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.kotlin" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,  -- Load your custom plugins on startup
    version = false,  -- Use the latest git commit
  },
  dev = {
    path = "~/.ghq/github.com",
  },
  checker = { enabled = true },  -- Automatically check for plugin updates
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip", "netrwPlugin", "rplugin", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
  ui = {
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        dd(plugin)
      end,
    },
  },
  debug = false,
})
