import 'package:drink_app/option1/auth/providers/auth_state_provider.dart';
import 'package:drink_app/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwdController.dispose();
    usernameController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text('e-mail'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Add meg az emailed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        label: Text('username'),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Add meg a nevedet';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: passwdController,
                      decoration: const InputDecoration(
                        label: Text('password'),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Add meg a jelszót';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(authStateProvider.notifier).createAccount(
                                email: emailController.text.trim(),
                                passwd: passwdController.text.trim(),
                                username: usernameController.text.trim(),
                              );
                        }
                      },
                      child: const Text('Signup'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
              child: const Text('Bejelentkezés'),
            ),
          ],
        ),
      ),
    );
  }
}
