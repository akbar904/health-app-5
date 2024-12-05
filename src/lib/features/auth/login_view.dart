import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_handler.dart';
import '../../widgets/responsive_layout.dart';
import 'auth_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return ResponsiveLayout(
          mobileBody: _buildMobileLayout(context, model),
          tabletBody: _buildTabletLayout(context, model),
          desktopBody: _buildDesktopLayout(context, model),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(context),
            const SizedBox(height: 48),
            _buildLoginForm(context, model),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(context),
                const SizedBox(height: 48),
                _buildLoginForm(context, model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to\nGyde Learning',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your comprehensive K-12 learning platform',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 48),
                      _buildLoginForm(context, model),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.school,
          size: 64,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 24),
        Text(
          'Login',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context, AuthViewModel model) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onChanged: (value) => model.setEmail(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  model.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => model.togglePasswordVisibility(),
              ),
            ),
            obscureText: !model.isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            onChanged: (value) => model.setPassword(value),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => model.forgotPassword(),
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 24),
          if (model.isBusy)
            const LoadingIndicator()
          else
            ElevatedButton(
              onPressed: () => model.login(),
              child: const Text('Login'),
            ),
          if (model.hasError) ...[
            const SizedBox(height: 16),
            ErrorHandler(error: model.error),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () => model.navigateToRegister(),
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}