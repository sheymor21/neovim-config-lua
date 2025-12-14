local ts_utils = require("nvim-treesitter.ts_utils")
local match_ids = {}

-- Limpiar highlights previos
local function clear_matches()
	for _, id in ipairs(match_ids) do
		pcall(vim.fn.matchdelete, id)
	end
	match_ids = {}
end

local function find_keyword(line, kw)
	local start_col, end_col = line:find("%f[%w]" .. kw .. "%f[%W]")
	if start_col then
		return start_col, end_col
	end
end

local block_keywords = {
	if_statement = { start = { "if", "elseif", "else" }, ["end"] = { "end" } },
	function_definition = { start = { "function" }, ["end"] = { "end" } },
}

local function highlight_blocks_under_cursor()
	clear_matches()

	local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
	cursor_row = cursor_row - 1
	local bufnr = vim.api.nvim_get_current_buf()

	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end

	while node do
		local type = node:type()
		local keywords = block_keywords[type]
		if keywords then
			local s_row, _, e_row, _ = node:range()
			local lines = vim.api.nvim_buf_get_lines(bufnr, s_row, e_row + 1, false)
			local positions = {}

			-- Inicio del bloque: primera línea
			for _, kw in ipairs(keywords.start) do
				local start_col, end_col = find_keyword(lines[1], kw)
				if start_col then
					table.insert(positions, { row = s_row, start_col = start_col, length = end_col - start_col + 1 })
				end
			end

			-- Fin del bloque: última línea
			local last_line = lines[#lines]
			for _, kw in ipairs(keywords["end"]) do
				local start_col, end_col = find_keyword(last_line, kw)
				if start_col then
					table.insert(
						positions,
						{ row = s_row + #lines - 1, start_col = start_col, length = end_col - start_col + 1 }
					)
				end
			end

			-- Resaltar solo si el cursor está sobre alguna palabra clave
			for _, pos in ipairs(positions) do
				if
					cursor_row == pos.row
					and cursor_col >= pos.start_col - 1
					and cursor_col < pos.start_col - 1 + pos.length
				then
					for _, p in ipairs(positions) do
						table.insert(
							match_ids,
							vim.fn.matchaddpos("MatchParen", { { p.row + 1, p.start_col, p.length } }, 10)
						)
					end
					return
				end
			end

			return
		end
		node = node:parent()
	end
end

-- Autocmd para actualizar highlight al mover el cursor
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	pattern = "*",
	callback = highlight_blocks_under_cursor,
})
