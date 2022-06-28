local NumberUtil = {}

function NumberUtil.IsEven(n: number): boolean
	return n % 2 == 0
end

function NumberUtil.IsOdd(n: number): boolean
	return n % 2 == 1
end

return NumberUtil
