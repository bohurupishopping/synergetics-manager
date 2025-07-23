import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../models/auth_state.dart';
import '../models/profile.dart';
import '../services/supabase_service.dart';

class KycCubit extends Cubit<KycFlowState> {
  KycCubit(this._supabaseService) : super(const KycFlowState.initial());

  final SupabaseService _supabaseService;
  final _logger = Logger();
  
  KycFormData _formData = const KycFormData();
  KycFormData get formData => _formData;

  /// Start KYC flow
  void startKycFlow() {
    _logger.i('Starting KYC flow');
    emit(const KycFlowState.personalInfo());
  }

  /// Update personal information
  void updatePersonalInfo({
    String? legalFullName,
    String? email,
    String? phoneNumber,
  }) {
    _formData = _formData.copyWith(
      legalFullName: legalFullName,
      email: email,
      phoneNumber: phoneNumber,
    );
    _logger.d('Updated personal info: ${_formData.legalFullName}');
  }

  /// Update address information
  void updateAddress({
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) {
    _formData = _formData.copyWith(
      street: street,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
    );
    _logger.d('Updated address: ${_formData.city}, ${_formData.state}');
  }

  /// Update document information
  void updateDocuments({
    String? panCardNumber,
    String? aadharCardNumber,
  }) {
    _formData = _formData.copyWith(
      panCardNumber: panCardNumber,
      aadharCardNumber: aadharCardNumber,
    );
    _logger.d('Updated documents');
  }

  /// Add reference
  void addReference(ProfileReference reference) {
    final currentReferences = _formData.references ?? [];
    final updatedReferences = [...currentReferences, reference];
    
    _formData = _formData.copyWith(references: updatedReferences);
    _logger.d('Added reference: ${reference.fullName}');
  }

  /// Remove reference
  void removeReference(int index) {
    final currentReferences = _formData.references ?? [];
    if (index >= 0 && index < currentReferences.length) {
      final updatedReferences = [...currentReferences];
      updatedReferences.removeAt(index);
      
      _formData = _formData.copyWith(references: updatedReferences);
      _logger.d('Removed reference at index: $index');
    }
  }

  /// Navigate to personal info step
  void goToPersonalInfo() {
    emit(const KycFlowState.personalInfo());
  }

  /// Navigate to documents step
  void goToDocuments() {
    if (_isPersonalInfoValid()) {
      emit(const KycFlowState.documents());
    } else {
      emit(const KycFlowState.error('Please complete personal information first'));
    }
  }

  /// Navigate to references step
  void goToReferences() {
    if (_isDocumentsValid()) {
      emit(const KycFlowState.references());
    } else {
      emit(const KycFlowState.error('Please complete document information first'));
    }
  }

  /// Navigate to review step
  void goToReview() {
    if (_isReferencesValid()) {
      emit(const KycFlowState.review());
    } else {
      emit(const KycFlowState.error('Please add at least one reference'));
    }
  }

  /// Submit KYC data
  Future<void> submitKyc() async {
    try {
      emit(const KycFlowState.submitting());
      
      final user = _supabaseService.currentUser;
      if (user == null) {
        emit(const KycFlowState.error('User not authenticated'));
        return;
      }

      if (!_isFormValid()) {
        emit(const KycFlowState.error('Please complete all required fields'));
        return;
      }

      _logger.i('Submitting KYC data for user: ${user.id}');
      
      // Submit KYC data
      final kyc = _formData.toProfileKyc(user.id);
      final submittedKyc = await _supabaseService.submitKyc(kyc);
      
      // Submit references if any
      if (_formData.references != null && _formData.references!.isNotEmpty) {
        await _supabaseService.submitReferences(
          submittedKyc.id,
          _formData.references!,
        );
      }
      
      _logger.i('KYC submission completed successfully');
      emit(const KycFlowState.submitted());
      
    } catch (e) {
      _logger.e('KYC submission failed: $e');
      emit(KycFlowState.error('Failed to submit KYC data: ${e.toString()}'));
    }
  }

  /// Reset KYC flow
  void resetFlow() {
    _formData = const KycFormData();
    emit(const KycFlowState.initial());
  }

  /// Clear error state
  void clearError() {
    emit(const KycFlowState.personalInfo());
  }

  /// Validation methods
  bool _isPersonalInfoValid() {
    return _formData.legalFullName?.isNotEmpty == true &&
           _formData.email?.isNotEmpty == true &&
           _formData.phoneNumber?.isNotEmpty == true &&
           _formData.street?.isNotEmpty == true &&
           _formData.city?.isNotEmpty == true &&
           _formData.state?.isNotEmpty == true &&
           _formData.zipCode?.isNotEmpty == true;
  }

  bool _isDocumentsValid() {
    return _isPersonalInfoValid() &&
           _formData.panCardNumber?.isNotEmpty == true &&
           _formData.aadharCardNumber?.isNotEmpty == true;
  }

  bool _isReferencesValid() {
    return _isDocumentsValid() &&
           _formData.references != null &&
           _formData.references!.isNotEmpty;
  }

  bool _isFormValid() {
    return _isReferencesValid();
  }

  /// Get current step index for progress indicator
  int getCurrentStepIndex() {
    return state.when(
      initial: () => 0,
      loading: () => 0,
      personalInfo: () => 0,
      documents: () => 1,
      references: () => 2,
      review: () => 3,
      submitting: () => 3,
      submitted: () => 4,
      error: (_) => 0,
    );
  }
}