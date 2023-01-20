local log = require("plenary.log").new {
  plugin = "notify",
  level = "debug",
  use_console = false,
}

vim.notify = function(msg, level, opts)
  log.info(msg, level, opts)
  mynotify = require("notify")
  mynotify.setup({
    stages = "fade",
    timeout = 3000,
    background_colour = "Visual",
  })

  mynotify(msg, level, opts)
end

--vim.notify = require("notify")
--vim.notify.setup({
--  stages = "fade",
--  timeout = 2000,
--  background_colour = "Visual",
--})
