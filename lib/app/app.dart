import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:supabase_notes/routes/pages.dart';
import 'package:supabase_notes/services/services.dart';
import 'package:supabase_notes/theme/theme.dart';
import 'package:supabase_notes/utils/locator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthCubit(auth: locator.get<AuthRepo>())..init(),
      ),
    ], child: const _Root());
  }
}

class _Root extends StatefulWidget {
  const _Root({Key? key}) : super(key: key);

  @override
  __RootState createState() => __RootState();
}

class __RootState extends State<_Root> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: AppTheme.themeData,
      getPages: AppPages.routes,
      initialRoute: AppPages.inital,
      builder: (context, child) => BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              Get.offNamedUntil(Routes.home, (route) => false);
              break;

            case AuthStatus.unauthenticated:
            case AuthStatus.unknown:
              Get.offNamedUntil(Routes.login, (route) => false);

              break;
            case AuthStatus.emailNotVerified:
              Get.offNamedUntil(Routes.verifiyEmail, (route) => false);

              break;
          }
        },
        child: child,
      ),
    );
  }
}
