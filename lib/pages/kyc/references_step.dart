import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/kyc_cubit.dart';
import '../../models/auth_state.dart';
import '../../models/profile.dart';
import '../../utils/validators.dart';

class ReferencesStep extends StatefulWidget {
  const ReferencesStep({super.key});

  @override
  State<ReferencesStep> createState() => _ReferencesStepState();
}

class _ReferencesStepState extends State<ReferencesStep> {
  void _addReference() {
    showDialog(
      context: context,
      builder: (context) => const AddReferenceDialog(),
    );
  }

  void _editReference(int index, ProfileReference reference) {
    showDialog(
      context: context,
      builder: (context) => AddReferenceDialog(
        reference: reference,
        index: index,
      ),
    );
  }

  void _removeReference(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Reference'),
        content: const Text('Are you sure you want to remove this reference?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<KycCubit>().removeReference(index);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _saveAndContinue() {
    final references = context.read<KycCubit>().formData.references;
    if (references == null || references.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one reference'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    context.read<KycCubit>().goToReview();
  }

  void _goBack() {
    context.read<KycCubit>().goToDocuments();
  }

  @override
  Widget build(BuildContext context) {
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
                        Icons.people_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Professional References',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add at least one professional reference who can vouch for your identity and work.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // References List
          BlocBuilder<KycCubit, KycFlowState>(
            builder: (context, state) {
              final references = context.read<KycCubit>().formData.references ?? [];
              
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'References (${references.length})',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _addReference,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Reference'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      if (references.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No references added yet',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add at least one professional reference to continue',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _addReference,
                                icon: const Icon(Icons.add),
                                label: const Text('Add First Reference'),
                              ),
                            ],
                          ),
                        )
                      else
                        ...references.asMap().entries.map((entry) {
                          final index = entry.key;
                          final reference = entry.value;
                          
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                child: Text(
                                  reference.fullName.isNotEmpty
                                      ? reference.fullName[0].toUpperCase()
                                      : 'R',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                reference.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reference.relationship ?? 'No relationship specified'),
                                  Text(
                                    reference.phoneNumber,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: const Row(
                                      children: [
                                        Icon(Icons.edit, size: 18),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: const Row(
                                      children: [
                                        Icon(Icons.delete, size: 18, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _editReference(index, reference);
                                  } else if (value == 'delete') {
                                    _removeReference(index);
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              );
            },
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
                    'Review & Submit',
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
  }
}

class AddReferenceDialog extends StatefulWidget {
  const AddReferenceDialog({
    super.key,
    this.reference,
    this.index,
  });

  final ProfileReference? reference;
  final int? index;

  @override
  State<AddReferenceDialog> createState() => _AddReferenceDialogState();
}

class _AddReferenceDialogState extends State<AddReferenceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.reference != null) {
      _nameController.text = widget.reference!.fullName;
      _relationshipController.text = widget.reference!.relationship ?? '';
      _phoneController.text = widget.reference!.phoneNumber;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveReference() {
    if (_formKey.currentState?.validate() ?? false) {
      final reference = ProfileReference(
        id: widget.reference?.id ?? '',
        kycId: widget.reference?.kycId ?? '',
        referenceType: widget.reference?.referenceType ?? 'professional',
        fullName: _nameController.text.trim(),
        relationship: _relationshipController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );

      if (widget.index != null) {
        // Update existing reference
        context.read<KycCubit>().removeReference(widget.index!);
        context.read<KycCubit>().addReference(reference);
      } else {
        // Add new reference
        context.read<KycCubit>().addReference(reference);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.reference != null ? 'Edit Reference' : 'Add Reference'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter reference full name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => Validators.validateName(value, 'Full Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _relationshipController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Relationship *',
                  hintText: 'e.g., Manager, Colleague, Client',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) => Validators.validateRequired(value, 'Relationship'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'Enter phone number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: Validators.validatePhoneNumber,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveReference,
          child: Text(widget.reference != null ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}