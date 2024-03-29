local M = {}

local TEMPLATE_FOLDER = "~/.config/nvim-templates/"

local function loadTemplate(templatePath)
	local expandPath = vim.fn.expand(templatePath)
	local resolvedPath

	if vim.fn.getftype(expandPath) == "link" then
		resolvedPath = vim.fn.resolve(expandPath)
	else
		resolvedPath = expandPath
	end

	local fh = io.open(resolvedPath)
	local lines = {}
	if fh == nil then
		return vim.notify("cannot open file: " .. vim.fn.getftype(expandPath) .. resolvedPath, vim.log.levels.INFO, {})
	end

	for line in fh:lines() do
		if type(line) == "table" then
			for _, l in ipairs(line) do
				lines[#lines + 1] = l
			end
		else
			lines[#lines + 1] = line
		end
	end
	fh:close()

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.runOnCurrentBuffer(ext)
	if ext == nil or ext == "" then
		vim.notify("current buffer need valid extension", vim.log.levels.INFO, {})
		return
	end

	local abspath = TEMPLATE_FOLDER .. "__" .. ext .. ".template"
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
		M.templateEdit(ext)
	end
end

function M.templateEdit(ext)
	if ext == nil or ext == "" then
		vim.notify("current buffer need valid extension", vim.log.levels.INFO, {})
		return
	end
	local abspath = TEMPLATE_FOLDER .. "__" .. ext .. ".template"
	vim.cmd(":e " .. abspath)
end

return M
