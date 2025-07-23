import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/kyc_cubit.dart';
import '../../utils/validators.dart';

class DocumentsStep extends StatefulWidget {
  const DocumentsStep({super.key});

  @override
  State<DocumentsStep> createState() => _DocumentsStepState();
}

class _DocumentsStepState extends State<DocumentsStep> {
  final _formKey = GlobalKey<FormState>();
  final _panController = TextEditingController();
  final _aadharController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    final formData = context.read<KycCubit>().formData;
    _panController.text = formData.panCardNumber ?? '';
    _aadharController.text = formData.aadharCardNumber ?? '';
  }

  @override
  void dispose() {
    _panController.dispose();
    _aadharController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final kycCubit = context.read<KycCubit>();
      
      // Update documents
      kycCubit.updateDocuments(
        panCardNumber: _panController.text.trim().toUpperCase(),
        aadharCardNumber: _aadharController.text.trim(),
      );
      
      // Navigate to next step
      kycCubit.goToReferences();
    }
  }

  void _goBack() {
    context.read<KycCubit>().goToPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
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
                          Icons.description_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Document Information',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please provide your document details for identity verification.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // PAN Card Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'PAN Card Details',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _panController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'PAN Card Number *',
                        hintText: 'ABCDE1234F',
                        prefixIcon: Icon(Icons.credit_card),
                        helperText: 'Enter 10-character PAN number',
                      ),
                      validator: Validators.validatePanCard,
                      onChanged: (value) {
                        // Auto-format PAN to uppercase
                        final upperValue = value.toUpperCase();
                        if (upperValue != value) {
                          _panController.value = _panController.value.copyWith(
                            text: upperValue,
                            selection: TextSelection.collapsed(
                              offset: upperValue.length,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    
                    // PAN Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'PAN format: 5 letters, 4 digits, 1 letter (e.g., ABCDE1234F)',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Aadhar Card Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Aadhar Card Details',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _aadharController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Aadhar Card Number *',
                        hintText: '1234 5678 9012',
                        prefixIcon: Icon(Icons.badge),
                        helperText: 'Enter 12-digit Aadhar number',
                      ),
                      validator: Validators.validateAadharCard,
                      onChanged: (value) {
                        // Auto-format Aadhar with spaces
                        final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                        String formatted = '';
                        for (int i = 0; i < digitsOnly.length; i++) {
                          if (i > 0 && i % 4 == 0) {
                            formatted += ' ';
                          }
                          formatted += digitsOnly[i];
                        }
                        
                        if (formatted != value) {
                          _aadharController.value = _aadharController.value.copyWith(
                            text: formatted,
                            selection: TextSelection.collapsed(
                              offset: formatted.length,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    
                    // Aadhar Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.security,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your Aadhar information is encrypted and stored securely.',
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 12,
                              ),
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
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _goBack,
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
                    onPressed: _saveAndContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Continue to References',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Required fields note
            Text(
              '* Required fields',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}