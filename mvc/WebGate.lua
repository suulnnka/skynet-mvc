local skynet = require "skynet"
local socket = require "socket"

local function new_stack()
	local stack = {}
	local op = {}
	
	op.push = function(obj)
		table.insert(stack,obj)
	end
	
	op.pop = function()
		if #stack == 0 then
			return nil
		end
		return table.remove(stack)
	end
	
	return op
end

skynet.start(function()

	local stack = new_stack()

	local id = socket.listen("0.0.0.0",8080)
	skynet.error("Listen web port",8080)
	socket.start(id , function(id, addr)
		local agent = stack.pop() 
		if not agent then
			agent = skynet.newservice("Web")
		end
		skynet.send(agent, "lua", id)
		stack.push(agent)
	end)
end)
