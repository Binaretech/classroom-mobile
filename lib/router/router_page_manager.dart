import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterPageManager extends ChangeNotifier {
  final List<Page> _pages;

  RouterPageManager(bool isLogged)
      : _pages = [
          isLogged
              ? const MaterialPage(
                  child: Login(),
                  key: ValueKey('/login'),
                )
              : const MaterialPage(
                  child: Login(),
                  key: ValueKey('/'),
                ),
        ];

  static RouterPageManager of(BuildContext context) {
    return Provider.of<RouterPageManager>(context);
  }

  List<Page> get pages => List.unmodifiable(_pages);

  void pop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }
}
