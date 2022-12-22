import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/repo/order_repository.dart';
import 'package:nike_ecommerce_flutter/ui/order/bloc/order_history_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderHistoryBloc>(
      create: (context) {
        final block = OrderHistoryBloc(orderRepository);
        block.add(OrderHistoryStarted());
        return block;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لیست سفارشات'),
          centerTitle: true,
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistorySuccess) {
              final orders = state.orders;
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('شناسه سفارش',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(order.id.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مبلغ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(order.payablePrice.withPriceLabel,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          SizedBox(
                            height: 132,
                            child: ListView.builder(
                              scrollDirection:Axis.horizontal,
                                itemCount: order.items.length,
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 4,right: 4),
                                    child: ImageLoadingService(
                                      imageUrl: order.items[index].imageUrl,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    );
                  });
            } else if (state is OrderHistoryError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
