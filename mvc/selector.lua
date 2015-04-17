local controller = require "controller"
local model = require "model"

local selector = {}

local paths = {}

for i,v in ipairs(controller) do
	local path,model,view = table.unpack(v)
	table.insert(paths,{path = path,model = model,view = view})
end

local function pack(a,b,...)
	return a,table.pack(...)
end

function selector.selectAndRun(path,header,body)
	if string.sub(path,-1,-1) ~= "/" then
		path = path .. "/"
	end
	for i,v in ipairs(paths) do
		local check,args = pack(string.find(path,v.path))
		if check then
			local func = model[v.model]
			if func then
				return func(header,body,table.unpack(args))
			else
				return "no function error"
			end
		end
	end
	return "no controller error"
end

return selector