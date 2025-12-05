import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CheckoutScreen', () {
    testWidgets('displays order summary with single item',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('2x Veggie Delight'), findsOneWidget);
      expect(find.text('£22.00'), findsWidgets);
      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('displays order summary with multiple items',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final Sandwich sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich1, quantity: 1);
      cart.add(sandwich2, quantity: 3);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('1x Veggie Delight'), findsOneWidget);
      expect(find.text('3x Chicken Teriyaki'), findsOneWidget);
      expect(find.text('£11.00'), findsOneWidget);
      expect(find.text('£21.00'), findsOneWidget);
      expect(find.text('Total:'), findsOneWidget);
      expect(find.text('£32.00'), findsOneWidget);
    });

    testWidgets('displays correct total price', (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 3);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('Total:'), findsOneWidget);
      expect(find.text('£33.00'), findsWidgets);
    });

    testWidgets('displays payment method information',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('Payment Method: Card ending in 1234'), findsOneWidget);
    });

    testWidgets('displays confirm payment button initially',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      final Finder confirmButtonFinder =
          find.widgetWithText(ElevatedButton, 'Confirm Payment');
      expect(confirmButtonFinder, findsOneWidget);

      final ElevatedButton button =
          tester.widget<ElevatedButton>(confirmButtonFinder);
      expect(button.onPressed, isNotNull);
    });

    // testWidgets('shows processing indicator when payment is being processed',
    //     (WidgetTester tester) async {
    //   final Cart cart = Cart();
    //   final Sandwich sandwich = Sandwich(
    //     type: SandwichType.veggieDelight,
    //     isFootlong: true,
    //     breadType: BreadType.white,
    //   );
    //   cart.add(sandwich, quantity: 1);

    //   final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
    //   final MaterialApp app = MaterialApp(
    //     home: checkoutScreen,
    //   );

    //   await tester.pumpWidget(app);

    //   final Finder confirmButtonFinder =
    //       find.widgetWithText(ElevatedButton, 'Confirm Payment');
    //   await tester.tap(confirmButtonFinder);
    //   await tester.pump();

    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
    //   expect(find.text('Processing payment...'), findsOneWidget);
    //   expect(
    //       find.widgetWithText(ElevatedButton, 'Confirm Payment'), findsNothing);
    // });

    // testWidgets('navigates back with order confirmation after payment',
    //     (WidgetTester tester) async {
    //   final Cart cart = Cart();
    //   final Sandwich sandwich = Sandwich(
    //     type: SandwichType.veggieDelight,
    //     isFootlong: true,
    //     breadType: BreadType.white,
    //   );
    //   cart.add(sandwich, quantity: 2);

    //   final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
    //   final MaterialApp app = MaterialApp(
    //     home: Scaffold(
    //       body: Builder(
    //         builder: (BuildContext context) {
    //           return ElevatedButton(
    //             onPressed: () async {
    //               final result = await Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => checkoutScreen,
    //                 ),
    //               );

    //               if (result != null && result is Map) {
    //                 ScaffoldMessenger.of(context).showSnackBar(
    //                   SnackBar(
    //                     content: Text('Order ID: ${result['orderId']}'),
    //                   ),
    //                 );
    //               }
    //             },
    //             child: const Text('Go to Checkout'),
    //           );
    //         },
    //       ),
    //     ),
    //   );

    //   await tester.pumpWidget(app);

    //   await tester.tap(find.text('Go to Checkout'));
    //   await tester.pumpAndSettle();

    //   expect(find.text('Checkout'), findsOneWidget);

    //   final Finder confirmButtonFinder =
    //       find.widgetWithText(ElevatedButton, 'Confirm Payment');
    //   await tester.tap(confirmButtonFinder);
    //   await tester.pump();

    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //   // await tester.pump(const Duration(seconds: 2));
    //   // await tester.pumpAndSettle();

    //   // expect(find.text('Go to Checkout'), findsOneWidget);
    // });

    testWidgets('order confirmation contains correct data',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich, quantity: 5);

      Map? orderConfirmation;

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => checkoutScreen,
                    ),
                  );

                  if (result != null && result is Map) {
                    orderConfirmation = result;
                  }
                },
                child: const Text('Go to Checkout'),
              );
            },
          ),
        ),
      );

      await tester.pumpWidget(app);

      await tester.tap(find.text('Go to Checkout'));
      await tester.pumpAndSettle();

      final Finder confirmButtonFinder =
          find.widgetWithText(ElevatedButton, 'Confirm Payment');
      await tester.tap(confirmButtonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(orderConfirmation, isNotNull);
      expect(orderConfirmation!['orderId'], startsWith('ORD'));
      expect(orderConfirmation!['totalAmount'], equals(35.00));
      expect(orderConfirmation!['itemCount'], equals(5));
      expect(orderConfirmation!['estimatedTime'], equals('15-20 minutes'));
    });

    testWidgets('displays divider between items and total',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('displays app bar with correct title',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      final Finder appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);
      expect(find.text('Checkout'), findsOneWidget);
    });

    testWidgets('calculates price correctly for footlong sandwiches',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 4);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('4x Veggie Delight'), findsOneWidget);
      expect(find.text('£44.00'), findsWidgets);
    });

    testWidgets('calculates price correctly for six-inch sandwiches',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich, quantity: 2);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('2x Chicken Teriyaki'), findsOneWidget);
      expect(find.text('£14.00'), findsWidgets);
    });

    testWidgets('handles mixed sandwich types correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final Sandwich sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      final Sandwich sandwich3 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich1, quantity: 2);
      cart.add(sandwich2, quantity: 1);
      cart.add(sandwich3, quantity: 1);

      final CheckoutScreen checkoutScreen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(
        home: checkoutScreen,
      );

      await tester.pumpWidget(app);

      expect(find.text('2x Veggie Delight'), findsOneWidget);
      expect(find.text('1x Chicken Teriyaki'), findsOneWidget);
      expect(find.text('1x Tuna Melt'), findsOneWidget);
      expect(find.text('£22.00'), findsOneWidget);
      expect(find.text('£7.00'), findsOneWidget);
      expect(find.text('£11.00'), findsOneWidget);
    });
  });
}
