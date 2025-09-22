require("duckdb"):setup({
  mode = "standard",
  row_id = false,
  minmax_column_width = 21,
  column_fit_factor = 10.0
})
