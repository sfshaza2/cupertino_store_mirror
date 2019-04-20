import 'package:flutter/cupertino.dart';
import 'styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({this.controller, this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: <Widget>[
              const Icon(
                CupertinoIcons.search,
                color: Styles.searchIconColor,
              ),
              Expanded(
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: Styles.searchText,
                  cursorColor: Styles.searchCursorColor,
                  placeholder: 'Search',
                ),
              ),
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Styles.searchIconColor,
                ),
                onTap: controller.clear,
              ),
            ],
          )),
    );
  }
}
