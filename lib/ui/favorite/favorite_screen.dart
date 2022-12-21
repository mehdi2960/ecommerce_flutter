import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike_ecommerce_flutter/data/favorite_manager.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/ui/product/details.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست علاقه مندی ها'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenable,
          builder: (context, box, child) {
            final products = box.values.toList();
            return ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.only(top: 8, bottom: 100),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    onLongPress: () {
                      favoriteManager.delete(product); //Delete Product
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: ImageLoadingService(
                              imageUrl: product.imageUrl,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    product.previousPrice.withPriceLabel,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(product.price.withPriceLabel),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
