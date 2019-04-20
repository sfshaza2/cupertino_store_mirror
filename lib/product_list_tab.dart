import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/app_state_model.dart';
import 'product_row_item.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          final products = model.getProducts();
          return CustomScrollView(
            semanticChildCount: products.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Cupertino Store'),
              ),
              SliverSafeArea(
                top: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < products.length) {
                        return ProductRowItem(
                          index: index,
                          product: products[index],
                          lastItem: index == products.length - 1,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
