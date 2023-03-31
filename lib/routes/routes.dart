import 'package:get/get.dart';

import '../views/dashboard.dart';
import '../views/eventdetails.dart';
import '../views/signUp.dart';
import '../views/signIn.dart';

class RoutesClass {
  static String dashBoard = '/dashBoard';
  static String login = '/login';
  static String signUp = '/signUp';
  static String eventDetails = '/eventDetails';

  static String getLoginRoute() => login;
  static String getSingUpRoute() => signUp;
  static String getDashBoardRoute() => dashBoard;
  static String getEventDetails() => eventDetails;

  static List<GetPage> routes = [
    GetPage(
      page: () => const DashBoardScreen(),
      name: dashBoard,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: login,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: signUp,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: eventDetails,
      page: () => EventDetails(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    )
  ];
}
