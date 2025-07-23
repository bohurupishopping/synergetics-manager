import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/kyc/kyc_flow_page.dart';
import '../pages/pending_approval_page.dart';
import '../pages/dashboard_page.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../models/enums.dart';
import '../models/profile.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  
  static GoRouter createRouter(AuthCubit authCubit) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',
      redirect: (context, state) {
        final authState = authCubit.state;
        final location = state.uri.toString();
        
        // Handle authentication-based routing
        return authState.when(
          initial: () => location == '/splash' ? null : '/splash',
          loading: () => location == '/splash' ? null : '/splash',
          unauthenticated: () {
            if (location == '/splash' || location == '/login') {
              return null;
            }
            return '/login';
          },
          authenticated: (user, profile, kyc) {
            // Skip splash and login if authenticated
            if (location == '/splash' || location == '/login') {
              return _getAuthenticatedRoute(kyc);
            }
            
            // Check if user can access the requested route
            return _validateRouteAccess(location, kyc);
          },
          error: (_) => location == '/login' ? null : '/login',
        );
      },
      routes: [
        // Splash Screen
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        
        // Login Page
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        
        // KYC Flow
        GoRoute(
          path: '/kyc',
          name: 'kyc',
          builder: (context, state) => const KycFlowPage(),
        ),
        
        // Pending Approval
        GoRoute(
          path: '/pending',
          name: 'pending',
          builder: (context, state) => const PendingApprovalPage(),
        ),
        
        // Dashboard (Main App)
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
      ],
      
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The page "${state.uri.toString()}" could not be found.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Determine the appropriate route for authenticated users
  static String _getAuthenticatedRoute(ProfileKyc? kyc) {
    if (kyc == null) {
      // No KYC data, redirect to KYC flow
      return '/kyc';
    }
    
    switch (kyc.status) {
      case KycStatus.notSubmitted:
      case KycStatus.rejected:
        return '/kyc';
      case KycStatus.pendingReview:
        return '/pending';
      case KycStatus.approved:
        return '/dashboard';
    }
  }
  
  /// Validate if user can access the requested route
  static String? _validateRouteAccess(String location, ProfileKyc? kyc) {
    // Allow access to any route if KYC is approved
    if (kyc?.status == KycStatus.approved) {
      return null;
    }
    
    // Restrict access based on KYC status
    if (kyc == null || kyc.status.needsSubmission) {
      // Only allow KYC route
      return location == '/kyc' ? null : '/kyc';
    }
    
    if (kyc.status == KycStatus.pendingReview) {
      // Only allow pending route
      return location == '/pending' ? null : '/pending';
    }
    
    return null;
  }
}

/// Extension methods for easier navigation
extension AppRouterExtension on BuildContext {
  /// Navigate to splash page
  void goToSplash() => go('/splash');
  
  /// Navigate to login page
  void goToLogin() => go('/login');
  
  /// Navigate to KYC flow
  void goToKyc() => go('/kyc');
  
  /// Navigate to pending approval page
  void goToPending() => go('/pending');
  
  /// Navigate to dashboard
  void goToDashboard() => go('/dashboard');
  
  /// Navigate back or to dashboard if no previous route
  void goBackOrDashboard() {
    if (canPop()) {
      pop();
    } else {
      goToDashboard();
    }
  }
}