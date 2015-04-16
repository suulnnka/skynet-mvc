local skynet = require "skynet"
local sprotoloader = require "sprotoloader"

skynet.start(function()
	print("Server start")

	skynet.newservice("WebGate")

	skynet.exit()
end)
