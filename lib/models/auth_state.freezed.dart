// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Unauthenticated value)?  unauthenticated,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Unauthenticated value)  unauthenticated,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Unauthenticated():
return unauthenticated(_that);case _Authenticated():
return authenticated(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Unauthenticated value)?  unauthenticated,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  unauthenticated,TResult Function( User user,  Profile profile,  ProfileKyc? kyc)?  authenticated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Authenticated() when authenticated != null:
return authenticated(_that.user,_that.profile,_that.kyc);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  unauthenticated,required TResult Function( User user,  Profile profile,  ProfileKyc? kyc)  authenticated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Unauthenticated():
return unauthenticated();case _Authenticated():
return authenticated(_that.user,_that.profile,_that.kyc);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  unauthenticated,TResult? Function( User user,  Profile profile,  ProfileKyc? kyc)?  authenticated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _Authenticated() when authenticated != null:
return authenticated(_that.user,_that.profile,_that.kyc);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AuthState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _Loading implements AuthState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _Unauthenticated implements AuthState {
  const _Unauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class _Authenticated implements AuthState {
  const _Authenticated({required this.user, required this.profile, this.kyc});
  

 final  User user;
 final  Profile profile;
 final  ProfileKyc? kyc;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.user, user) || other.user == user)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.kyc, kyc) || other.kyc == kyc));
}


@override
int get hashCode => Object.hash(runtimeType,user,profile,kyc);

@override
String toString() {
  return 'AuthState.authenticated(user: $user, profile: $profile, kyc: $kyc)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 User user, Profile profile, ProfileKyc? kyc
});


$ProfileCopyWith<$Res> get profile;$ProfileKycCopyWith<$Res>? get kyc;

}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? profile = null,Object? kyc = freezed,}) {
  return _then(_Authenticated(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,kyc: freezed == kyc ? _self.kyc : kyc // ignore: cast_nullable_to_non_nullable
as ProfileKyc?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileKycCopyWith<$Res>? get kyc {
    if (_self.kyc == null) {
    return null;
  }

  return $ProfileKycCopyWith<$Res>(_self.kyc!, (value) {
    return _then(_self.copyWith(kyc: value));
  });
}
}

/// @nodoc


class _Error implements AuthState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$KycFlowState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycFlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState()';
}


}

/// @nodoc
class $KycFlowStateCopyWith<$Res>  {
$KycFlowStateCopyWith(KycFlowState _, $Res Function(KycFlowState) __);
}


/// Adds pattern-matching-related methods to [KycFlowState].
extension KycFlowStatePatterns on KycFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _KycInitial value)?  initial,TResult Function( _KycLoading value)?  loading,TResult Function( _PersonalInfo value)?  personalInfo,TResult Function( _Documents value)?  documents,TResult Function( _References value)?  references,TResult Function( _Review value)?  review,TResult Function( _Submitting value)?  submitting,TResult Function( _Submitted value)?  submitted,TResult Function( _KycError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycInitial() when initial != null:
return initial(_that);case _KycLoading() when loading != null:
return loading(_that);case _PersonalInfo() when personalInfo != null:
return personalInfo(_that);case _Documents() when documents != null:
return documents(_that);case _References() when references != null:
return references(_that);case _Review() when review != null:
return review(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Submitted() when submitted != null:
return submitted(_that);case _KycError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _KycInitial value)  initial,required TResult Function( _KycLoading value)  loading,required TResult Function( _PersonalInfo value)  personalInfo,required TResult Function( _Documents value)  documents,required TResult Function( _References value)  references,required TResult Function( _Review value)  review,required TResult Function( _Submitting value)  submitting,required TResult Function( _Submitted value)  submitted,required TResult Function( _KycError value)  error,}){
final _that = this;
switch (_that) {
case _KycInitial():
return initial(_that);case _KycLoading():
return loading(_that);case _PersonalInfo():
return personalInfo(_that);case _Documents():
return documents(_that);case _References():
return references(_that);case _Review():
return review(_that);case _Submitting():
return submitting(_that);case _Submitted():
return submitted(_that);case _KycError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _KycInitial value)?  initial,TResult? Function( _KycLoading value)?  loading,TResult? Function( _PersonalInfo value)?  personalInfo,TResult? Function( _Documents value)?  documents,TResult? Function( _References value)?  references,TResult? Function( _Review value)?  review,TResult? Function( _Submitting value)?  submitting,TResult? Function( _Submitted value)?  submitted,TResult? Function( _KycError value)?  error,}){
final _that = this;
switch (_that) {
case _KycInitial() when initial != null:
return initial(_that);case _KycLoading() when loading != null:
return loading(_that);case _PersonalInfo() when personalInfo != null:
return personalInfo(_that);case _Documents() when documents != null:
return documents(_that);case _References() when references != null:
return references(_that);case _Review() when review != null:
return review(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Submitted() when submitted != null:
return submitted(_that);case _KycError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  personalInfo,TResult Function()?  documents,TResult Function()?  references,TResult Function()?  review,TResult Function()?  submitting,TResult Function()?  submitted,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycInitial() when initial != null:
return initial();case _KycLoading() when loading != null:
return loading();case _PersonalInfo() when personalInfo != null:
return personalInfo();case _Documents() when documents != null:
return documents();case _References() when references != null:
return references();case _Review() when review != null:
return review();case _Submitting() when submitting != null:
return submitting();case _Submitted() when submitted != null:
return submitted();case _KycError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  personalInfo,required TResult Function()  documents,required TResult Function()  references,required TResult Function()  review,required TResult Function()  submitting,required TResult Function()  submitted,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _KycInitial():
return initial();case _KycLoading():
return loading();case _PersonalInfo():
return personalInfo();case _Documents():
return documents();case _References():
return references();case _Review():
return review();case _Submitting():
return submitting();case _Submitted():
return submitted();case _KycError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  personalInfo,TResult? Function()?  documents,TResult? Function()?  references,TResult? Function()?  review,TResult? Function()?  submitting,TResult? Function()?  submitted,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _KycInitial() when initial != null:
return initial();case _KycLoading() when loading != null:
return loading();case _PersonalInfo() when personalInfo != null:
return personalInfo();case _Documents() when documents != null:
return documents();case _References() when references != null:
return references();case _Review() when review != null:
return review();case _Submitting() when submitting != null:
return submitting();case _Submitted() when submitted != null:
return submitted();case _KycError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _KycInitial implements KycFlowState {
  const _KycInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.initial()';
}


}




/// @nodoc


class _KycLoading implements KycFlowState {
  const _KycLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.loading()';
}


}




/// @nodoc


class _PersonalInfo implements KycFlowState {
  const _PersonalInfo();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalInfo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.personalInfo()';
}


}




/// @nodoc


class _Documents implements KycFlowState {
  const _Documents();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Documents);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.documents()';
}


}




/// @nodoc


class _References implements KycFlowState {
  const _References();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _References);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.references()';
}


}




/// @nodoc


class _Review implements KycFlowState {
  const _Review();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.review()';
}


}




/// @nodoc


class _Submitting implements KycFlowState {
  const _Submitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.submitting()';
}


}




/// @nodoc


class _Submitted implements KycFlowState {
  const _Submitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycFlowState.submitted()';
}


}




/// @nodoc


class _KycError implements KycFlowState {
  const _KycError(this.message);
  

 final  String message;

/// Create a copy of KycFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycErrorCopyWith<_KycError> get copyWith => __$KycErrorCopyWithImpl<_KycError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'KycFlowState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$KycErrorCopyWith<$Res> implements $KycFlowStateCopyWith<$Res> {
  factory _$KycErrorCopyWith(_KycError value, $Res Function(_KycError) _then) = __$KycErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$KycErrorCopyWithImpl<$Res>
    implements _$KycErrorCopyWith<$Res> {
  __$KycErrorCopyWithImpl(this._self, this._then);

  final _KycError _self;
  final $Res Function(_KycError) _then;

/// Create a copy of KycFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_KycError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$KycFormData {

// Personal Information
 String? get legalFullName; String? get email; String? get phoneNumber;// Address
 String? get street; String? get city; String? get state; String? get zipCode; String? get country;// Documents
 String? get panCardNumber; String? get aadharCardNumber;// References
 List<ProfileReference>? get references;
/// Create a copy of KycFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycFormDataCopyWith<KycFormData> get copyWith => _$KycFormDataCopyWithImpl<KycFormData>(this as KycFormData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycFormData&&(identical(other.legalFullName, legalFullName) || other.legalFullName == legalFullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.panCardNumber, panCardNumber) || other.panCardNumber == panCardNumber)&&(identical(other.aadharCardNumber, aadharCardNumber) || other.aadharCardNumber == aadharCardNumber)&&const DeepCollectionEquality().equals(other.references, references));
}


@override
int get hashCode => Object.hash(runtimeType,legalFullName,email,phoneNumber,street,city,state,zipCode,country,panCardNumber,aadharCardNumber,const DeepCollectionEquality().hash(references));

@override
String toString() {
  return 'KycFormData(legalFullName: $legalFullName, email: $email, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country, panCardNumber: $panCardNumber, aadharCardNumber: $aadharCardNumber, references: $references)';
}


}

/// @nodoc
abstract mixin class $KycFormDataCopyWith<$Res>  {
  factory $KycFormDataCopyWith(KycFormData value, $Res Function(KycFormData) _then) = _$KycFormDataCopyWithImpl;
@useResult
$Res call({
 String? legalFullName, String? email, String? phoneNumber, String? street, String? city, String? state, String? zipCode, String? country, String? panCardNumber, String? aadharCardNumber, List<ProfileReference>? references
});




}
/// @nodoc
class _$KycFormDataCopyWithImpl<$Res>
    implements $KycFormDataCopyWith<$Res> {
  _$KycFormDataCopyWithImpl(this._self, this._then);

  final KycFormData _self;
  final $Res Function(KycFormData) _then;

/// Create a copy of KycFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? legalFullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? street = freezed,Object? city = freezed,Object? state = freezed,Object? zipCode = freezed,Object? country = freezed,Object? panCardNumber = freezed,Object? aadharCardNumber = freezed,Object? references = freezed,}) {
  return _then(_self.copyWith(
legalFullName: freezed == legalFullName ? _self.legalFullName : legalFullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,panCardNumber: freezed == panCardNumber ? _self.panCardNumber : panCardNumber // ignore: cast_nullable_to_non_nullable
as String?,aadharCardNumber: freezed == aadharCardNumber ? _self.aadharCardNumber : aadharCardNumber // ignore: cast_nullable_to_non_nullable
as String?,references: freezed == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<ProfileReference>?,
  ));
}

}


/// Adds pattern-matching-related methods to [KycFormData].
extension KycFormDataPatterns on KycFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycFormData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycFormData value)  $default,){
final _that = this;
switch (_that) {
case _KycFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycFormData value)?  $default,){
final _that = this;
switch (_that) {
case _KycFormData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? legalFullName,  String? email,  String? phoneNumber,  String? street,  String? city,  String? state,  String? zipCode,  String? country,  String? panCardNumber,  String? aadharCardNumber,  List<ProfileReference>? references)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycFormData() when $default != null:
return $default(_that.legalFullName,_that.email,_that.phoneNumber,_that.street,_that.city,_that.state,_that.zipCode,_that.country,_that.panCardNumber,_that.aadharCardNumber,_that.references);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? legalFullName,  String? email,  String? phoneNumber,  String? street,  String? city,  String? state,  String? zipCode,  String? country,  String? panCardNumber,  String? aadharCardNumber,  List<ProfileReference>? references)  $default,) {final _that = this;
switch (_that) {
case _KycFormData():
return $default(_that.legalFullName,_that.email,_that.phoneNumber,_that.street,_that.city,_that.state,_that.zipCode,_that.country,_that.panCardNumber,_that.aadharCardNumber,_that.references);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? legalFullName,  String? email,  String? phoneNumber,  String? street,  String? city,  String? state,  String? zipCode,  String? country,  String? panCardNumber,  String? aadharCardNumber,  List<ProfileReference>? references)?  $default,) {final _that = this;
switch (_that) {
case _KycFormData() when $default != null:
return $default(_that.legalFullName,_that.email,_that.phoneNumber,_that.street,_that.city,_that.state,_that.zipCode,_that.country,_that.panCardNumber,_that.aadharCardNumber,_that.references);case _:
  return null;

}
}

}

/// @nodoc


class _KycFormData extends KycFormData {
  const _KycFormData({this.legalFullName, this.email, this.phoneNumber, this.street, this.city, this.state, this.zipCode, this.country, this.panCardNumber, this.aadharCardNumber, final  List<ProfileReference>? references}): _references = references,super._();
  

// Personal Information
@override final  String? legalFullName;
@override final  String? email;
@override final  String? phoneNumber;
// Address
@override final  String? street;
@override final  String? city;
@override final  String? state;
@override final  String? zipCode;
@override final  String? country;
// Documents
@override final  String? panCardNumber;
@override final  String? aadharCardNumber;
// References
 final  List<ProfileReference>? _references;
// References
@override List<ProfileReference>? get references {
  final value = _references;
  if (value == null) return null;
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of KycFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycFormDataCopyWith<_KycFormData> get copyWith => __$KycFormDataCopyWithImpl<_KycFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycFormData&&(identical(other.legalFullName, legalFullName) || other.legalFullName == legalFullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.panCardNumber, panCardNumber) || other.panCardNumber == panCardNumber)&&(identical(other.aadharCardNumber, aadharCardNumber) || other.aadharCardNumber == aadharCardNumber)&&const DeepCollectionEquality().equals(other._references, _references));
}


@override
int get hashCode => Object.hash(runtimeType,legalFullName,email,phoneNumber,street,city,state,zipCode,country,panCardNumber,aadharCardNumber,const DeepCollectionEquality().hash(_references));

@override
String toString() {
  return 'KycFormData(legalFullName: $legalFullName, email: $email, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country, panCardNumber: $panCardNumber, aadharCardNumber: $aadharCardNumber, references: $references)';
}


}

/// @nodoc
abstract mixin class _$KycFormDataCopyWith<$Res> implements $KycFormDataCopyWith<$Res> {
  factory _$KycFormDataCopyWith(_KycFormData value, $Res Function(_KycFormData) _then) = __$KycFormDataCopyWithImpl;
@override @useResult
$Res call({
 String? legalFullName, String? email, String? phoneNumber, String? street, String? city, String? state, String? zipCode, String? country, String? panCardNumber, String? aadharCardNumber, List<ProfileReference>? references
});




}
/// @nodoc
class __$KycFormDataCopyWithImpl<$Res>
    implements _$KycFormDataCopyWith<$Res> {
  __$KycFormDataCopyWithImpl(this._self, this._then);

  final _KycFormData _self;
  final $Res Function(_KycFormData) _then;

/// Create a copy of KycFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? legalFullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? street = freezed,Object? city = freezed,Object? state = freezed,Object? zipCode = freezed,Object? country = freezed,Object? panCardNumber = freezed,Object? aadharCardNumber = freezed,Object? references = freezed,}) {
  return _then(_KycFormData(
legalFullName: freezed == legalFullName ? _self.legalFullName : legalFullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,panCardNumber: freezed == panCardNumber ? _self.panCardNumber : panCardNumber // ignore: cast_nullable_to_non_nullable
as String?,aadharCardNumber: freezed == aadharCardNumber ? _self.aadharCardNumber : aadharCardNumber // ignore: cast_nullable_to_non_nullable
as String?,references: freezed == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<ProfileReference>?,
  ));
}


}

// dart format on
