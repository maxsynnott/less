json.extract! @cart_item, :quantity
json.item @cart_item.item, :price

json.cart @cart_item.cart, :total
