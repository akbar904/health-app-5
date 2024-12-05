import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../auth/auth_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class LoginView extends StackedView<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AuthViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.school,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: viewModel.setEmail,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: viewModel.setPassword,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: viewModel.navigateToForgotPassword,
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 16),
              if (viewModel.isBusy)
                const LoadingIndicator()
              else
                ElevatedButton(
                  onPressed: viewModel.login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: viewModel.navigateToRegister,
                    child: const Text('Register'),
                  ),
                ],
              ),
              if (viewModel.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ErrorDisplay(error: viewModel.error.toString()),
                ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  // Handle Google sign in
                },
                icon: Image.network(
                  'https://www.google.com/favicon.ico',
                  height: 24,
                ),
                label: const Text('Continue with Google'),
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