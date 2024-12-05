import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/forms/registration_form.dart';
import '../auth/auth_viewmodel.dart';

class RegisterView extends ViewModelWidget<AuthViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Create your account',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            RegistrationForm(
              onSubmit: viewModel.register,
              isLoading: viewModel.isBusy,
              errorMessage: viewModel.hasError ? viewModel.errorMessage : null,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: viewModel.navigateToLogin,
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

