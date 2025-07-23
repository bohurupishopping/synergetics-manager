import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../utils/validators.dart';
import '../utils/app_router.dart';
import '../utils/ui_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {
            setState(() {
              _isLoading = true;
            });
          },
          unauthenticated: () {
            setState(() {
              _isLoading = false;
            });
          },
          authenticated: (user, profile, kyc) {
            setState(() {
              _isLoading = false;
            });
            // Router will handle navigation based on KYC status
            context.goToDashboard();
          },
          error: (message) {
            setState(() {
              _isLoading = false;
            });
            _showErrorSnackBar(message);
          },
        );
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: UIConstants.backgroundGradient,
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(UIConstants.largePadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with modern design
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: UIConstants.primaryGradient,
                        borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
                        boxShadow: UIConstants.elevatedShadow,
                      ),
                      child: const Icon(
                        Icons.business_center_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: UIConstants.extraLargeSpacing),
                    
                    // Title with modern typography
                    Text(
                      'Welcome Back',
                      style: UIConstants.headingLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: UIConstants.smallSpacing),
                    Text(
                      'Sign in to your account to continue',
                      style: UIConstants.bodyLarge.copyWith(
                        color: UIConstants.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: UIConstants.extraLargeSpacing * 1.5),
                    
                    // Modern Login Form Card
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        gradient: UIConstants.cardGradient,
                        borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
                        boxShadow: UIConstants.cardShadow,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(UIConstants.extraLargePadding),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Email Field with modern styling
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                enabled: !_isLoading,
                                style: UIConstants.bodyLarge,
                                decoration: UIConstants.inputDecoration(
                                  hintText: 'Enter your email address',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: UIConstants.textSecondaryColor,
                                  ),
                                ),
                                validator: Validators.validateEmail,
                              ),
                              const SizedBox(height: UIConstants.largeSpacing),
                              
                              // Password Field with modern styling
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                enabled: !_isLoading,
                                style: UIConstants.bodyLarge,
                                decoration: UIConstants.inputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: UIConstants.textSecondaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: UIConstants.textSecondaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: Validators.validatePassword,
                                onFieldSubmitted: (_) => _handleLogin(),
                              ),
                              const SizedBox(height: UIConstants.extraLargeSpacing),
                              
                              // Modern Login Button
                              SizedBox(
                                height: 56,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: UIConstants.primaryGradient,
                                    borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
                                    boxShadow: UIConstants.buttonShadow,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Sign In',
                                            style: UIConstants.buttonText,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: UIConstants.extraLargeSpacing),
                    
                    // Help Text with modern styling
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: UIConstants.mediumPadding,
                        vertical: UIConstants.smallPadding,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(UIConstants.largeRadius),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.help_outline_rounded,
                            size: 16,
                            color: UIConstants.textSecondaryColor,
                          ),
                          const SizedBox(width: UIConstants.smallSpacing),
                          Text(
                            'Need help? Contact your administrator',
                            style: UIConstants.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}