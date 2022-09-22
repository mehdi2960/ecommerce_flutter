class CartResponce {
  final int productId;
  final int cartItemId;
  final int count;

  CartResponce(this.productId, this.cartItemId, this.count);

  CartResponce.froJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'],
        count = json['count'];
}
