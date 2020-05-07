class BigDecimal
	def to_cents
		(self * 100).ceil
	end
end
