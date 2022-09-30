import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/repo/order_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';
import 'package:nike_ecommerce_flutter/ui/receipt/bloc/payment_receipt_bloc.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;
  const PaymentReceiptScreen({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: BlocProvider<PaymentReceiptBloc>(
        create: (context) => PaymentReceiptBloc(orderRepository)
          ..add(PaymentReceiptStarted(orderId)),
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
          builder: (context, state) {
            if (state is PaymentReceiptSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeData.dividerColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.paymentReceiptData.purchaseSuccess?'پرداخت با موفقیت انجام شد':'پرداخت ناموفق',
                          style: themeData.textTheme.headline6!.apply(
                            color: themeData.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('وضیعت سفارش',
                                style: TextStyle(
                                  color: LightThemeColors.secondaryTextColor,
                                )),
                            Text(state.paymentReceiptData.paymentStatus,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('مبلغ'),
                            Text(
                              state.paymentReceiptData.payablePrice.withPriceLabel,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //Barghasht be Rishe in Page
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('بازگشت به صفحه اصلی'),
                  ),
                ],
              );
            } else if (state is PaymentReceiptError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is PaymentReceiptLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              throw Exception('state is not Supported!');
            }
          },
        ),
      ),
    );
  }
}
