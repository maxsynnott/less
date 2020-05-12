class Stock < ApplicationRecord
  belongs_to :product

  has_many :stock_transactions

  def withdraw(amount, withdrawer = nil)
  	create_transaction(
  		amount: -amount,
  		order_id: withdrawer.class == Order ? withdrawer.id : nil
  	)
  end

  # Currently unused
  # def deposit(amount)
  # 	create_transaction(
  # 		amount: amount
  # 	)
  # end

  # Currently unused
  # def set(amount)
  # 	create_transaction(
  # 		type: "adjustment",
  # 		amount: amount - quantity
  # 	)
  # end

  private

  def create_transaction(params)
  	defaults = {
  		type: params[:amount].negative? ? "withdrawal" : "deposit",
  		stock_id: id
  	}

  	StockTransaction.create(defaults.merge(params))
  end
end
