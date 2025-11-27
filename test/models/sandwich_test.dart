import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich', () {
    test('Veggie Delight returns correct name', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.wheat,
      );
      expect(sandwich.name, 'Veggie Delight');
    });

    test('Chicken Teriyaki returns correct name', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.white,
      );
      expect(sandwich.name, 'Chicken Teriyaki');
    });

    test('Tuna Melt returns correct name', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      expect(sandwich.name, 'Tuna Melt');
    });

    test('Meatball Marinara returns correct name', () {
      final sandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      expect(sandwich.name, 'Meatball Marinara');
    });

    test('Image path for footlong sandwich is correct', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      expect(sandwich.image, 'assets/images/veggieDelight_footlong.png');
    });

    test('Image path for six inch sandwich is correct', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      expect(sandwich.image, 'assets/images/chickenTeriyaki_six_inch.png');
    });

    test('Sandwich stores bread type correctly', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      expect(sandwich.breadType, BreadType.wholemeal);
    });

    test('Sandwich stores footlong status correctly', () {
      final footlongSandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sixInchSandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: false,
        breadType: BreadType.white,
      );
      expect(footlongSandwich.isFootlong, true);
      expect(sixInchSandwich.isFootlong, false);
    });
  });
}
