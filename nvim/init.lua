-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

local nvim_lsp = require("lspconfig")

nvim_lsp.intelephense.setup({
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end,
})
