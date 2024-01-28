local M = {}

local TEMPLATE_FOLDER = "~/.config/nvim-templates/"

local function loadTemplate(templatePath)
	vim.notify(templatePath, vim.log.levels.INFO, {})
	local fh = io.open(templatePath)
	local lines = {}
	if fh == nil then
		return vim.notify("cannot open file" .. templatePath, vim.log.levels.INFO, {})
	end

	for line in fh:lines() do
		vim.notify(type(line), vim.log.levels.INFO, {})
		if type(line) == "table" then
			for _, l in ipairs(line) do
				lines[#lines + 1] = l
			end
		else
			lines[#lines + 1] = line
		end
	end
	fh:close()
	vim.notify(lines[0], vim.log.levels.INFO, {})

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.runOnCurrentBuffer(filetype)
	if filetype == nil or filetype == "" then
		vim.notify("current buffer need valid filetype", vim.log.levels.INFO, {})
		return
	end

	local abspath = TEMPLATE_FOLDER .. filetype .. ".template"
	local num_lines = vim.api.nvim_buf_line_count(0)
	if num_lines ~= 1 then
		vim.notify("not empty file", vim.log.levels.INFO, {})
		return
	end
	local line_data = vim.api.nvim_buf_get_lines(0, 0, 1, false)
	if string.len(line_data[1]) ~= 0 then
		vim.notify("not empty file", vim.log.levels.INFO, {})
		return
	end

	if vim.fn.filereadable(abspath) then
		loadTemplate(abspath)
	else
		M.templateEdit(filetype)
	end
end

function M.templateEdit(filetype)
	if filetype == nil or filetype == "" then
		vim.notify("current buffer need valid filetype", vim.log.levels.INFO, {})
		return
	end
	local abspath = TEMPLATE_FOLDER .. filetype .. ".template"
	vim.cmd(":e " .. abspath)
end

return M
