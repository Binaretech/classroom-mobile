import 'package:classroom_mobile/router/app_path.dart';
import 'package:flutter/material.dart';

class AppRouteInformationRouter extends RouteInformationParser<AppPath> {
  @override
  Future<AppPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return AppPath.home();
    }

    return AppPath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppPath configuration) {
    if (configuration.isUnknownPage) {
      return const RouteInformation(location: '/404');
    }

    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }

    return null;
  }
}
