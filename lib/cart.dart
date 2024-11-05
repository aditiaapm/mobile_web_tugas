class Cart {
  final List<ShoeItem> _items = [];

  void addItem(ShoeItem item) {
    for (var existingItem in _items) {
      if (existingItem.name == item.name && existingItem.size == item.size) {
        return;
      }
    }
    _items.add(item);
  }

  List<ShoeItem> get items => _items;

  int get itemCount => _items.length;

  void clear() {
    _items.clear();
  }

  void removeItem(ShoeItem item) {
    _items.remove(item);
  }
}
class ShoeItem {
  final String name;
  final int price;
  final String image;
  final String size;

  ShoeItem({
    required this.name,
    required this.price,
    required this.image,
    required this.size,
  });
}
