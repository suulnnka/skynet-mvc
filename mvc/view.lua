local skynet = require "skynet"
local lp = require "lp"

local root = skynet.getenv "view_path"

local view = {}

local function new_writer()
	local s = ""
	local op = {}
	op.write = function(str)
		s = s .. str
	end
	op.put = function()
		return s 
	end
	return op
end

local function include(env)
	return function(view_name)
		lp.include(root..view_name,env)
	end
end

function view.render(view_name,tbl)
	tbl = tbl or {}
	local path = root .. view_name
	
	local writer = new_writer()
	local env = {__index = {write = writer.write,include = include(tbl)}}
	setmetatable(tbl,env)
	lp.include(path,tbl)
	
	return writer.put()
end



return view