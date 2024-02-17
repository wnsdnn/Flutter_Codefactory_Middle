class ShppingItemModel {
  // 이름
  final String name;

  // 갯수
  final int quantity;

  // 구매했는지
  final bool hasBought;

  // 매운지
  final bool isSpicy;

  ShppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });
}
