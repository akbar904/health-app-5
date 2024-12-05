import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/forms/login_form.dart';
import 'auth_viewmodel.dart';

class LoginView extends ViewModelWidget<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Please sign in to continue',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              LoginForm(
                onSubmit: (email, password) =>
                    viewModel.login(email, password),
                isLoading: viewModel.isBusy,
                errorMessage: viewModel.hasError ? viewModel.errorMessage : null,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Implement forgot password navigation
                },
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: viewModel.navigateToRegister,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}