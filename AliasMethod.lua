local AliasMethod = {}

function AliasMethod.randomFromItems(items)
	local largers = {}
	local smallers = {}
	local alias = {}

	print(#items)
	local total = 0
	-- check toall Rate
	for index, item in ipairs(items) do
		total = total + item.rate
	end
	if (total > 1) then
		print("waring: total value is more than 1")
		return
	end
	-- items rate to 1 & devide items to large and small
	local count = #items
	for index, item in ipairs(items) do
		local alias_item = {id = item.id, rate = item.rate * count}
		if alias_item.rate < 1.0 then
			table.insert(smallers, alias_item)
		else
			table.insert(largers, alias_item)
		end
	end
	
	print("large: "..#largers.."  small: "..#smallers)
	-- makeup alias
	while #smallers ~= 0 and #largers ~= 0 do
		local small = smallers[1]
		local large = largers[1]
		table.remove(smallers, 1)
		table.remove(largers, 1)

		local expend_rate = 1.0 - small.rate;
		local rest_rate = large.rate - expend_rate

		if rest_rate < 0 then
			print("waring: expend rate is less than 0")
			break
		end

		local expend = {id = large.id, rate = expend_rate}
		local alias_pair = {small, expend}
		table.insert(alias, alias_pair)

		local rest = {id = large.id, rate = rest_rate}
		if rest_rate >= 1.0 then 
			table.insert(largers, rest)
		else
			table.insert(smallers, rest)
		end
	end
	-- handle rest items
	while #smallers ~= 0 do
		local small = smallers[1]
		table.remove(smallers, 1)
		local alias_pair = {{id = small.id, rate = 1.}}
		table.insert(alias, alias_pair)
	end
	while #largers ~= 0 do
		local large = largers[1]
		table.remove(largers, 1)
		local alias_pair = {{id = large.id, rate = 1.}}
		table.insert(alias, alias_pair)
	end

	print("large: "..#largers.."  small: "..#smallers)
	print("-  ----      ----------")
	for i, alias_pair in ipairs(alias) do
		for i, item in ipairs(alias_pair) do
			print(item.id, item.rate)
		end
		print("-  ----      ----------")
	end

	local index = math.random(1, #alias)
	local rate = math.random(1000) * 0.001
	print("alias count: " ..count .. " random index: " ..index .." rate: " ..rate)
	local alias_pair = alias[index]
	local rate_range = 0
	local result = nil
	for i, item in ipairs(alias_pair) do
		rate_range = rate_range + item.rate
		if rate_range >= rate then 
			print("rate_range: " ..rate_range .." rate: " ..rate)
			result = item
			break
		end
	end

	return result.id
end

return AliasMethod
