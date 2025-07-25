import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile.dart';
import 'enums.dart';

part 'auth_state.freezed.dart';

/// Authentication state for the app
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated({
    required User user,
    required Profile profile,
    ProfileKyc? kyc,
  }) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}

/// KYC flow state
@freezed
class KycFlowState with _$KycFlowState {
  const factory KycFlowState.initial() = _KycInitial;
  const factory KycFlowState.loading() = _KycLoading;
  const factory KycFlowState.personalInfo() = _PersonalInfo;
  const factory KycFlowState.documents() = _Documents;
  const factory KycFlowState.references() = _References;
  const factory KycFlowState.review() = _Review;
  const factory KycFlowState.submitting() = _Submitting;
  const factory KycFlowState.submitted() = _Submitted;
  const factory KycFlowState.error(String message) = _KycError;
}

/// KYC form data model
@freezed
abstract class KycFormData with _$KycFormData {
  const factory KycFormData({
    // Personal Information
    String? legalFullName,
    String? email,
    String? phoneNumber,
    
    // Address
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    
    // Documents
    String? panCardNumber,
    String? aadharCardNumber,
    
    // References
    List<ProfileReference>? references,
  }) = _KycFormData;
  
  const KycFormData._();
  
  /// Convert to ProfileKyc for submission
  ProfileKyc toProfileKyc(String profileId) {
    return ProfileKyc(
      id: '', // Will be generated by database
      profileId: profileId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: KycStatus.pendingReview,
      legalFullName: legalFullName,
      email: email,
      phoneNumber: phoneNumber,
      panCardNumber: panCardNumber,
      aadharCardNumber: aadharCardNumber,
      address: (street != null && city != null && state != null && zipCode != null)
          ? Address(
              street: street!,
              city: city!,
              state: state!,
              zipCode: zipCode!,
              country: country ?? 'India',
            )
          : null,
    );
  }
}