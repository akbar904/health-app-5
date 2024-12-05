import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_display.dart';
import 'auth_viewmodel.dart';

class RegisterView extends StackedView<AuthViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AuthViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: viewModel.isBusy
          ? const LoadingIndicator()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (viewModel.hasError)
                    ErrorDisplay(error: viewModel.error.toString()),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Full Name',
                    controller: viewModel.nameController,
                    validator: viewModel.validateName,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Email',
                    controller: viewModel.emailController,
                    validator: viewModel.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Password',
                    controller: viewModel.passwordController,
                    validator: viewModel.validatePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Confirm Password',
                    controller: viewModel.confirmPasswordController,
                    validator: (value) => viewModel.validateConfirmPassword(
                        value, viewModel.passwordController.text),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: viewModel.selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'student',
                        child: Text('Student'),
                      ),
                      DropdownMenuItem(
                        value: 'teacher',
                        child: Text('Teacher'),
                      ),
                      DropdownMenuItem(
                        value: 'parent',
                        child: Text('Parent'),
                      ),
                    ],
                    onChanged: viewModel.setRole,
                  ),
                  if (viewModel.selectedRole == 'parent')
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        CustomInput(
                          label: 'Student Code',
                          controller: viewModel.studentCodeController,
                          validator: viewModel.validateStudentCode,
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  CustomButton(
                    title: 'Register',
                    onPressed: viewModel.register,
                    isLoading: viewModel.isBusy,
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

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel();
}

