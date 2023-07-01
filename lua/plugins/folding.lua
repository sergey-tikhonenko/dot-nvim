-- see https://github.com/kevinhwang91/nvim-ufo/blob/main/doc/example.lua
-- <https://github.com/folke/dot/blob/master/nvim/lua/plugins/editor.lua>
-- <https://github.com/alpha2phi/modern-neovim/blob/main/lua/plugins/extras/pde/nvim-ufo.lua>
-- <https://github.com/numamas/dotfiles/blob/master/init.lua#L501>

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 祉%d "):format(endLnum - lnum) -- 
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "Comment" }) -- "MoreMsg"
  return newVirtText
end

return {
  { -- add folding range to capabilities
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },

  { -- Configure nvim-ufo (smart folding)
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "neovim/nvim-lspconfig" },
    event = "BufReadPost",
    opts = {
      close_fold_kinds = { "imports", "comment" }, -- run `UfoInspect` for details if your provider has extended the kinds.
      fold_virt_text_handler = handler,
    },
    init = function()
      --   vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      --   vim.o.foldenable = true
    end,
    --stylua: ignore
    keys = {
      -- { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds", },
      { "zP", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds", },
      -- { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds", },
      -- { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With", }, -- closeAllFolds == closeFoldsWith(0)
      { "zp", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek Fold", },
    },
  },

  -- By default h and l keys are used. On first press of h key, when cursor is on a closed fold, the preview will be shown.
  -- On second press the preview will be closed and fold will be opened. When preview is opened, the l key will close it
  -- and open fold. In all other cases theese keys will work as usual.
  -- {
  --   "anuvyklack/fold-preview.nvim",
  --   event = "VeryLazy",
  --   -- lazy = true,
  --   dependencies = { "anuvyklack/keymap-amend.nvim" },
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "*" },
  --       callback = function()
  --         if not vim.bo.ft == "alpha" then
  --           require("lazy").load({ plugins = { "fold-preview.lua" } })
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
