// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../models/profile.dart';
import '../models/enums.dart';
import '../utils/app_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomePage(),
    const _ProfilePage(),
    const _SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              foregroundColor: Colors.red,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Synergetics Manager'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notifications feature coming soon'),
                  ),
                );
              },
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 18),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'signout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Sign Out', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'profile':
                    setState(() => _selectedIndex = 1);
                    break;
                  case 'settings':
                    setState(() => _selectedIndex = 2);
                    break;
                  case 'signout':
                    _signOut();
                    break;
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              unauthenticated: () => const Center(
                child: Text('Please log in to continue'),
              ),
              authenticated: (user, profile, kyc) {
                if (kyc?.status != KycStatus.approved) {
                  return const Center(
                    child: Text('KYC approval required'),
                  );
                }
                return _pages[_selectedIndex];
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<AuthCubit>().refreshUserData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.whenOrNull(
          authenticated: (user, profile, kyc) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                child: Text(
                                  _getInitials(profile?.fullName ?? user.email ?? 'U'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back,',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      profile?.fullName ?? user.email ?? 'User',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (profile?.appRole != null)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          profile!.appRole.displayName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context).colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'KYC Verified',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildQuickActionCard(
                        context,
                        'Projects',
                        Icons.folder_outlined,
                        Colors.blue,
                        () => _showComingSoon(context, 'Projects'),
                      ),
                      _buildQuickActionCard(
                        context,
                        'Tasks',
                        Icons.task_outlined,
                        Colors.orange,
                        () => _showComingSoon(context, 'Tasks'),
                      ),
                      _buildQuickActionCard(
                        context,
                        'Reports',
                        Icons.analytics_outlined,
                        Colors.green,
                        () => _showComingSoon(context, 'Reports'),
                      ),
                      _buildQuickActionCard(
                        context,
                        'Team',
                        Icons.group_outlined,
                        Colors.purple,
                        () => _showComingSoon(context, 'Team'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Recent Activity
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildActivityItem(
                            'KYC Application Approved',
                            'Your identity verification was completed successfully',
                            Icons.verified,
                            Colors.green,
                            '2 hours ago',
                          ),
                          const Divider(),
                          _buildActivityItem(
                            'Profile Created',
                            'Welcome to Synergetics Manager',
                            Icons.person_add,
                            Colors.blue,
                            '1 day ago',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ) ?? const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'U';
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon'),
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.whenOrNull(
          authenticated: (user, profile, kyc) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Header
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              _getInitials(profile?.fullName ?? user.email ?? 'U'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            profile?.fullName ?? 'No Name',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email ?? 'No Email',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          if (profile?.appRole != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                profile!.appRole.displayName,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Profile Information
                  if (profile != null) ...[
                    _buildInfoCard('Personal Information', [
                      _buildInfoRow('Full Name', profile.fullName ?? 'N/A'),
                      _buildInfoRow('Email', user.email ?? 'N/A'),
                      _buildInfoRow('Phone', profile.phoneNumber ?? 'N/A'),
                      _buildInfoRow('Role', profile.appRole.displayName),
                    ]),
                    const SizedBox(height: 16),
                  ],
                  
                  if (kyc?.address != null) ...[
                    _buildInfoCard('Address', [
                      _buildInfoRow('Street', kyc!.address!.street),
                      _buildInfoRow('City', kyc.address!.city),
                      _buildInfoRow('State', kyc.address!.state),
                      _buildInfoRow('ZIP Code', kyc.address!.zipCode),
                      _buildInfoRow('Country', kyc.address!.country ?? 'India'),
                    ]),
                    const SizedBox(height: 16),
                  ],
                  
                  if (kyc != null) ...[
                    _buildInfoCard('KYC Information', [
                      _buildInfoRow('Status', kyc.status.displayName),
                      _buildInfoRow('PAN Card', _maskSensitiveData(kyc.panCardNumber ?? '')),
                      _buildInfoRow('Aadhar Card', _maskSensitiveData(kyc.aadharCardNumber ?? '')),
                      _buildInfoRow('Submitted', _formatDate(kyc.createdAt)),
                      if (kyc.updatedAt != kyc.createdAt)
                        _buildInfoRow('Updated', _formatDate(kyc.updatedAt)),
                    ]),
                  ],
                ],
              ),
            );
          },
        ) ?? const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'U';
  }

  String _maskSensitiveData(String data) {
    if (data.length <= 4) return data;
    return '${'*' * (data.length - 4)}${data.substring(data.length - 4)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSettingsCard(
            'Account',
            [
              _buildSettingsItem(
                Icons.person_outline,
                'Edit Profile',
                'Update your personal information',
                () => _showComingSoon(context, 'Edit Profile'),
              ),
              _buildSettingsItem(
                Icons.security,
                'Change Password',
                'Update your account password',
                () => _showComingSoon(context, 'Change Password'),
              ),
              _buildSettingsItem(
                Icons.verified_user_outlined,
                'Two-Factor Authentication',
                'Add an extra layer of security',
                () => _showComingSoon(context, 'Two-Factor Authentication'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            'Preferences',
            [
              _buildSettingsItem(
                Icons.notifications_outlined,
                'Notifications',
                'Manage your notification preferences',
                () => _showComingSoon(context, 'Notifications'),
              ),
              _buildSettingsItem(
                Icons.language,
                'Language',
                'Choose your preferred language',
                () => _showComingSoon(context, 'Language'),
              ),
              _buildSettingsItem(
                Icons.dark_mode_outlined,
                'Theme',
                'Switch between light and dark mode',
                () => _showComingSoon(context, 'Theme'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            'Support',
            [
              _buildSettingsItem(
                Icons.help_outline,
                'Help Center',
                'Get help and support',
                () => _showComingSoon(context, 'Help Center'),
              ),
              _buildSettingsItem(
                Icons.feedback_outlined,
                'Send Feedback',
                'Share your thoughts with us',
                () => _showComingSoon(context, 'Send Feedback'),
              ),
              _buildSettingsItem(
                Icons.info_outline,
                'About',
                'App version and information',
                () => _showAbout(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            'Account Actions',
            [
              _buildSettingsItem(
                Icons.logout,
                'Sign Out',
                'Sign out of your account',
                () => _signOut(context),
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon'),
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Synergetics Manager',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text(
              'A comprehensive management application for Synergetics platform.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              foregroundColor: Colors.red,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}