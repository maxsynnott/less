class ContainerOrder < ApplicationRecord
	belongs_to :container
	belongs_to :order

	def checked_out?
		!returned_at
	end

	def returned?
		returned_at
	end
end
