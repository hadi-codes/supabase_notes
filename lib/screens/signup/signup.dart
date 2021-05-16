import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/routes/pages.dart';
import 'package:supabase_notes/services/auth/auth.dart';
import 'package:supabase_notes/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFieldWidget(
                title: 'Email',
                textEditingController: _email,
              ),
              TextFieldWidget(
                title: 'Password',
                textEditingController: _pass,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().signup(_email.text, _pass.text);
                },
                child: Text(
                  'Signup',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.offNamed(Routes.login),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.transparent),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
