import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/modules/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Map<String, Page> routes = {
  '/': const MaterialPage(
    child: Login(),
    key: ValueKey('/'),
  ),
  '/login': const MaterialPage(
    child: Login(),
    key: ValueKey('/login'),
  ),
  '/register': const MaterialPage(
    child: Register(),
    key: ValueKey('/register'),
  ),
};

class RouterPageManager extends ChangeNotifier {
  List<Page> _pages;

  RouterPageManager(bool isLogged)
      : _pages = [
          isLogged ? routes['/']! : routes['/login']!,
        ];

  static RouterPageManager of(BuildContext context) {
    return Provider.of<RouterPageManager>(context, listen: false);
  }

  void push(String path) {
    if (_pages.length > 1 &&
        _pages[_pages.length - 2].key.toString() == ValueKey(path).toString()) {
      return pop();
    }

    _pages.add(routes[path]!);
    notifyListeners();
  }

  void onLogin() {
    _pages = [routes['/']!];
    notifyListeners();
  }

  void pop() {
    _pages.removeLast();
    notifyListeners();
  }

  List<Page> get pages => List.unmodifiable(_pages);

  void popPage(Page page) {
    _pages.remove(page);
    notifyListeners();
  }
}
