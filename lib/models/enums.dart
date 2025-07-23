import 'package:json_annotation/json_annotation.dart';

/// App role enum matching the database schema
enum AppRole {
  @JsonValue('admin')
  admin,
  @JsonValue('manager')
  manager,
  @JsonValue('user')
  user,
}

/// KYC status enum matching the database schema
enum KycStatus {
  @JsonValue('not_submitted')
  notSubmitted,
  @JsonValue('pending_review')
  pendingReview,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
}

/// Extension methods for enum handling
extension AppRoleExtension on AppRole {
  String get displayName {
    switch (this) {
      case AppRole.admin:
        return 'Administrator';
      case AppRole.manager:
        return 'Manager';
      case AppRole.user:
        return 'User';
    }
  }
}

extension KycStatusExtension on KycStatus {
  String get displayName {
    switch (this) {
      case KycStatus.notSubmitted:
        return 'Not Submitted';
      case KycStatus.pendingReview:
        return 'Pending Review';
      case KycStatus.approved:
        return 'Approved';
      case KycStatus.rejected:
        return 'Rejected';
    }
  }

  bool get isApproved => this == KycStatus.approved;
  bool get isPending => this == KycStatus.pendingReview;
  bool get needsSubmission => 
      this == KycStatus.notSubmitted || this == KycStatus.rejected;
}