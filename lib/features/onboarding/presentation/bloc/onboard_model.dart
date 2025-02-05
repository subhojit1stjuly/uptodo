import 'package:flutter_svg/svg.dart';

/// this model represent the values
/// which will be shown in the ui
class OnboardModel {
  /// constructor
  const OnboardModel({
    required this.title,
    required this.desc,
    required this.image,
  });
  /// Onboarding Title
  final String title;
  /// Onboarding Description
  final String desc;
  /// Onboarding Image
  final SvgPicture image;
}
