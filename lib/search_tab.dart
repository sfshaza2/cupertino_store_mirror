import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'product_row_item.dart';
import 'search_bar.dart';
import 'styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _createSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  List<Widget> _generateProductRows(List<Product> products) {
    final productListing = <Widget>[];

    for (var i = 0; i < products.length; i++) {
      productListing.add(ProductRowItem(
        index: i,
        product: products[i],
        lastItem: i == products.length - 1,
      ));
    }

    return productListing;
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppStateModel>(context, rebuildOnChange: true);

    return CupertinoTabView(
      builder: (context) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Styles.scaffoldBackground,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _createSearchBox(),
                Expanded(
                  child: ListView(
                    children: _generateProductRows(model.search(_terms)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
