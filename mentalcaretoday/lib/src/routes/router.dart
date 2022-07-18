import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/views/chat_screen.dart';
import 'package:mentalcaretoday/src/UI/views/conversation_screen.dart';
import 'package:mentalcaretoday/src/UI/views/created_at_screen.dart';
import 'package:mentalcaretoday/src/UI/views/forgot_password_screen.dart';
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/UI/views/music_list.dart';
import 'package:mentalcaretoday/src/UI/views/payment_screen.dart';
import 'package:mentalcaretoday/src/UI/views/profile_screen.dart';
import 'package:mentalcaretoday/src/UI/views/setting_screen.dart';
import 'package:mentalcaretoday/src/UI/views/sign_in_screen.dart';
import 'package:mentalcaretoday/src/UI/views/sign_up_screen.dart';
import 'package:mentalcaretoday/src/UI/views/specific_mood_screen.dart';
import 'package:mentalcaretoday/src/UI/views/splash_screen.dart';
import 'package:mentalcaretoday/src/UI/views/users_screen.dart';
import 'package:mentalcaretoday/src/routes/index.dart';

import '../UI/views/edit_card_screen.dart';

class MyRouter {
  Widget getRouterWithScaleFactor(BuildContext context, Widget screenName,
      {RouteSettings? settings}) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: screenName,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const SplashScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const HomeScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case createdAtScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const CreatedAtScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case signInScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const SignInScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );

      case forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const ForgotPasswordScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );

      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const SignUpScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case settingScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const SettingScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case paymentScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const PaymentScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const ProfileScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case conversationScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const ConversationScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case specificMoodScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const SpecificMoodScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case usersScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const UsersScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case chatScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const ChatScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case editCardScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const EditCardScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case musicListScreen:
        return MaterialPageRoute(
          builder: (context) =>
              getRouterWithScaleFactor(context, const MusicListScreen()),
          settings: RouteSettings(arguments: settings.arguments),
        );

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('No route defined for $name'),
        ),
      );
    });
  }
}
