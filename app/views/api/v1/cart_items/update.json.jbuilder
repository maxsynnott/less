json.extract! @cart_item, :quantity
json.unit @cart_item.unit, :price

json.cart @cart_item.cart, :total
