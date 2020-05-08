class BigDecimal
	def to_cents
		if self.zero?
			0
		else
			# All non-zero big_decimal values will return non-zero integers
			# This is to prevent potential exploits (extremely small values will round up to 1 cent instead of down to zero) 
			self.positive? ? [1, (self * 100).round].max : [-1, (self * 100).round].min
		end
	end
end
