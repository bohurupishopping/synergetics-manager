import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/kyc_cubit.dart';
import '../../models/auth_state.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  void _submitKyc(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit KYC Information'),
        content: const Text(
          'Are you sure you want to submit your KYC information? '
          'You will not be able to edit this information once submitted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<KycCubit>().submitKyc();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {
    context.read<KycCubit>().goToReferences();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycFlowState>(
      builder: (context, state) {
        final formData = context.read<KycCubit>().formData;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.preview_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Review Your Information',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please review all the information below before submitting your KYC application.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Personal Information Section
              _buildSection(
                context,
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [
                  _buildInfoRow('Full Name', formData.legalFullName ?? 'Not provided'),
                  _buildInfoRow('Email', formData.email ?? 'Not provided'),
                  _buildInfoRow('Phone', formData.phoneNumber ?? 'Not provided'),
                ],
                onEdit: () => context.read<KycCubit>().goToPersonalInfo(),
              ),
              const SizedBox(height: 16),
              
              // Address Section
              _buildSection(
                context,
                title: 'Address Information',
                icon: Icons.home_outlined,
                children: [
                  _buildInfoRow('Street', formData.street ?? 'Not provided'),
                  _buildInfoRow('City', formData.city ?? 'Not provided'),
                  _buildInfoRow('State', formData.state ?? 'Not provided'),
                  _buildInfoRow('ZIP Code', formData.zipCode ?? 'Not provided'),
                  _buildInfoRow('Country', formData.country ?? 'Not provided'),
                ],
                onEdit: () => context.read<KycCubit>().goToPersonalInfo(),
              ),
              const SizedBox(height: 16),
              
              // Documents Section
              _buildSection(
                context,
                title: 'Document Information',
                icon: Icons.description_outlined,
                children: [
                  _buildInfoRow('PAN Card', _maskPanCard(formData.panCardNumber)),
                  _buildInfoRow('Aadhar Card', _maskAadharCard(formData.aadharCardNumber)),
                ],
                onEdit: () => context.read<KycCubit>().goToDocuments(),
              ),
              const SizedBox(height: 16),
              
              // References Section
              _buildSection(
                context,
                title: 'Professional References',
                icon: Icons.people_outline,
                children: [
                  if (formData.references?.isEmpty ?? true)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'No references added',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    ...formData.references!.asMap().entries.map((entry) {
                      final index = entry.key;
                      final reference = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ${reference.fullName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Relationship: ${reference.relationship}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Phone: ${reference.phoneNumber}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
                onEdit: () => context.read<KycCubit>().goToReferences(),
              ),
              const SizedBox(height: 24),
              
              // Important Notice
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.amber[700],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Important Notice',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Once submitted, your KYC information cannot be modified. '
                            'Please ensure all details are correct before proceeding.',
                            style: TextStyle(
                              color: Colors.amber[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _goBack(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => _submitKyc(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Submit KYC',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
    required VoidCallback onEdit,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
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

  String _maskPanCard(String? panCard) {
    if (panCard == null || panCard.isEmpty) {
      return 'Not provided';
    }
    if (panCard.length >= 6) {
      return '${panCard.substring(0, 3)}***${panCard.substring(panCard.length - 2)}';
    }
    return panCard;
  }

  String _maskAadharCard(String? aadharCard) {
    if (aadharCard == null || aadharCard.isEmpty) {
      return 'Not provided';
    }
    final digitsOnly = aadharCard.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length >= 8) {
      return '****-****-${digitsOnly.substring(digitsOnly.length - 4)}';
    }
    return aadharCard;
  }
}