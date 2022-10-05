
class ApiSale{
  final String buyerName;
  final String buyerContact;
  final String total;
  final List<ProductItem> items;
  ApiSale(this.buyerName, this.buyerContact,this.total,
      this.items);
}

class ProductItem{
  final String name;
  final String quantity;
  final String price;

  ProductItem(
      this.name, this.quantity, this.price,);
}
