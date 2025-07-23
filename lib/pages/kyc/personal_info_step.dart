import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/kyc_cubit.dart';
import '../../utils/validators.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _countryController = TextEditingController(text: 'India');

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    final formData = context.read<KycCubit>().formData;
    _nameController.text = formData.legalFullName ?? '';
    _emailController.text = formData.email ?? '';
    _phoneController.text = formData.phoneNumber ?? '';
    _streetController.text = formData.street ?? '';
    _cityController.text = formData.city ?? '';
    _stateController.text = formData.state ?? '';
    _zipController.text = formData.zipCode ?? '';
    _countryController.text = formData.country ?? 'India';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final kycCubit = context.read<KycCubit>();
      
      // Update personal information
      kycCubit.updatePersonalInfo(
        legalFullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );
      
      // Update address
      kycCubit.updateAddress(
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _zipController.text.trim(),
        country: _countryController.text.trim(),
      );
      
      // Navigate to next step
      kycCubit.goToDocuments();
    }
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
                          Icons.person_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please provide your personal details as they appear on your official documents.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Personal Details Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Full Name
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Legal Full Name *',
                        hintText: 'Enter your full name as per documents',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => Validators.validateName(value, 'Full Name'),
                    ),
                    const SizedBox(height: 16),
                    
                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address *',
                        hintText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    
                    // Phone
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number *',
                        hintText: 'Enter your phone number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: Validators.validatePhoneNumber,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Address Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Street Address
                    TextFormField(
                      controller: _streetController,
                      textCapitalization: TextCapitalization.words,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Street Address *',
                        hintText: 'Enter your complete street address',
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: Validators.validateAddress,
                    ),
                    const SizedBox(height: 16),
                    
                    // City and State
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cityController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'City *',
                              hintText: 'Enter city',
                              prefixIcon: Icon(Icons.location_city),
                            ),
                            validator: (value) => Validators.validateRequired(value, 'City'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _stateController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'State *',
                              hintText: 'Enter state',
                              prefixIcon: Icon(Icons.map),
                            ),
                            validator: (value) => Validators.validateRequired(value, 'State'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // ZIP and Country
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _zipController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ZIP Code *',
                              hintText: 'Enter ZIP code',
                              prefixIcon: Icon(Icons.local_post_office),
                            ),
                            validator: Validators.validateZipCode,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _countryController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Country *',
                              hintText: 'Enter country',
                              prefixIcon: Icon(Icons.public),
                            ),
                            validator: (value) => Validators.validateRequired(value, 'Country'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Continue Button
            ElevatedButton(
              onPressed: _saveAndContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Continue to Documents',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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