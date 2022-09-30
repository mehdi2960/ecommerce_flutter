import 'package:nike_ecommerce_flutter/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository(this.dataSource);
  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>  dataSource.create(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) {
   return dataSource.getPaymentReceipt(orderId);
  }
}
