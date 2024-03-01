import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/Forgot%20password/forgot%20password.dart';
import 'package:tech_media/view/Messages/Messages_Screen.dart';
import 'package:tech_media/view/Messages/chat_Screen.dart';
import 'package:tech_media/view/dashborad/dashboard_Screen.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/profile/Profile_Screen.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.Signup:
        return MaterialPageRoute(builder: (_) => const SignScreen());


      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());


      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());


      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProflieScreen());

      case RouteName.message:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());






      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}