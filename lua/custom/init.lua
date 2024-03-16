local opt = vim.opt

opt.smartindent = true

-- wrap = bad
opt.wrap = false

-- file undo for longer lived undos
-- opt.swapfile = false
-- opt.backup = false
-- opt.undodir = os.getenv 'HOME' .. '/.undodir'
-- opt.undofile = true

-- better "/" searching
opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

-- Keep cursor visible
opt.scrolloff = 8

opt.updatetime = 50

-- keep those lines short
opt.colorcolumn = '120'

-- tab widths
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'Option backspace while typing' })

vim.cmd 'NvimTreeToggle'
