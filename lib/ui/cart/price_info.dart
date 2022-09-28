import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  const PriceInfo(
      {Key? key,
      required this.payablePrice,
      required this.totalPrice,
      required this.shippingCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child:
              Text('جزییات خرید', style: Theme.of(context).textTheme.bodySmall),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("مبلغ کل خرید"),
                    RichText(
                      text: TextSpan(
                        text: totalPrice.separateByComma,
                        style: const TextStyle(color: Colors.grey),
                        children: const [
                          TextSpan(
                            text: ' تومان',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("هزینه ارسال"),
                    Text(shippingCost.withPriceLabel)
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("مبلغ قابل پرداخت"),
                    RichText(
                      text: TextSpan(
                        text: payablePrice.withPriceLabel,
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                        children: const [
                          TextSpan(
                            text: ' تومان',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
