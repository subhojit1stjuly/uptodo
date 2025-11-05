/// these are the routing constants of he application
class RouteConstants {
  ///initial splash screen
  static const String splash = '/';

  ///initial onboarding screen
  static const String onBoarding = '/onboarding';

  /// login route
  static const String login = '/login';

  /// register route
  static const String register = '/register';

  /// permissions route
  static const String permissions = '/permissions';

  /// home route
  static const String home = '/home';

  /// change language route
  static const String changeLanguage = '/changeLanguage';

  /// settings route
  static const String settings = '/settings';

  /// index screen route
  static const String index = '/index';

  /// calendar screen route
  static const String calendar = '/calendar';

  /// focus screen route
  static const String focus = '/focus';

  /// profile screen route
  static const String profile = '/profile';

  /// home navigation
  static const Map<int, String> homeNavigation = {
    0: home,
    1: calendar,
    2: focus,
    3: profile,
  };

  /// task details route
  static const String taskDetails = '/taskDetails';

  /// category details route
  static const String categoryDetails = '/categoryDetails';
}
