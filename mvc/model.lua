local staticfile = require "staticfile"
local view = require "view"

local func = {}

function func.change_sign_bonus()
	return "succ"
end

function func.login(_,__,name)
	
	return name
	
end

function func.static(header,body,file_name)
	local file = staticfile[file_name]
	if file then
		return file
	end
	return func.default_function()
end

function func.default_function()
	return "404"
end

function func.fuck(header,body,who)
	-- body 需要json解析
	return who
end

function func.test(header,body)
	local env = {foo = "you",header = header,body = body}
	return view.render("test.lp",env)
end

local model = setmetatable({},{__index = func})

return model
