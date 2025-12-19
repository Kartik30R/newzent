import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/view/screens/app/article_screen.dart';
import 'package:newzent/view/screens/app/explore_screen.dart';
import 'package:newzent/view/screens/app/feed_screen.dart';
import 'package:newzent/view/screens/app/main_screen.dart';
import 'package:newzent/view/screens/app/profile_screen.dart';
import 'package:newzent/view/screens/auth/interests_screen.dart';
import 'package:newzent/view/screens/auth/login_screen.dart';
import 'package:newzent/view/screens/auth/sign_up.dart';
import 'package:newzent/view/screens/auth/welcome_page.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: main,
      page: () => MainPage(),
    ),
    GetPage(
      name: welcome,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: feed,
      page: () => FeedScreen(),
    ),
    GetPage(
      name: explore,
      page: () => ExploreScreen(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
    ),
 GetPage(
  name: article,
  page: () {
    final args = Get.arguments as Map<String, dynamic>;

    return ArticleScreen(
      articles: List<Articles>.from(args['articles']),
      initialIndex: args['index'] as int,
    );
  },
),


    GetPage(
      name: signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: logIn,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: interest,
      page: () => InterestsScreen(),
    ),
  ];

  static getMain() => main;
  static getWelcome() => welcome;
  static getFeed() => feed;
  static getExplore() => explore;
  static getProfile() => profile;
  static getArticle() => article;
  static getSignUp() => signUp;
  static getLogIn() => logIn;
  static getInterest() => interest;

  static String main = "/main";
  static String welcome = "/welcome";
  static String feed = "/feed";
  static String explore = "/explore";
  static String profile = "/profile";
  static String article = "/article";
  static String signUp = "/singUp";
  static String logIn = "/logIn";
  static String interest = "/interest";
}
