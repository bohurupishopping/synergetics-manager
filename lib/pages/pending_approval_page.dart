// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../models/enums.dart';
import '../models/profile.dart';
import '../utils/app_router.dart';

class PendingApprovalPage extends StatefulWidget {
  const PendingApprovalPage({super.key});

  @override
  State<PendingApprovalPage> createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _refreshStatus() {
    context.read<AuthCubit>().refreshUserData();
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
          authenticated: (user, profile, kyc) {
            if (kyc?.status == KycStatus.approved) {
              // KYC approved, navigate to dashboard
              context.goToDashboard();
            } else if (kyc?.status == KycStatus.rejected) {
              // KYC rejected, navigate back to KYC flow
              context.goToKyc();
            }
          },
          unauthenticated: () {
            context.goToLogin();
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Application Status'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshStatus,
              tooltip: 'Refresh Status',
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'refresh',
                  child: Row(
                    children: [
                      Icon(Icons.refresh, size: 18),
                      SizedBox(width: 8),
                      Text('Refresh Status'),
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
                if (value == 'refresh') {
                  _refreshStatus();
                } else if (value == 'signout') {
                  _signOut();
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
                return _buildContent(context, kyc);
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
                      onPressed: _refreshStatus,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileKyc? kyc) {
    if (kyc == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              'No KYC Data Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please complete your KYC application',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.goToKyc(),
              child: const Text('Complete KYC'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          
          // Status Icon with Animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _getStatusColor(kyc.status).withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getStatusColor(kyc.status),
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    _getStatusIcon(kyc.status),
                    size: 60,
                    color: _getStatusColor(kyc.status),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          
          // Status Title
          Text(
            _getStatusTitle(kyc.status),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getStatusColor(kyc.status),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Status Description
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    _getStatusDescription(kyc.status),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  // Timeline
                  _buildTimeline(kyc),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons
          _buildActionButtons(context, kyc.status),
          const SizedBox(height: 32),
          
          // Contact Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Need Help?',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'If you have any questions about your application status, '
                    'please contact our support team.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement contact support
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact support feature coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Contact Support'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(ProfileKyc kyc) {
    return Column(
      children: [
        _buildTimelineItem(
          'Application Submitted',
          kyc.createdAt,
          true,
          Icons.check_circle,
          Colors.green,
        ),
        _buildTimelineItem(
          'Under Review',
          null,
          kyc.status == KycStatus.pendingReview,
          Icons.hourglass_empty,
          Colors.orange,
        ),
        _buildTimelineItem(
          'Approved',
          kyc.status == KycStatus.approved ? kyc.updatedAt : null,
          kyc.status == KycStatus.approved,
          Icons.verified,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    DateTime? date,
    bool isActive,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? Colors.black87 : Colors.grey[600],
                ),
              ),
              if (date != null)
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, KycStatus status) {
    switch (status) {
      case KycStatus.pendingReview:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _refreshStatus,
                icon: const Icon(Icons.refresh),
                label: const Text('Check Status'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        );
      case KycStatus.rejected:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.goToKyc(),
                icon: const Icon(Icons.edit),
                label: const Text('Resubmit Application'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Color _getStatusColor(KycStatus status) {
    switch (status) {
      case KycStatus.pendingReview:
        return Colors.orange;
      case KycStatus.approved:
        return Colors.green;
      case KycStatus.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(KycStatus status) {
    switch (status) {
      case KycStatus.pendingReview:
        return Icons.hourglass_empty;
      case KycStatus.approved:
        return Icons.verified;
      case KycStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusTitle(KycStatus status) {
    switch (status) {
      case KycStatus.pendingReview:
        return 'Under Review';
      case KycStatus.approved:
        return 'Approved';
      case KycStatus.rejected:
        return 'Rejected';
      default:
        return 'Unknown Status';
    }
  }

  String _getStatusDescription(KycStatus status) {
    switch (status) {
      case KycStatus.pendingReview:
        return 'Your KYC application has been submitted successfully and is currently under review. '
            'Our team will verify your information and get back to you within 2-3 business days.';
      case KycStatus.approved:
        return 'Congratulations! Your KYC application has been approved. '
            'You now have full access to all features of the application.';
      case KycStatus.rejected:
        return 'Your KYC application has been rejected. '
            'Please review the feedback and resubmit your application with the correct information.';
      default:
        return 'Unable to determine the current status of your application.';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}