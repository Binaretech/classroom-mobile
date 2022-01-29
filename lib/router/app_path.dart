class AppPath {
  final bool _isHome;
  final bool _isUnknown;

  AppPath.home()
      : _isHome = true,
        _isUnknown = false;

  AppPath.unknown()
      : _isHome = false,
        _isUnknown = true;

  bool get isHomePage => _isHome;

  bool get isUnknownPage => _isUnknown;
}
