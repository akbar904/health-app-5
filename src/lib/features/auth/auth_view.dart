import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/auth/auth_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/utils/enums/role_enum.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Gyde',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpaceLarge,
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!viewModel.isRegistering) ...[
                        _buildLoginForm(viewModel),
                      ] else ...[
                        _buildRegistrationForm(viewModel),
                      ],
                      verticalSpaceMedium,
                      if (viewModel.hasError)
                        Text(
                          viewModel.modelError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      verticalSpaceMedium,
                      ElevatedButton(
                        onPressed: viewModel.isBusy
                            ? null
                            : viewModel.isRegistering
                                ? viewModel.register
                                : viewModel.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kcPrimaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: viewModel.isBusy
                            ? const CircularProgressIndicator()
                            : Text(
                                viewModel.isRegistering ? 'Register' : 'Login',
                              ),
                      ),
                      verticalSpaceMedium,
                      TextButton(
                        onPressed: viewModel.toggleAuthMode,
                        child: Text(
                          viewModel.isRegistering
                              ? 'Already have an account? Login'
                              : 'Don\'t have an account? Register',
                        ),
                      ),
                      if (!viewModel.isRegistering)
                        TextButton(
                          onPressed: viewModel.showForgotPasswordDialog,
                          child: const Text('Forgot Password?'),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(AuthViewModel viewModel) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: viewModel.setEmail,
        ),
        verticalSpaceMedium,
        TextField(
          decoration: const InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
          onChanged: viewModel.setPassword,
        ),
      ],
    );
  }

  Widget _buildRegistrationForm(AuthViewModel viewModel) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: viewModel.setName,
        ),
        verticalSpaceMedium,
        TextField(
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: viewModel.setEmail,
        ),
        verticalSpaceMedium,
        TextField(
          decoration: const InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
          onChanged: viewModel.setPassword,
        ),
        verticalSpaceMedium,
        DropdownButtonFormField<UserRole>(
          decoration: const InputDecoration(
            labelText: 'Role',
            prefixIcon: Icon(Icons.badge),
          ),
          value: viewModel.selectedRole,
          items: UserRole.values
              .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  ))
              .toList(),
          onChanged: viewModel.setRole,
        ),
      ],
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel();
}
