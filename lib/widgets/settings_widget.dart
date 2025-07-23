import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../utils/ui_constants.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(UIConstants.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Settings Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: UIConstants.primaryGradient,
              borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
              boxShadow: UIConstants.elevatedShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(UIConstants.extraLargePadding),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(UIConstants.largePadding),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(UIConstants.largeRadius),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: UIConstants.largeSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: UIConstants.headingLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: UIConstants.smallSpacing),
                        Text(
                          'Manage your app preferences',
                          style: UIConstants.bodyLarge.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: UIConstants.extraLargeSpacing),
          
          // Account Settings
          Text(
            'Account',
            style: UIConstants.headingMedium,
          ),
          const SizedBox(height: UIConstants.largeSpacing),
          
          _buildSettingsCard([
            _buildSettingsItem(
              context,
              'Profile Settings',
              'Update your personal information',
              Icons.person_outline_rounded,
              UIConstants.primaryColor,
              () => _showComingSoon(context, 'Profile Settings'),
            ),
            _buildSettingsItem(
              context,
              'Security',
              'Change password and security settings',
              Icons.security_rounded,
              const Color(0xFF10B981),
              () => _showComingSoon(context, 'Security'),
            ),
            _buildSettingsItem(
              context,
              'Privacy',
              'Manage your privacy preferences',
              Icons.privacy_tip_outlined,
              const Color(0xFF8B5CF6),
              () => _showComingSoon(context, 'Privacy'),
            ),
          ]),
          
          const SizedBox(height: UIConstants.extraLargeSpacing),
          
          // App Settings
          Text(
            'Application',
            style: UIConstants.headingMedium,
          ),
          const SizedBox(height: UIConstants.largeSpacing),
          
          _buildSettingsCard([
            _buildSettingsItem(
              context,
              'Notifications',
              'Configure notification preferences',
              Icons.notifications_outlined,
              const Color(0xFF06B6D4),
              () => _showComingSoon(context, 'Notifications'),
            ),
            _buildSettingsItem(
              context,
              'Theme',
              'Customize app appearance',
              Icons.palette_outlined,
              const Color(0xFFF59E0B),
              () => _showComingSoon(context, 'Theme'),
            ),
            _buildSettingsItem(
              context,
              'Language',
              'Change app language',
              Icons.language_rounded,
              const Color(0xFF3B82F6),
              () => _showComingSoon(context, 'Language'),
            ),
          ]),
          
          const SizedBox(height: UIConstants.extraLargeSpacing),
          
          // Support & Info
          Text(
            'Support & Information',
            style: UIConstants.headingMedium,
          ),
          const SizedBox(height: UIConstants.largeSpacing),
          
          _buildSettingsCard([
            _buildSettingsItem(
              context,
              'Help Center',
              'Get help and support',
              Icons.help_outline_rounded,
              const Color(0xFF22C55E),
              () => _showComingSoon(context, 'Help Center'),
            ),
            _buildSettingsItem(
              context,
              'About',
              'App version and information',
              Icons.info_outline_rounded,
              UIConstants.textSecondaryColor,
              () => _showAbout(context),
            ),
            _buildSettingsItem(
              context,
              'Sign Out',
              'Sign out of your account',
              Icons.logout_rounded,
              UIConstants.errorColor,
              () => _signOut(context),
              isDestructive: true,
            ),
          ]),
          
          const SizedBox(height: UIConstants.extraLargeSpacing),
        ],
      ),
    );
  }
  
  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: UIConstants.cardGradient,
        borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
        boxShadow: UIConstants.cardShadow,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
  
  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.largePadding),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(UIConstants.mediumPadding),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: UIConstants.largeSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: UIConstants.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDestructive ? UIConstants.errorColor : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: UIConstants.bodyMedium.copyWith(
                        color: UIConstants.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: UIConstants.textSecondaryColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: UIConstants.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
              ),
              child: const Icon(
                Icons.hourglass_top_rounded,
                color: UIConstants.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: UIConstants.mediumSpacing),
            const Text('Coming Soon'),
          ],
        ),
        content: Text(
          'The "$feature" feature is under development and will be available in a future update.',
          style: UIConstants.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'GOT IT',
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: UIConstants.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: UIConstants.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: UIConstants.mediumSpacing),
            const Text('About'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Synergetics Manager',
              style: UIConstants.headingSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: UIConstants.smallSpacing),
            Text(
              'Version 1.0.0',
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.textSecondaryColor,
              ),
            ),
            const SizedBox(height: UIConstants.mediumSpacing),
            Text(
              'A comprehensive management solution for modern businesses.',
              style: UIConstants.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CLOSE',
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: UIConstants.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(UIConstants.mediumRadius),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: UIConstants.errorColor,
                size: 20,
              ),
            ),
            const SizedBox(width: UIConstants.mediumSpacing),
            const Text('Sign Out'),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out of your account?',
          style: UIConstants.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCEL',
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().signOut();
            },
            child: Text(
              'SIGN OUT',
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}