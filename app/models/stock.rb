class Stock < ApplicationRecord
  belongs_to :item

  has_many :stock_transactions

  def withdraw(amount, withdrawer = nil)
  	create_transaction(
  		amount: -amount,
  		order_id: withdrawer.class == Order ? withdrawer.id : nil
  	)
  end

  private

  def create_transaction(args)
  	defaults = {
  		transaction_type: args[:amount].negative? ? "withdrawal" : "deposit",
  		stock_id: id
  	}

  	StockTransaction.create(defaults.merge(args))
  end
end
