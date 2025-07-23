import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// User profile model matching the profiles table
@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'role') required AppRole appRole,
    @JsonKey(name: 'company_id') String? companyId,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => 
      _$ProfileFromJson(json);
}

/// Address model for KYC data
@freezed
abstract class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String state,
    @JsonKey(name: 'zip_code') required String zipCode,
    String? country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => 
      _$AddressFromJson(json);
}

/// Profile KYC model matching the profile_kyc table
@freezed
abstract class ProfileKyc with _$ProfileKyc {
  const factory ProfileKyc({
    required String id,
    @JsonKey(name: 'profile_id') required String profileId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required KycStatus status,
    @JsonKey(name: 'legal_full_name') String? legalFullName,
    String? email,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'pan_card_number') String? panCardNumber,
    @JsonKey(name: 'aadhar_card_number') String? aadharCardNumber,
    Address? address,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
  }) = _ProfileKyc;

  factory ProfileKyc.fromJson(Map<String, dynamic> json) => 
      _$ProfileKycFromJson(json);
}

/// Profile reference model matching the profile_references table
@freezed
abstract class ProfileReference with _$ProfileReference {
  const factory ProfileReference({
    required String id,
    @JsonKey(name: 'kyc_id') required String kycId,
    @JsonKey(name: 'reference_type') required String referenceType,
    @JsonKey(name: 'full_name') required String fullName,
    String? relationship,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    Address? address,
  }) = _ProfileReference;

  factory ProfileReference.fromJson(Map<String, dynamic> json) => 
      _$ProfileReferenceFromJson(json);
}