class ShoppingItemModel {
  // 이름
  final String name;
  // 개수
  final int quantity;
  // 구매했는지
  final bool hasBouht;
  // 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBouht,
    required this.isSpicy,
  });
}
