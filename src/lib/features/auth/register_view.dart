import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_handler.dart';
import '../../widgets/responsive_layout.dart';
import '../../models/user.dart';
import 'auth_viewmodel.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _buildRegistrationForm(context, model),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, AuthViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: _buildRegistrationForm(context, model),
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
                    'Join Gyde Learning',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Create your account to start learning',
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
                  child: _buildRegistrationForm(context, model),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context, AuthViewModel model) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.school,
            size: 64,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Create Account',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) => model.setName(value),
          ),
          const SizedBox(height: 16),
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
          DropdownButtonFormField<UserRole>(
            decoration: const InputDecoration(
              labelText: 'Role',
              prefixIcon: Icon(Icons.person_outline),
            ),
            items: UserRole.values.map((role) {
              return DropdownMenuItem(
                value: role,
                child: Text(role.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                model.setSelectedRole(value);
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a role';
              }
              return null;
            },
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
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            onChanged: (value) => model.setPassword(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  model.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => model.togglePasswordVisibility(),
              ),
            ),
            obscureText: !model.isPasswordVisible,
            validator: (value) {
              if (value != model.password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          if (model.selectedRole == UserRole.student) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Parent Email (Optional)',
                prefixIcon: Icon(Icons.family_restroom),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => model.setParentEmail(value),
            ),
          ],
          const SizedBox(height: 24),
          if (model.isBusy)
            const LoadingIndicator()
          else
            ElevatedButton(
              onPressed: () => model.register(),
              child: const Text('Register'),
            ),
          if (model.hasError) ...[
            const SizedBox(height: 16),
            ErrorHandler(error: model.error),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: () => model.navigateToLogin(),
                child: const Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}