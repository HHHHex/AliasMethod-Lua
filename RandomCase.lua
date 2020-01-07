
local AM = require("AliasMethod")

local test1 = {{id = 1, rate = 0.2}, {id = 2, rate = 0.3}, {id = 3, rate = 0.5}}
local test2 = {{id = 1, rate = 0.05}, {id = 2, rate = 0.3}, {id = 3, rate = 0.2}, {id = 4, rate = 0.3}, {id = 5, rate = 0.15}}
local test3 = {{id = 1, rate = 0.05}, {id = 2, rate = 0.3}, {id = 3, rate = 0.2}, {id = 4, rate = 0.3}, {id = 5, rate = 0.15}}
--print("did finish, result: ".. result.id)

local times = 9999

local results = {}
for i = 1, times do
	local x = AM.randomFromItems(test2)

	local s = tostring(x)
	if results[s] ~= nil then
		results[s] = results[s] + 1
	else
		results[s] = 0
	end
end

print(">>>   >>>>   >>>   >>>")
for k,v in pairs(results) do
	print(k, v/times)
end


