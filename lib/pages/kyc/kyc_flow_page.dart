import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/kyc_cubit.dart';
import '../../models/auth_state.dart';
import '../../utils/app_router.dart';
import 'personal_info_step.dart';
import 'documents_step.dart';
import 'references_step.dart';
import 'review_step.dart';

class KycFlowPage extends StatefulWidget {
  const KycFlowPage({super.key});

  @override
  State<KycFlowPage> createState() => _KycFlowPageState();
}

class _KycFlowPageState extends State<KycFlowPage> {
  @override
  void initState() {
    super.initState();
    // Start the KYC flow when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KycCubit>().startKycFlow();
    });
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

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
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
    return BlocListener<KycCubit, KycFlowState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          personalInfo: () {},
          documents: () {},
          references: () {},
          review: () {},
          submitting: () {},
          submitted: () {
            _showSuccessSnackBar('KYC submitted successfully!');
            // Navigate to pending approval page
            context.goToPending();
          },
          error: (message) {
            _showErrorSnackBar(message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Complete Your Profile'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Show confirmation dialog before leaving
              _showExitConfirmationDialog();
            },
          ),
        ),
        body: Column(
          children: [
            // Progress Indicator
            BlocBuilder<KycCubit, KycFlowState>(
              builder: (context, state) {
                final currentStep = context.read<KycCubit>().getCurrentStepIndex();
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (currentStep + 1) / 4,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Step ${currentStep + 1} of 4',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            _getStepTitle(currentStep),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            
            // Step Content
            Expanded(
              child: BlocBuilder<KycCubit, KycFlowState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    personalInfo: () => const PersonalInfoStep(),
                    documents: () => const DocumentsStep(),
                    references: () => const ReferencesStep(),
                    review: () => const ReviewStep(),
                    submitting: () => const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Submitting your information...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    submitted: () => const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 64,
                            color: Colors.green,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'KYC Submitted Successfully!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.red,
                            ),
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
                            onPressed: () {
                              context.read<KycCubit>().clearError();
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Personal Information';
      case 1:
        return 'Documents';
      case 2:
        return 'References';
      case 3:
        return 'Review & Submit';
      default:
        return '';
    }
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit KYC Process?'),
        content: const Text(
          'Your progress will be lost if you exit now. Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.goToDashboard();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}