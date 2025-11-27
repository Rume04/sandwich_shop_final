import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;
  final String? notes;

  CartItem({required this.sandwich, this.quantity = 1, this.notes});

  double price(PricingRepository pricingRepository) {
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  bool isSameSandwich(CartItem other) {
    return sandwich.type == other.sandwich.type &&
        sandwich.isFootlong == other.sandwich.isFootlong &&
        sandwich.breadType == other.sandwich.breadType;
  }
}

class Cart {
  final List<CartItem> _items = [];
  final PricingRepository _pricingRepository;

  Cart({PricingRepository? pricingRepository})
      : _pricingRepository = pricingRepository ?? PricingRepository();

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalQuantity => _items.fold(0, (p, e) => p + e.quantity);

  void addItem(Sandwich sandwich, {int quantity = 1, String? notes}) {
    if (quantity <= 0) return;
    final incoming =
        CartItem(sandwich: sandwich, quantity: quantity, notes: notes);
    for (final item in _items) {
      if (item.isSameSandwich(incoming)) {
        item.quantity += quantity;
        return;
      }
    }
    _items.add(incoming);
  }

  void removeItem(Sandwich sandwich) {
    _items.removeWhere((item) =>
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);
  }

  void updateQuantity(Sandwich sandwich, int quantity) {
    if (quantity < 0) return;
    for (final item in _items) {
      if (item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType) {
        if (quantity == 0) {
          _items.remove(item);
        } else {
          item.quantity = quantity;
        }
        return;
      }
    }
  }

  double get totalPrice {
    return _items.fold(
        0.0, (sum, item) => sum + item.price(_pricingRepository));
  }

  void clear() => _items.clear();

  Map<String, dynamic> toJson() {
    return {
      'items': _items
          .map((i) => {
                'type': i.sandwich.type.name,
                'isFootlong': i.sandwich.isFootlong,
                'breadType': i.sandwich.breadType.name,
                'quantity': i.quantity,
                'notes': i.notes,
              })
          .toList(),
    };
  }
}
