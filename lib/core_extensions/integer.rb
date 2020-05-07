class Integer
	def to_money
		BigDecimal(self) / 100
	end
end