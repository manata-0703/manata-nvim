return {
  -- その他のプラグインの設定
  {
    "github/copilot.vim",
    config = function()
    vim.g.copilot_no_tab_map = true -- <Tab> のデフォルトマッピングを無効化

    -- マッピング設定
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { silent = true, expr = true })
    end
  }
}

