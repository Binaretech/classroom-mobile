import 'package:classroom_mobile/router/app_path.dart';
import 'package:classroom_mobile/router/router_page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouterDelegate extends RouterDelegate<AppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPath> {
  final GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _key;

  @override
  Future<void> setNewRoutePath(AppPath configuration) {
    throw UnimplementedError();
  }

  bool Function(Route<dynamic> dynamic, dynamic) _pop(
      RouterPageManager pageManager) {
    return (Route<dynamic> route, dynamic result) {
      final pop = route.didPop(result);
      if (pop) {
        pageManager.pop(route.settings as Page);
      }

      return pop;
    };
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RouterPageManager(false)..addListener(notifyListeners),
      child: Consumer<RouterPageManager>(
        builder: (context, pageManager, child) {
          return Navigator(
            pages: List.of(pageManager.pages),
            onPopPage: _pop(pageManager),
          );
        },
      ),
    );
  }
}
