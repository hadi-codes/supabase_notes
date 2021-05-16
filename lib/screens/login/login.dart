import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/routes/pages.dart';
import 'package:supabase_notes/services/services.dart';
import 'package:supabase_notes/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null)
          Get.snackbar('Error', state.errorMessage!);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  title: 'Email',
                  textEditingController: _email,
                ),
                TextFieldWidget(
                  title: 'Password',
                  textEditingController: _pass,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(_email.text, _pass.text);
                  },
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Get.offNamed(Routes.signUp),
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.transparent),
                  child: Text(
                    'New Account',
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
