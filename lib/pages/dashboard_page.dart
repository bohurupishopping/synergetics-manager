// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../models/enums.dart';
import '../models/profile.dart';
import '../utils/app_router.dart';

import '../widgets/profile_widget.dart';
import '../widgets/settings_widget.dart';

// Enhanced Modern & Professional UI Constants
class _UIConstants {
  static const Color primary = Color(0xFF6366F1);      // Indigo

  static const Color error = Color(0xFFEF4444);         // Red
  
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  
  static const Color background = Color(0xFFF8FAFC);    // Light slate background
  static const Color backgroundSecondary = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0);
  static const Color surface = Colors.white;

  // Enhanced Navigation Card Colors with gradients
  static final List<List<Color>> navItemGradients = [
    [const Color(0xFFEEF2FF), const Color(0xFFE0E7FF)], // Indigo gradient
    [const Color(0xFFECFEFF), const Color(0xFFCFFAFE)], // Cyan gradient
    [const Color(0xFFF3E8FF), const Color(0xFFE9D5FF)], // Purple gradient
    [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)], // Emerald gradient
    [const Color(0xFFFEF3C7), const Color(0xFFFDE68A)], // Amber gradient
    [const Color(0xFFFEE2E2), const Color(0xFFFECACA)], // Red gradient
    [const Color(0xFFEFF6FF), const Color(0xFFDBEAFE)], // Blue gradient
    [const Color(0xFFF0FDF4), const Color(0xFFDCFCE7)], // Green gradient
  ];

  // Enhanced icon colors with better contrast
  static final List<Color> navIconColors = [
    const Color(0xFF6366F1), // Indigo
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFF10B981), // Emerald
    const Color(0xFFF59E0B), // Amber
    const Color(0xFFEF4444), // Red
    const Color(0xFF3B82F6), // Blue
    const Color(0xFF22C55E), // Green
  ];

  // Shadow definitions
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static const double pagePadding = 20.0;
  static const double borderRadius = 16.0;
  static const double cardRadius = 16.0;
  static const double iconSize = 28.0;
}

// Navigation Models
class NavItem {
  final String title;
  final IconData icon;
  final String route;
  final bool isComingSoon;
  final String description;
  final Widget? widget;

  const NavItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.description,
    this.isComingSoon = false,
    this.widget,
  });
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // OPTIMIZATION: The navigation data is static and constant
  static const List<NavItem> _navItems = [
    // Core Features
    NavItem(
      title: 'Projects',
      icon: Icons.assignment_outlined,
      route: '/dashboard/projects',
      description: 'Manage your projects',
      isComingSoon: true,
    ),
    NavItem(
      title: 'Tasks',
      icon: Icons.task_alt_rounded,
      route: '/dashboard/tasks',
      description: 'Track your tasks',
      isComingSoon: true,
    ),
    NavItem(
      title: 'Reports',
      icon: Icons.analytics_outlined,
      route: '/dashboard/reports',
      description: 'View analytics',
      isComingSoon: true,
    ),
    
    // Management
    NavItem(
      title: 'Team',
      icon: Icons.group_outlined,
      route: '/dashboard/team',
      description: 'Manage team members',
      isComingSoon: true,
    ),
    NavItem(
      title: 'Calendar',
      icon: Icons.calendar_today_outlined,
      route: '/dashboard/calendar',
      description: 'Schedule events',
      isComingSoon: true,
    ),
    NavItem(
      title: 'Messages',
      icon: Icons.message_outlined,
      route: '/dashboard/messages',
      description: 'Team communication',
      isComingSoon: true,
    ),
    
    // Settings & Profile
    NavItem(
      title: 'Profile',
      icon: Icons.person_outline_rounded,
      route: '/dashboard/profile',
      description: 'Your profile info',
      widget: ProfileWidget(),
    ),
    NavItem(
      title: 'Settings',
      icon: Icons.settings_outlined,
      route: '/dashboard/settings',
      description: 'App preferences',
      widget: SettingsWidget(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            context.goToLogin();
          },
          authenticated: (user, profile, kyc) {
            if (kyc?.status != KycStatus.approved) {
              // KYC not approved, redirect to appropriate page
              if (kyc?.status == KycStatus.pendingReview) {
                context.goToPending();
              } else {
                context.goToKyc();
              }
            }
          },
        );
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _LoadingWidget(),
            loading: () => const _LoadingWidget(),
            unauthenticated: () => const _ErrorWidget(message: 'Authentication Required'),
            authenticated: (user, profile, kyc) {
              if (kyc?.status != KycStatus.approved) {
                return const _ErrorWidget(message: 'KYC Approval Required');
              }
              return _DashboardContent(user: user, profile: profile);
            },
            error: (message) => _ErrorWidget(message: message),
          );
        },
      ),
    );
  }
}

// Main Dashboard Content
class _DashboardContent extends StatelessWidget {
  final dynamic user; // Replace with your User model type
  final Profile? profile;

  const _DashboardContent({required this.user, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _UIConstants.background,
      body: SafeArea(
        child: Column(
          children: [
            _AdminHeader(user: user, profile: profile),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(_UIConstants.pagePadding),
                child: const _NavigationGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modern Admin Header
class _AdminHeader extends StatelessWidget {
  final dynamic user;
  final Profile? profile;

  const _AdminHeader({required this.user, this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_UIConstants.pagePadding),
      decoration: BoxDecoration(
        color: _UIConstants.surface,
        boxShadow: _UIConstants.cardShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 14,
                    color: _UIConstants.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile?.fullName?.isNotEmpty == true ? profile!.fullName! : 'User',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: _UIConstants.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _HeaderButton(
                icon: Icons.notifications_outlined,
                onTap: () => _showComingSoon(context),
              ),
              const SizedBox(width: 12),
              _UserChip(user: user, profile: profile),
            ],
          ),
        ],
      ),
    );
  }
}

// User Profile Chip
class _UserChip extends StatelessWidget {
  final dynamic user;
  final Profile? profile;

  const _UserChip({required this.user, this.profile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUserMenu(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _UIConstants.backgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _UIConstants.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: _UIConstants.primary,
              child: Text(
                profile?.fullName?.isNotEmpty == true ? profile!.fullName![0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: _UIConstants.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _UIConstants.surface,
          borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person_outline, color: _UIConstants.primary),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _navigateToWidget(context, const ProfileWidget());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined, color: _UIConstants.primary),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                _navigateToWidget(context, const SettingsWidget());
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: _UIConstants.error),
              title: Text('Sign Out', style: TextStyle(color: _UIConstants.error)),
              onTap: () {
                Navigator.pop(context);
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Header Button
class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _UIConstants.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _UIConstants.border),
        ),
        child: Icon(
          icon,
          size: 20,
          color: _UIConstants.textSecondary,
        ),
      ),
    );
  }
}

// Navigation Grid
class _NavigationGrid extends StatelessWidget {
  const _NavigationGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: DashboardPage._navItems.length,
      itemBuilder: (context, index) {
        final item = DashboardPage._navItems[index];
        return _NavItemCard(
          item: item,
          gradientColors: _UIConstants.navItemGradients[index % _UIConstants.navItemGradients.length],
          iconColor: _UIConstants.navIconColors[index % _UIConstants.navIconColors.length],
        );
      },
    );
  }
}

// Navigation Item Card
class _NavItemCard extends StatelessWidget {
  final NavItem item;
  final List<Color> gradientColors;
  final Color iconColor;

  const _NavItemCard({
    required this.item,
    required this.gradientColors,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleNavigation(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(_UIConstants.cardRadius),
          boxShadow: _UIConstants.cardShadow,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      item.icon,
                      size: _UIConstants.iconSize,
                      color: iconColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _UIConstants.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: _UIConstants.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (item.isComingSoon)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _UIConstants.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Soon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context) {
    if (item.isComingSoon) {
      _showComingSoon(context);
    } else if (item.widget != null) {
      _navigateToWidget(context, item.widget!);
    } else {
      // Handle other navigation
      _showComingSoon(context);
    }
  }
}

// Loading Widget
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _UIConstants.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: _UIConstants.surface,
            borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
            boxShadow: _UIConstants.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_UIConstants.primary),
              ),
              const SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  color: _UIConstants.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Error Widget
class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _UIConstants.background,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: _UIConstants.surface,
            borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
            boxShadow: _UIConstants.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: _UIConstants.error,
              ),
              const SizedBox(height: 20),
              Text(
                'Error',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _UIConstants.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(
                  color: _UIConstants.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Functions
void _showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Feature coming soon!'),
      backgroundColor: _UIConstants.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

void _navigateToWidget(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void _signOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_UIConstants.borderRadius),
      ),
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<AuthCubit>().signOut();
          },
          style: TextButton.styleFrom(
            foregroundColor: _UIConstants.error,
          ),
          child: const Text('Sign Out'),
        ),
      ],
    ),
  );
}