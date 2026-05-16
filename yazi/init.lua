require("duckdb"):setup({
  mode = "standard",
  row_id = false,
  minmax_column_width = 21,
  column_fit_factor = 10.0
})

require("bunny"):setup({
  hops = {
    { key = "/",          path = "/",              desc = "Root"         },
    { key = "~",          path = "~",              desc = "Home"         },
    { key = "d",          path = "~/Downloads",    desc = "Downloads"    },
    { key = "k",          path = "~/kDrive",       desc = "kDrive"       },
    { key = "s",          path = "~/Desktop",      desc = "Desktop"      },
    { key = "D",          path = "~/Documents",    desc = "Documents"    },
    { key = "p",          path = "~/Pictures",     desc = "Pictures"     },
    { key = "S",          path = "~/Sites",        desc = "Sites"        },
    { key = "c",          path = "~/.config",      desc = "Config files" },
    -- key and path attributes are required, desc is optional
  },
  desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
  ephemeral = true, -- Enable ephemeral hops, default is true
  tabs = true, -- Enable tab hops, default is true
  notify = true, -- Notify after hopping, default is false
  fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})