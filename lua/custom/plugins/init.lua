-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local clients_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()

        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        if next(clients) == nil then
          return ''
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return '\u{f085} ' .. table.concat(c, '|')
      end
      require('lualine').setup {
        options = {
          theme = 'horizon',
        },
        sections = {
          lualine_x = { clients_lsp, 'filetype' },
        },
      }
    end,
  },

  -- Smart commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      vim.keymap.set('n', '<C-c>', function()
        require('Comment.api').toggle.linewise.current()
      end, { desc = 'comment current line', noremap = true })
      vim.keymap.set(
        'v',
        '<C-c>',
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = 'comment visual block', noremap = true }
      )
    end,
  },

  -- File Tree
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      git = {
        enable = true,
        timeout = 2000,
      },
      view = {
        width = 40,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = {
          '^.git$',
        },
      },
    },
    lazy = false,
  },

  -- Copilot
  {
    'github/copilot.vim',
    ft = { 'go', 'typescript', 'typescriptreact', 'javascript' },
  },

  -- LazyGit, tui for git
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit TUI' })
    end,
  },

  -- Smoother scrolling w/ <C-d> and <C-u>
  {
    'karb94/neoscroll.nvim',
    lazy = false,
    config = function()
      require('neoscroll').setup {
        pre_hook = function()
          vim.opt.scrolloff = 999
        end,
        post_hook = function()
          vim.opt.scrolloff = 0
        end,
      }
      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' } }
      t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' } }
      t['zt'] = { 'zt', { '250' } }
      t['zz'] = { 'zz', { '250' } }
      t['zb'] = { 'zb', { '250' } }

      require('neoscroll.config').set_mappings(t)
    end,
  },

  -- cmdline in popup window
  {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    config = function()
      require('fine-cmdline').setup {
        cmdline = {
          enable_keymaps = true,
          smart_history = true,
          prompt = ': ',
        },
        popup = {
          position = {
            row = '25%',
            col = '50%',
          },
          size = {
            width = '60%',
          },
          border = {
            style = 'rounded',
          },
          win_options = {
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          },
        },
        -- hooks = {
        --   before_mount = function(input)
        --     -- code
        --   end,
        --   after_mount = function(input)
        --     -- code
        --   end,
        --   set_keymaps = function(imap, feedkeys)
        --     -- code
        --   end
        -- }
      }
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
    end,
  },

  -- Markdown Previewer
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
