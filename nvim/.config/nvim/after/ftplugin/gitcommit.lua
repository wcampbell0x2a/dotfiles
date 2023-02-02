local colors = require("onenord.colors").load()
-- disable special coloring of git commit msg header after 50 length, since I use 70
require("onenord").setup({
  custom_highlights = {
    ["@text"] = { fg = colors.blue },
  },
})
