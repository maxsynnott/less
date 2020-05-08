class Stock < ApplicationRecord
  belongs_to :product

  has_many :stock_transactions

  def create_transaction(params)
  	defaults = {
  		type: params[:amount].negative? ? "withdrawal" : "deposit",
  		stock_id: id
  	}

  	StockTransaction.create(defaults.merge(params))
  end

  def withdraw(amount, withdrawer = nil)
  	create_transaction(
  		amount: -amount,
  		order_id: withdrawer.class == Order ? withdrawer.id : nil
  	)
  end

  def deposit(amount)
  	create_transaction(
  		amount: amount
  	)
  end

  def set(amount)
  	create_transaction(
  		type: "adjustment",
  		amount: amount - quantity
  	)
  end
end
