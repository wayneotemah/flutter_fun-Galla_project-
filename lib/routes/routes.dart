import 'package:get/get.dart';

import '../views/collectionList.dart';
import '../views/dashboard.dart';
import '../views/eventdetails.dart';
import '../views/signUp.dart';
import '../views/signIn.dart';
import '../views/uploadpage.dart';

class RoutesClass {
  static String dashBoard = '/dashBoard';
  static String login = '/login';
  static String signUp = '/signUp';
  static String eventDetails = '/eventDetails';
  static String collectionList = '/collectionList';
  static String uploadpage = '/uploadpage';

  static String getLoginRoute() => login;
  static String getSingUpRoute() => signUp;
  static String getDashBoardRoute() => dashBoard;
  static String getEventDetails() => eventDetails;
  static String getCollectionListScreen() => collectionList;
  static String getUploadPage() => uploadpage;

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
      page: () => EventDetails(),
      name: eventDetails,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      page: () => CollectionListScreen(),
      name: collectionList,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      page: () => UploadPage(),
      name: uploadpage,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    )
  ];
}
