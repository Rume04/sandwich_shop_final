import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  group('Cart', () {
    test('adding items increases quantity and merges identical sandwiches', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wheat);

      cart.addItem(s1, quantity: 1);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 1);

      // add same sandwich again -> should merge
      cart.addItem(s1, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 3);
      expect(cart.items.first.quantity, 3);
    });

    test('removeItem removes matching sandwich', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wheat);
      final s2 = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.white);

      cart.addItem(s1, quantity: 1);
      cart.addItem(s2, quantity: 1);
      expect(cart.items.length, 2);

      cart.removeItem(s1);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich.type, SandwichType.chickenTeriyaki);
    });

    test('updateQuantity sets quantity and removes when set to zero', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: false,
          breadType: BreadType.wholemeal);

      cart.addItem(s1, quantity: 3);
      expect(cart.items.first.quantity, 3);

      cart.updateQuantity(s1, 1);
      expect(cart.items.first.quantity, 1);

      cart.updateQuantity(s1, 0);
      expect(cart.items.length, 0);
    });

    test('totalPrice uses PricingRepository.calculatePrice correctly', () {
      final cart = Cart();
      final footlong = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white);
      final sixInch = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat);

      // PricingRepository: footlong = 11.00, six inch = 7.00
      cart.addItem(footlong, quantity: 2); // 22.00
      cart.addItem(sixInch, quantity: 1); // 7.00

      expect(cart.totalPrice, 29.0);
    });

    test('clear empties the cart', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: true,
          breadType: BreadType.wheat);

      cart.addItem(s1, quantity: 2);
      expect(cart.items.isNotEmpty, true);

      cart.clear();
      expect(cart.items.isEmpty, true);
    });

    test('toJson contains items with expected keys', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wheat);
      cart.addItem(s1, quantity: 2, notes: 'No mayo');

      final json = cart.toJson();
      expect(json.containsKey('items'), true);
      final items = json['items'] as List<dynamic>;
      expect(items.length, 1);
      final first = items.first as Map<String, dynamic>;
      expect(first['type'], 'veggieDelight');
      expect(first['isFootlong'], true);
      expect(first['breadType'], 'wheat');
      expect(first['quantity'], 2);
      expect(first['notes'], 'No mayo');
    });
  });
}
