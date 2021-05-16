import 'package:get/get.dart';
import 'package:supabase_notes/screens/home/home.dart';
import 'package:supabase_notes/screens/screens.dart';

part 'routes.dart';

class AppPages {
  static const String inital = Routes.splash;

  static final routes = [
    GetPage(
      transition: Transition.cupertino,
      name: Routes.signUp,
      page: () => const SignupPage(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: Routes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: Routes.verifiyEmail,
      page: () => const VerifiyEmailPage(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: Routes.noteEditor,
      page: () => const NoteEditorPage(),
    ),
  ];
}
