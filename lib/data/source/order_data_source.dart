import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/payment_receipt.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> create(CreateOrderParams params);
  Future<PaymentReceiptData> getPaymentReceipt(int orderId);
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    final response = await httpClient.post('order/submit', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
      'mobile': params.phoneNumber,
      'postal_code': params.postalCode,
      'address': params.address,
      'payment_method': params.paymentMethod == PaymentMethod.online
          ? 'online'
          : 'cash_on_delivery',
    });

    return CreateOrderResult.fromJson(response.data);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) async {
    final response = await httpClient.get('order/checkout?order_id=$orderId');
    return PaymentReceiptData.fromJson(response.data);
  }
}
