// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  fullName: json['full_name'] as String?,
  phoneNumber: json['phone_number'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  appRole: $enumDecode(_$AppRoleEnumMap, json['role']),
  companyId: json['company_id'] as String?,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'full_name': instance.fullName,
  'phone_number': instance.phoneNumber,
  'avatar_url': instance.avatarUrl,
  'role': _$AppRoleEnumMap[instance.appRole]!,
  'company_id': instance.companyId,
};

const _$AppRoleEnumMap = {
  AppRole.admin: 'admin',
  AppRole.manager: 'manager',
  AppRole.user: 'user',
};

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  street: json['street'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  zipCode: json['zip_code'] as String,
  country: json['country'] as String?,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zip_code': instance.zipCode,
  'country': instance.country,
};

_ProfileKyc _$ProfileKycFromJson(Map<String, dynamic> json) => _ProfileKyc(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  status: $enumDecode(_$KycStatusEnumMap, json['status']),
  legalFullName: json['legal_full_name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  panCardNumber: json['pan_card_number'] as String?,
  aadharCardNumber: json['aadhar_card_number'] as String?,
  address: json['address'] == null
      ? null
      : Address.fromJson(json['address'] as Map<String, dynamic>),
  rejectionReason: json['rejection_reason'] as String?,
);

Map<String, dynamic> _$ProfileKycToJson(_ProfileKyc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'status': _$KycStatusEnumMap[instance.status]!,
      'legal_full_name': instance.legalFullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'pan_card_number': instance.panCardNumber,
      'aadhar_card_number': instance.aadharCardNumber,
      'address': instance.address,
      'rejection_reason': instance.rejectionReason,
    };

const _$KycStatusEnumMap = {
  KycStatus.notSubmitted: 'not_submitted',
  KycStatus.pendingReview: 'pending_review',
  KycStatus.approved: 'approved',
  KycStatus.rejected: 'rejected',
};

_ProfileReference _$ProfileReferenceFromJson(Map<String, dynamic> json) =>
    _ProfileReference(
      id: json['id'] as String,
      kycId: json['kyc_id'] as String,
      referenceType: json['reference_type'] as String,
      fullName: json['full_name'] as String,
      relationship: json['relationship'] as String?,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileReferenceToJson(_ProfileReference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kyc_id': instance.kycId,
      'reference_type': instance.referenceType,
      'full_name': instance.fullName,
      'relationship': instance.relationship,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };
