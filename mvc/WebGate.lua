local skynet = require "skynet"
local socket = require "socket"

local MAX_AGENT = tonumber(skynet.getenv("thread"))

-- TODO 生产者消费者模型

skynet.start(function()

	local agent = {}
	local start = 1
	for i = 1,MAX_AGENT do
		agent[i] = skynet.newservice("Web")
	end
	local id = socket.listen("0.0.0.0",8080)
	skynet.error("Listen web port",8080)
	socket.start(id , function(id, addr)
		skynet.send(agent[start], "lua", id)
		if start == MAX_AGENT then
			start = 1
		else
			start = start + 1
		end
	end)
	
end)
