import 'dart:html';

import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/ui/receipt/payment_receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final String bankGatewayUrl;
  const PaymentGatewayScreen({Key? key, required this.bankGatewayUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: bankGatewayUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        debugPrint('url:$url');
        final uri = Uri.parse(url);
        if (uri.pathSegments.contains('checkout') &&
            uri.host == 'expertdevelopers.ir') {
          final orderId = int.parse(uri.queryParameters['order_id']!);
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentReceiptScreen(orderId: orderId),
            ),
          );
        }
      },
    );
  }
}
