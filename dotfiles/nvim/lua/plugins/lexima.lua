return {
    "cohama/lexima.vim",
    config = function()
        -- デフォルトルールを有効化
        vim.g.lexima_enable_basic_rules = 1

        -- インデントするルールのやつ
        vim.g.lexima_enable_newline_rules = 1

        -- tagのインデント
        vim.cmd(
            [[call lexima#add_rule({'char': '<CR>', 'at': '>\%#</', 'input_after': '<CR>'})]]
        )

        -- C-jで囲みから抜けるやつ
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#)', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#]', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#}', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#>', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#''', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#"', 'input': '<Right>'})]]
        )
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#`', 'input': '<Right>'})]]
        )

        -- C-jでセミコロンを飛ばすやつ
        vim.cmd(
            [[call lexima#add_rule({'char': '<C-j>', 'at': '\%#;', 'input': '<Right>'})]]
        )
    end,
}
