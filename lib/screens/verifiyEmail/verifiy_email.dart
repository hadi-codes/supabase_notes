import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_notes/services/auth/auth.dart';

class VerifiyEmailPage extends StatefulWidget {
  const VerifiyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifiyEmailPageState createState() => _VerifiyEmailPageState();
}

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

class _VerifiyEmailPageState extends State<VerifiyEmailPage> {
  void _check() async {
    await context.read<AuthCubit>().init();
    if (context.read<AuthCubit>().state.status == AuthStatus.emailNotVerified) {
      _btnController.error();
      await Future.delayed(const Duration(seconds: 2));
      _btnController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please verifiy your Email'),
          const SizedBox(
            height: 20,
          ),
          RoundedLoadingButton(
            controller: _btnController,
            onPressed: _check,
            child: const Text('Try agin'),
          ),
          const SizedBox(
            height: 20,
          ),
          IconButton(
            icon: const Icon(
              FeatherIcons.logOut,
              color: Colors.red,
            ),
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
          )
        ],
      ),
    );
  }
}
