import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../models/auth_state.dart';
import '../models/enums.dart';
import '../utils/ui_constants.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.whenOrNull(
          authenticated: (user, profile, kyc) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(UIConstants.largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: UIConstants.primaryGradient,
                      borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
                      boxShadow: UIConstants.elevatedShadow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(UIConstants.extraLargePadding),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(UIConstants.extraLargeRadius),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _getInitials(profile.fullName ?? user.email ?? 'U'),
                                style: UIConstants.headingLarge.copyWith(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: UIConstants.largeSpacing),
                          Text(
                            profile.fullName ?? 'User',
                            style: UIConstants.headingLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: UIConstants.smallSpacing),
                          Text(
                            user.email ?? '',
                            style: UIConstants.bodyLarge.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          const SizedBox(height: UIConstants.mediumSpacing),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: UIConstants.largePadding,
                              vertical: UIConstants.mediumPadding,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
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
                                  Icons.verified_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: UIConstants.smallSpacing),
                                Text(
                                  profile.appRole.displayName,
                                  style: UIConstants.bodyMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
                  
                  // Profile Information Section
                  Text(
                    'Profile Information',
                    style: UIConstants.headingMedium,
                  ),
                  const SizedBox(height: UIConstants.largeSpacing),
                  
                  _buildInfoCard(
                    'Personal Details',
                    [
                      _buildInfoRow('Full Name', profile.fullName ?? 'Not provided'),
                      _buildInfoRow('Email', user.email ?? 'Not provided'),
                      _buildInfoRow('Phone', profile.phoneNumber ?? 'Not provided'),
                      _buildInfoRow('Role', profile.appRole.displayName),
                    ],
                  ),
                  
                  const SizedBox(height: UIConstants.largeSpacing),
                  
                  if (kyc != null) ...[
                    _buildInfoCard(
                      'KYC Information',
                      [
                        _buildInfoRow('Status', kyc.status.displayName),
                        _buildInfoRow('Legal Name', kyc.legalFullName ?? 'Not provided'),
                        _buildInfoRow('PAN Number', kyc.panCardNumber ?? 'Not provided'),
                        _buildInfoRow('Aadhar Number', kyc.aadharCardNumber ?? 'Not provided'),
                        _buildInfoRow('Address', kyc.address != null ? '${kyc.address!.street}, ${kyc.address!.city}, ${kyc.address!.state} ${kyc.address!.zipCode}' : 'Not provided'),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ) ?? const Center(
          child: Text('No profile data available'),
        );
      },
    );
  }
  
  Widget _buildInfoCard(String title, List<Widget> children) {
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
      child: Padding(
        padding: const EdgeInsets.all(UIConstants.extraLargePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: UIConstants.headingSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: UIConstants.largeSpacing),
            ...children,
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: UIConstants.mediumSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: UIConstants.bodyMedium.copyWith(
                color: UIConstants.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: UIConstants.mediumSpacing),
          Expanded(
            child: Text(
              value,
              style: UIConstants.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words[0].substring(0, 1)}${words[1].substring(0, 1)}'.toUpperCase();
  }
}