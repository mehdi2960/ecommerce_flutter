class CreateOrderResult {
  final int orderId;
  final String bankGateWayUrl;

  CreateOrderResult(this.orderId, this.bankGateWayUrl);
  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGateWayUrl = json['bank_gateway_url'];
}

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParams(
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.postalCode,
    this.address,
    this.paymentMethod,
  );
}

enum PaymentMethod { online, cashOnDelivery }
