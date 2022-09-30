class PaymentReceiptData {
  final bool purchaseSuccess;
  final int payablePrice;
  final String paymentStatus;


  PaymentReceiptData.fromJson(Map<String, dynamic> json)
      : payablePrice = json['payable_price'],
        purchaseSuccess = json['purchase_success'],
        paymentStatus = json['payment_status'];
}
