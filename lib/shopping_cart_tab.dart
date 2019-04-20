import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/app_state_model.dart';
import 'shopping_cart_item.dart';
import 'styles.dart';

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$'); // NEW

  Widget _buildNameField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CupertinoTextField(
          placeholder: 'Name',
          prefix: const Icon(
            CupertinoIcons.person_solid,
            color: CupertinoColors.lightBackgroundGray,
            size: 28,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0,
                color: CupertinoColors.inactiveGray,
              ),
            ),
          ),
          clearButtonMode: OverlayVisibilityMode.editing,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          onChanged: (newName) {
            setState(() {
              name = newName;
            });
          },
        ),
      );

  Widget _buildEmailField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CupertinoTextField(
          placeholder: 'Email',
          prefix: const Icon(
            CupertinoIcons.mail_solid,
            color: CupertinoColors.lightBackgroundGray,
            size: 28,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0,
                color: CupertinoColors.inactiveGray,
              ),
            ),
          ),
          clearButtonMode: OverlayVisibilityMode.editing,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          onChanged: (newName) {
            setState(() {
              name = newName;
            });
          },
        ),
      );

  Widget _buildLocationField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CupertinoTextField(
          placeholder: 'Location',
          prefix: const Icon(
            CupertinoIcons.location_solid,
            color: CupertinoColors.lightBackgroundGray,
            size: 28,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0,
                color: CupertinoColors.inactiveGray,
              ),
            ),
          ),
          clearButtonMode: OverlayVisibilityMode.editing,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
        ),
      );

  Widget _buildDateAndTimePicker() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(
                      CupertinoIcons.clock,
                      color: CupertinoColors.lightBackgroundGray,
                      size: 28,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Delivery time',
                      style: Styles.deliveryTimeLabel,
                    ),
                  ],
                ),
                Text(
                  DateFormat.yMMMd().add_jm().format(dateTime),
                  style: Styles.deliveryTime,
                ),
              ],
            ),
            Container(
              height: _kDateTimePickerHeight,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: dateTime,
                onDateTimeChanged: (newDateTime) {
                  setState(() {
                    dateTime = newDateTime;
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildShoppingCart(AppStateModel model) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (model.productsInCart.length > index) {
              return ShoppingCartItem(
                index: index,
                product: model
                    .getProductById(model.productsInCart.keys.toList()[index]),
                quantity: model.productsInCart.values.toList()[index],
                lastItem: index == model.productsInCart.length - 1,
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == index &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Shipping '
                          '${_currencyFormat.format(model.shippingCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tax ${_currencyFormat.format(model.tax)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total  ${_currencyFormat.format(model.totalCost)}',
                          style: Styles.productRowTotal,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          return CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Shopping Cart'),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildNameField(),
                    _buildEmailField(),
                    _buildLocationField(),
                    _buildDateAndTimePicker(),
                  ],
                ),
              ),
              _buildShoppingCart(model),
            ],
          );
        },
      ),
    );
  }
}
