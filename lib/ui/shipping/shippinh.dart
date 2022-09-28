import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/ui/cart/price_info.dart';
import 'package:nike_ecommerce_flutter/ui/receipt/payment_receipt.dart';

class ShippingScreen extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;

  const ShippingScreen(
      {Key? key,
      required this.totalPrice,
      required this.shippingCost,
      required this.payablePrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحویل گیرنده',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                label: Text('نام'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('نام خانوادگی'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('شماره تماس'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('کد پستی'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('آدرس'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            PriceInfo(
              payablePrice: payablePrice,
              totalPrice: totalPrice,
              shippingCost: shippingCost,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PaymentReceiptScreen()));
                  },
                  child: const Text('پرداخت در محل'),
                ),
                const SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('پرداخت اینترنتی'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
