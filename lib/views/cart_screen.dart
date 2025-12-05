import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  void _incrementQuantity(Sandwich sandwich) {
    setState(() {
      widget.cart.add(sandwich, quantity: 1);
    });
  }

  void _decrementQuantity(Sandwich sandwich) {
    setState(() {
      final currentQuantity = widget.cart.items[sandwich] ?? 0;
      if (currentQuantity > 1) {
        widget.cart.remove(sandwich, quantity: 1);
      }
    });
  }

  void _remove(Sandwich sandwich) {
    setState(() {
      widget.cart.remove(sandwich);
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to clear your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cart.clear();
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  double _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text(
          'Cart View',
          style: heading1,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              for (MapEntry<Sandwich, int> entry in widget.cart.items.entries)
                Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Text(entry.key.name, style: heading2),
                            Text(
                              '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                              style: normalText,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: entry.value > 1
                                      ? () => _decrementQuantity(entry.key)
                                      : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: entry.value > 1
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                Text(
                                  'Qty: ${entry.value} - £${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                                  style: normalText,
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _incrementQuantity(entry.key),
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () => _remove(entry.key),
                            icon: const Icon(Icons.close),
                            color: Colors.red,
                            tooltip: 'Remove item',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Text(
                'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                style: heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              StyledButton(
                onPressed: _clearCart,
                icon: Icons.delete_forever,
                label: 'Clear Cart',
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 10),
              StyledButton(
                onPressed: _goBack,
                icon: Icons.arrow_back,
                label: 'Back to Order',
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
