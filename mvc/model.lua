local model = {}

function model.change_sign_bonus()
	return "succ"
end

function model.default_function()
	return "404"
end

function model.fuck(body,who)
	-- body 需要json解析
	return who
end

return model