// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get id;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'full_name') String? get fullName;@JsonKey(name: 'phone_number') String? get phoneNumber;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'role') AppRole get appRole;@JsonKey(name: 'company_id') String? get companyId;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.appRole, appRole) || other.appRole == appRole)&&(identical(other.companyId, companyId) || other.companyId == companyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,updatedAt,fullName,phoneNumber,avatarUrl,appRole,companyId);

@override
String toString() {
  return 'Profile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, fullName: $fullName, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, appRole: $appRole, companyId: $companyId)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'full_name') String? fullName,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'role') AppRole appRole,@JsonKey(name: 'company_id') String? companyId
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? updatedAt = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? avatarUrl = freezed,Object? appRole = null,Object? companyId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,appRole: null == appRole ? _self.appRole : appRole // ignore: cast_nullable_to_non_nullable
as AppRole,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'role')  AppRole appRole, @JsonKey(name: 'company_id')  String? companyId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.avatarUrl,_that.appRole,_that.companyId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'role')  AppRole appRole, @JsonKey(name: 'company_id')  String? companyId)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.avatarUrl,_that.appRole,_that.companyId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'full_name')  String? fullName, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'role')  AppRole appRole, @JsonKey(name: 'company_id')  String? companyId)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.avatarUrl,_that.appRole,_that.companyId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'full_name') this.fullName, @JsonKey(name: 'phone_number') this.phoneNumber, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'role') required this.appRole, @JsonKey(name: 'company_id') this.companyId});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'full_name') final  String? fullName;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'role') final  AppRole appRole;
@override@JsonKey(name: 'company_id') final  String? companyId;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.appRole, appRole) || other.appRole == appRole)&&(identical(other.companyId, companyId) || other.companyId == companyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,updatedAt,fullName,phoneNumber,avatarUrl,appRole,companyId);

@override
String toString() {
  return 'Profile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, fullName: $fullName, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, appRole: $appRole, companyId: $companyId)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'full_name') String? fullName,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'role') AppRole appRole,@JsonKey(name: 'company_id') String? companyId
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? updatedAt = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? avatarUrl = freezed,Object? appRole = null,Object? companyId = freezed,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,appRole: null == appRole ? _self.appRole : appRole // ignore: cast_nullable_to_non_nullable
as AppRole,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Address {

 String get street; String get city; String get state;@JsonKey(name: 'zip_code') String get zipCode; String? get country;
/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressCopyWith<Address> get copyWith => _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Address&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,street,city,state,zipCode,country);

@override
String toString() {
  return 'Address(street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country)';
}


}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res>  {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) = _$AddressCopyWithImpl;
@useResult
$Res call({
 String street, String city, String state,@JsonKey(name: 'zip_code') String zipCode, String? country
});




}
/// @nodoc
class _$AddressCopyWithImpl<$Res>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? street = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? country = freezed,}) {
  return _then(_self.copyWith(
street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Address value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Address value)  $default,){
final _that = this;
switch (_that) {
case _Address():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Address value)?  $default,){
final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String street,  String city,  String state, @JsonKey(name: 'zip_code')  String zipCode,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.street,_that.city,_that.state,_that.zipCode,_that.country);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String street,  String city,  String state, @JsonKey(name: 'zip_code')  String zipCode,  String? country)  $default,) {final _that = this;
switch (_that) {
case _Address():
return $default(_that.street,_that.city,_that.state,_that.zipCode,_that.country);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String street,  String city,  String state, @JsonKey(name: 'zip_code')  String zipCode,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.street,_that.city,_that.state,_that.zipCode,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Address implements Address {
  const _Address({required this.street, required this.city, required this.state, @JsonKey(name: 'zip_code') required this.zipCode, this.country});
  factory _Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

@override final  String street;
@override final  String city;
@override final  String state;
@override@JsonKey(name: 'zip_code') final  String zipCode;
@override final  String? country;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressCopyWith<_Address> get copyWith => __$AddressCopyWithImpl<_Address>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Address&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,street,city,state,zipCode,country);

@override
String toString() {
  return 'Address(street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country)';
}


}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) = __$AddressCopyWithImpl;
@override @useResult
$Res call({
 String street, String city, String state,@JsonKey(name: 'zip_code') String zipCode, String? country
});




}
/// @nodoc
class __$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? street = null,Object? city = null,Object? state = null,Object? zipCode = null,Object? country = freezed,}) {
  return _then(_Address(
street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfileKyc {

 String get id;@JsonKey(name: 'profile_id') String get profileId;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; KycStatus get status;@JsonKey(name: 'legal_full_name') String? get legalFullName; String? get email;@JsonKey(name: 'phone_number') String? get phoneNumber;@JsonKey(name: 'pan_card_number') String? get panCardNumber;@JsonKey(name: 'aadhar_card_number') String? get aadharCardNumber; Address? get address;@JsonKey(name: 'rejection_reason') String? get rejectionReason;
/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileKycCopyWith<ProfileKyc> get copyWith => _$ProfileKycCopyWithImpl<ProfileKyc>(this as ProfileKyc, _$identity);

  /// Serializes this ProfileKyc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileKyc&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.legalFullName, legalFullName) || other.legalFullName == legalFullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.panCardNumber, panCardNumber) || other.panCardNumber == panCardNumber)&&(identical(other.aadharCardNumber, aadharCardNumber) || other.aadharCardNumber == aadharCardNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,createdAt,updatedAt,status,legalFullName,email,phoneNumber,panCardNumber,aadharCardNumber,address,rejectionReason);

@override
String toString() {
  return 'ProfileKyc(id: $id, profileId: $profileId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, legalFullName: $legalFullName, email: $email, phoneNumber: $phoneNumber, panCardNumber: $panCardNumber, aadharCardNumber: $aadharCardNumber, address: $address, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $ProfileKycCopyWith<$Res>  {
  factory $ProfileKycCopyWith(ProfileKyc value, $Res Function(ProfileKyc) _then) = _$ProfileKycCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, KycStatus status,@JsonKey(name: 'legal_full_name') String? legalFullName, String? email,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'pan_card_number') String? panCardNumber,@JsonKey(name: 'aadhar_card_number') String? aadharCardNumber, Address? address,@JsonKey(name: 'rejection_reason') String? rejectionReason
});


$AddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$ProfileKycCopyWithImpl<$Res>
    implements $ProfileKycCopyWith<$Res> {
  _$ProfileKycCopyWithImpl(this._self, this._then);

  final ProfileKyc _self;
  final $Res Function(ProfileKyc) _then;

/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? legalFullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? panCardNumber = freezed,Object? aadharCardNumber = freezed,Object? address = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycStatus,legalFullName: freezed == legalFullName ? _self.legalFullName : legalFullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,panCardNumber: freezed == panCardNumber ? _self.panCardNumber : panCardNumber // ignore: cast_nullable_to_non_nullable
as String?,aadharCardNumber: freezed == aadharCardNumber ? _self.aadharCardNumber : aadharCardNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileKyc].
extension ProfileKycPatterns on ProfileKyc {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileKyc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileKyc() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileKyc value)  $default,){
final _that = this;
switch (_that) {
case _ProfileKyc():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileKyc value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileKyc() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  KycStatus status, @JsonKey(name: 'legal_full_name')  String? legalFullName,  String? email, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'pan_card_number')  String? panCardNumber, @JsonKey(name: 'aadhar_card_number')  String? aadharCardNumber,  Address? address, @JsonKey(name: 'rejection_reason')  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileKyc() when $default != null:
return $default(_that.id,_that.profileId,_that.createdAt,_that.updatedAt,_that.status,_that.legalFullName,_that.email,_that.phoneNumber,_that.panCardNumber,_that.aadharCardNumber,_that.address,_that.rejectionReason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  KycStatus status, @JsonKey(name: 'legal_full_name')  String? legalFullName,  String? email, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'pan_card_number')  String? panCardNumber, @JsonKey(name: 'aadhar_card_number')  String? aadharCardNumber,  Address? address, @JsonKey(name: 'rejection_reason')  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _ProfileKyc():
return $default(_that.id,_that.profileId,_that.createdAt,_that.updatedAt,_that.status,_that.legalFullName,_that.email,_that.phoneNumber,_that.panCardNumber,_that.aadharCardNumber,_that.address,_that.rejectionReason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'profile_id')  String profileId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  KycStatus status, @JsonKey(name: 'legal_full_name')  String? legalFullName,  String? email, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'pan_card_number')  String? panCardNumber, @JsonKey(name: 'aadhar_card_number')  String? aadharCardNumber,  Address? address, @JsonKey(name: 'rejection_reason')  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _ProfileKyc() when $default != null:
return $default(_that.id,_that.profileId,_that.createdAt,_that.updatedAt,_that.status,_that.legalFullName,_that.email,_that.phoneNumber,_that.panCardNumber,_that.aadharCardNumber,_that.address,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileKyc implements ProfileKyc {
  const _ProfileKyc({required this.id, @JsonKey(name: 'profile_id') required this.profileId, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, required this.status, @JsonKey(name: 'legal_full_name') this.legalFullName, this.email, @JsonKey(name: 'phone_number') this.phoneNumber, @JsonKey(name: 'pan_card_number') this.panCardNumber, @JsonKey(name: 'aadhar_card_number') this.aadharCardNumber, this.address, @JsonKey(name: 'rejection_reason') this.rejectionReason});
  factory _ProfileKyc.fromJson(Map<String, dynamic> json) => _$ProfileKycFromJson(json);

@override final  String id;
@override@JsonKey(name: 'profile_id') final  String profileId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override final  KycStatus status;
@override@JsonKey(name: 'legal_full_name') final  String? legalFullName;
@override final  String? email;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override@JsonKey(name: 'pan_card_number') final  String? panCardNumber;
@override@JsonKey(name: 'aadhar_card_number') final  String? aadharCardNumber;
@override final  Address? address;
@override@JsonKey(name: 'rejection_reason') final  String? rejectionReason;

/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileKycCopyWith<_ProfileKyc> get copyWith => __$ProfileKycCopyWithImpl<_ProfileKyc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileKycToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileKyc&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.legalFullName, legalFullName) || other.legalFullName == legalFullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.panCardNumber, panCardNumber) || other.panCardNumber == panCardNumber)&&(identical(other.aadharCardNumber, aadharCardNumber) || other.aadharCardNumber == aadharCardNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,createdAt,updatedAt,status,legalFullName,email,phoneNumber,panCardNumber,aadharCardNumber,address,rejectionReason);

@override
String toString() {
  return 'ProfileKyc(id: $id, profileId: $profileId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, legalFullName: $legalFullName, email: $email, phoneNumber: $phoneNumber, panCardNumber: $panCardNumber, aadharCardNumber: $aadharCardNumber, address: $address, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$ProfileKycCopyWith<$Res> implements $ProfileKycCopyWith<$Res> {
  factory _$ProfileKycCopyWith(_ProfileKyc value, $Res Function(_ProfileKyc) _then) = __$ProfileKycCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'profile_id') String profileId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, KycStatus status,@JsonKey(name: 'legal_full_name') String? legalFullName, String? email,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'pan_card_number') String? panCardNumber,@JsonKey(name: 'aadhar_card_number') String? aadharCardNumber, Address? address,@JsonKey(name: 'rejection_reason') String? rejectionReason
});


@override $AddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$ProfileKycCopyWithImpl<$Res>
    implements _$ProfileKycCopyWith<$Res> {
  __$ProfileKycCopyWithImpl(this._self, this._then);

  final _ProfileKyc _self;
  final $Res Function(_ProfileKyc) _then;

/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? legalFullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? panCardNumber = freezed,Object? aadharCardNumber = freezed,Object? address = freezed,Object? rejectionReason = freezed,}) {
  return _then(_ProfileKyc(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycStatus,legalFullName: freezed == legalFullName ? _self.legalFullName : legalFullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,panCardNumber: freezed == panCardNumber ? _self.panCardNumber : panCardNumber // ignore: cast_nullable_to_non_nullable
as String?,aadharCardNumber: freezed == aadharCardNumber ? _self.aadharCardNumber : aadharCardNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProfileKyc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$ProfileReference {

 String get id;@JsonKey(name: 'kyc_id') String get kycId;@JsonKey(name: 'reference_type') String get referenceType;@JsonKey(name: 'full_name') String get fullName; String? get relationship;@JsonKey(name: 'phone_number') String get phoneNumber; Address? get address;
/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileReferenceCopyWith<ProfileReference> get copyWith => _$ProfileReferenceCopyWithImpl<ProfileReference>(this as ProfileReference, _$identity);

  /// Serializes this ProfileReference to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileReference&&(identical(other.id, id) || other.id == id)&&(identical(other.kycId, kycId) || other.kycId == kycId)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kycId,referenceType,fullName,relationship,phoneNumber,address);

@override
String toString() {
  return 'ProfileReference(id: $id, kycId: $kycId, referenceType: $referenceType, fullName: $fullName, relationship: $relationship, phoneNumber: $phoneNumber, address: $address)';
}


}

/// @nodoc
abstract mixin class $ProfileReferenceCopyWith<$Res>  {
  factory $ProfileReferenceCopyWith(ProfileReference value, $Res Function(ProfileReference) _then) = _$ProfileReferenceCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'kyc_id') String kycId,@JsonKey(name: 'reference_type') String referenceType,@JsonKey(name: 'full_name') String fullName, String? relationship,@JsonKey(name: 'phone_number') String phoneNumber, Address? address
});


$AddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$ProfileReferenceCopyWithImpl<$Res>
    implements $ProfileReferenceCopyWith<$Res> {
  _$ProfileReferenceCopyWithImpl(this._self, this._then);

  final ProfileReference _self;
  final $Res Function(ProfileReference) _then;

/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kycId = null,Object? referenceType = null,Object? fullName = null,Object? relationship = freezed,Object? phoneNumber = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kycId: null == kycId ? _self.kycId : kycId // ignore: cast_nullable_to_non_nullable
as String,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}
/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileReference].
extension ProfileReferencePatterns on ProfileReference {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileReference() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileReference value)  $default,){
final _that = this;
switch (_that) {
case _ProfileReference():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileReference value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileReference() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'kyc_id')  String kycId, @JsonKey(name: 'reference_type')  String referenceType, @JsonKey(name: 'full_name')  String fullName,  String? relationship, @JsonKey(name: 'phone_number')  String phoneNumber,  Address? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileReference() when $default != null:
return $default(_that.id,_that.kycId,_that.referenceType,_that.fullName,_that.relationship,_that.phoneNumber,_that.address);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'kyc_id')  String kycId, @JsonKey(name: 'reference_type')  String referenceType, @JsonKey(name: 'full_name')  String fullName,  String? relationship, @JsonKey(name: 'phone_number')  String phoneNumber,  Address? address)  $default,) {final _that = this;
switch (_that) {
case _ProfileReference():
return $default(_that.id,_that.kycId,_that.referenceType,_that.fullName,_that.relationship,_that.phoneNumber,_that.address);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'kyc_id')  String kycId, @JsonKey(name: 'reference_type')  String referenceType, @JsonKey(name: 'full_name')  String fullName,  String? relationship, @JsonKey(name: 'phone_number')  String phoneNumber,  Address? address)?  $default,) {final _that = this;
switch (_that) {
case _ProfileReference() when $default != null:
return $default(_that.id,_that.kycId,_that.referenceType,_that.fullName,_that.relationship,_that.phoneNumber,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileReference implements ProfileReference {
  const _ProfileReference({required this.id, @JsonKey(name: 'kyc_id') required this.kycId, @JsonKey(name: 'reference_type') required this.referenceType, @JsonKey(name: 'full_name') required this.fullName, this.relationship, @JsonKey(name: 'phone_number') required this.phoneNumber, this.address});
  factory _ProfileReference.fromJson(Map<String, dynamic> json) => _$ProfileReferenceFromJson(json);

@override final  String id;
@override@JsonKey(name: 'kyc_id') final  String kycId;
@override@JsonKey(name: 'reference_type') final  String referenceType;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String? relationship;
@override@JsonKey(name: 'phone_number') final  String phoneNumber;
@override final  Address? address;

/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileReferenceCopyWith<_ProfileReference> get copyWith => __$ProfileReferenceCopyWithImpl<_ProfileReference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileReferenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileReference&&(identical(other.id, id) || other.id == id)&&(identical(other.kycId, kycId) || other.kycId == kycId)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kycId,referenceType,fullName,relationship,phoneNumber,address);

@override
String toString() {
  return 'ProfileReference(id: $id, kycId: $kycId, referenceType: $referenceType, fullName: $fullName, relationship: $relationship, phoneNumber: $phoneNumber, address: $address)';
}


}

/// @nodoc
abstract mixin class _$ProfileReferenceCopyWith<$Res> implements $ProfileReferenceCopyWith<$Res> {
  factory _$ProfileReferenceCopyWith(_ProfileReference value, $Res Function(_ProfileReference) _then) = __$ProfileReferenceCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'kyc_id') String kycId,@JsonKey(name: 'reference_type') String referenceType,@JsonKey(name: 'full_name') String fullName, String? relationship,@JsonKey(name: 'phone_number') String phoneNumber, Address? address
});


@override $AddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$ProfileReferenceCopyWithImpl<$Res>
    implements _$ProfileReferenceCopyWith<$Res> {
  __$ProfileReferenceCopyWithImpl(this._self, this._then);

  final _ProfileReference _self;
  final $Res Function(_ProfileReference) _then;

/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kycId = null,Object? referenceType = null,Object? fullName = null,Object? relationship = freezed,Object? phoneNumber = null,Object? address = freezed,}) {
  return _then(_ProfileReference(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kycId: null == kycId ? _self.kycId : kycId // ignore: cast_nullable_to_non_nullable
as String,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address?,
  ));
}

/// Create a copy of ProfileReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
