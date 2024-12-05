import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../auth/auth_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class RegisterView extends StackedView<AuthViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AuthViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setPassword,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                onChanged: viewModel.setConfirmPassword,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'User Role',
                  border: OutlineInputBorder(),
                ),
                value: viewModel.selectedRole,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                  DropdownMenuItem(value: 'parent', child: Text('Parent')),
                ],
                onChanged: viewModel.setRole,
              ),
              const SizedBox(height: 24),
              if (viewModel.isBusy)
                const LoadingIndicator()
              else
                ElevatedButton(
                  onPressed: viewModel.register,
                  child: const Text('Register'),
                ),
              if (viewModel.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ErrorDisplay(error: viewModel.error.toString()),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: viewModel.navigateToLogin,
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel();
}