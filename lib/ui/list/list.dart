import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/product/product.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;
  final String searchTerm;

  const ProductListScreen({Key? key, required this.sort})
      : searchTerm = "",
        super(key: key);

  const ProductListScreen.search({Key? key, required this.searchTerm})
      : sort = ProductSort.popular,
        super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType { grid, list }

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // elevation: 0,
          title: Text(widget.searchTerm.isEmpty
              ? 'کفش های ورزشی'
              : 'نتایج جستجو: ${widget.searchTerm}'),
          centerTitle: true,
        ),
        body: BlocProvider<ProductListBloc>(
          create: (context) {
            bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(widget.sort, widget.searchTerm));
            return bloc!;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListSuccess) {
                final products = state.products;
                return Column(
                  children: [
                    if (widget.searchTerm.isEmpty)
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1,
                            ),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                            )
                          ],
                        ),
                        height: 56,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(32),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      bottom: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'انتخاب مرتب سازی',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: state.sortNames.length,
                                            itemBuilder: (context, index) {
                                              final selectedSortIndex =
                                                  state.sort;
                                              return InkWell(
                                                onTap: () {
                                                  bloc!.add(
                                                    ProductListStarted(
                                                      index,
                                                      widget.searchTerm,
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    16,
                                                    8,
                                                    16,
                                                    8,
                                                  ),
                                                  child: SizedBox(
                                                    height: 32,
                                                    child: Row(
                                                      children: [
                                                        Text(state.sortNames[index]),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        if (index ==selectedSortIndex)
                                                          Icon(CupertinoIcons.check_mark_circled_solid,
                                                            color: Theme.of(context).colorScheme.primary
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:const EdgeInsets.only(right: 8, left: 8),
                                  child: Row(
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          CupertinoIcons.sort_down,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          const Text('مرتب سازی'),
                                          Text(
                                            ProductSort.names[state.sort],
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8, left: 8),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      viewType == ViewType.grid
                                          ? ViewType.list
                                          : ViewType.grid;
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.square_grid_2x2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65, //width / hight
                          crossAxisCount: viewType == ViewType.grid ? 2 : 1,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final product = products[index];
                          return ProductItem(
                            product: product,
                            borderRadius: BorderRadius.zero,
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ProductListEmpty) {
                return Center(
                  child: Text(state.message,
                      style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 17)),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ));
  }
}
