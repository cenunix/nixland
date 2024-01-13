local wk = require('which-key')
wk.register({
    ['<leader>'] = {
    w = { '<cmd>w<cr>', 'Save Buffer' },
    q = { '<cmd>q<cr>', 'Quit' },
    e = { ':Neotree action=focus reveal toggle<cr>', 'Toggle Neotree' },
    f = {
        name = 'File',
        f = { '<cmd>Telescope find_files<cr>', 'Find File' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
        n = { '<cmd>enew<cr>', 'New File' },
        w = { '<cmd>Telescope live_grep<cr>', 'Grep Files' },
        b = { '<cmd>Telescope buffers<cr>', 'Grep Buffers' },
        h = { '<cmd>Telescope help_tags<cr>', 'Grep Help Tags' },
        d = { '<cmd>Telescope diagnostics<cr>', 'Grep Diagnostics' },
        g = { '<cmd>Telescope git_files<cr>', 'Grep Git Files' },
    },
    g = {
        name = 'Git',
        l = { '<cmd>Gitsigns blame_line<cr>', 'View Git Blame' },
        L = { '<cmd>Gitsigns blame_line {full = true}<cr>', 'View full Git Blame' },
        p = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview Git Hunk' },
        h = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset Git Hunk' },
        r = { '<cmd>Gitsigns reset_buffer<cr>', 'Reset Git Buffer' },
        s = { '<cmd>Gitsigns stage_hunk<cr>', 'Stage Git Hunk' },
        S = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage Git Buffer' },
        u = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Unstage Git Hunk' },
        d = { '<cmd>Gitsigns diffthis<cr>', 'View Git Diff' },
    },
    l = {
        name = 'Lsp',
        i = { '<cmd>LspInfo<cr>', 'LSP Information' },
        I = { '<cmd>NullLsInfo<cr>', 'Null-ls Information' },
    },
    },
})