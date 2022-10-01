import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/repo/order_repository.dart';
import 'package:nike_ecommerce_flutter/ui/cart/price_info.dart';
import 'package:nike_ecommerce_flutter/ui/payment_webview.dart';
import 'package:nike_ecommerce_flutter/ui/receipt/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final int totalPrice;
  final int shippingCost;
  final int payablePrice;

  ShippingScreen(
      {Key? key,
      required this.totalPrice,
      required this.shippingCost,
      required this.payablePrice})
      : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'مهدی');

  final TextEditingController lastNameController =
      TextEditingController(text: 'موسوی');

  final TextEditingController phoneNumberController =
      TextEditingController(text: '09371282960');

  final TextEditingController postalCodeController =
      TextEditingController(text: '6881865696');

  final TextEditingController addressController = TextEditingController(
      text: 'خیابان شهبد بهشتی تقاطع اسدی رازی خیابان جوهری');

  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

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
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen(
            (event) {
              if (event is ShippingSuccess) {
                if (event.result.bankGateWayUrl.isNotEmpty) {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PaymentGatewayScreen(
                  //       bankGatewayUrl: event.result.bankGateWayUrl,
                  //     ),
                  //   ),
                  // );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentReceiptScreen(
                        orderId: event.result.orderId,
                      ),
                    ),
                  );
                }
              } else if (event is ShippingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(event.exception.message),
                  ),
                );
              }
            },
          );
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  label: Text('نام'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  label: Text('نام خانوادگی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('شماره تماس'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                  label: Text('کد پستی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  label: Text('آدرس'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PriceInfo(
                payablePrice: widget.payablePrice,
                totalPrice: widget.totalPrice,
                shippingCost: widget.shippingCost,
              ),
              BlocBuilder<ShippingBloc, ShippingState>(
                  builder: (context, state) {
                return state is ShippingLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<ShippingBloc>(context).add(
                                ShippingCreateOrder(
                                  CreateOrderParams(
                                    firstNameController.text,
                                    lastNameController.text,
                                    phoneNumberController.text,
                                    postalCodeController.text,
                                    addressController.text,
                                    PaymentMethod.cashOnDelivery,
                                  ),
                                ),
                              );
                            },
                            child: const Text('پرداخت در محل'),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ShippingBloc>(context).add(
                                ShippingCreateOrder(
                                  CreateOrderParams(
                                    firstNameController.text,
                                    lastNameController.text,
                                    phoneNumberController.text,
                                    postalCodeController.text,
                                    addressController.text,
                                    PaymentMethod.online,
                                  ),
                                ),
                              );
                            },
                            child: const Text('پرداخت اینترنتی'),
                          ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
