import '../constants/app_constants.dart';

class Validators {
  /// Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    final emailRegex = RegExp(AppConstants.emailPattern);
    if (!emailRegex.hasMatch(value)) {
      return AppConstants.invalidEmailError;
    }
    
    return null;
  }
  
  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return AppConstants.passwordTooShortError;
    }
    
    return null;
  }
  
  /// Validate required field
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required'
          : AppConstants.requiredFieldError;
    }
    return null;
  }
  
  /// Validate name (required, max length)
  static String? validateName(String? value, [String? fieldName]) {
    final requiredError = validateRequired(value, fieldName);
    if (requiredError != null) return requiredError;
    
    if (value!.length > AppConstants.maxNameLength) {
      return '${fieldName ?? 'Name'} must be less than ${AppConstants.maxNameLength} characters';
    }
    
    return null;
  }
  
  /// Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    // Remove any non-digit characters
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    
    if (cleanedValue.length != AppConstants.phoneNumberLength) {
      return AppConstants.invalidPhoneError;
    }
    
    final phoneRegex = RegExp(AppConstants.phonePattern);
    if (!phoneRegex.hasMatch(cleanedValue)) {
      return AppConstants.invalidPhoneError;
    }
    
    return null;
  }
  
  /// Validate PAN card number
  static String? validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    final cleanedValue = value.toUpperCase().trim();
    
    if (cleanedValue.length != AppConstants.panCardLength) {
      return AppConstants.invalidPanError;
    }
    
    final panRegex = RegExp(AppConstants.panPattern);
    if (!panRegex.hasMatch(cleanedValue)) {
      return AppConstants.invalidPanError;
    }
    
    return null;
  }
  
  /// Validate Aadhar card number
  static String? validateAadharCard(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    // Remove any non-digit characters
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    
    if (cleanedValue.length != AppConstants.aadharCardLength) {
      return AppConstants.invalidAadharError;
    }
    
    final aadharRegex = RegExp(AppConstants.aadharPattern);
    if (!aadharRegex.hasMatch(cleanedValue)) {
      return AppConstants.invalidAadharError;
    }
    
    return null;
  }
  
  /// Validate ZIP code
  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    // Remove any non-digit characters
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    
    if (cleanedValue.length != 6) {
      return 'Please enter a valid 6-digit ZIP code';
    }
    
    return null;
  }
  
  /// Validate dropdown selection
  static String? validateDropdown(dynamic value, String fieldName) {
    if (value == null) {
      return 'Please select $fieldName';
    }
    return null;
  }
  
  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldError;
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'Field'} must be at least $minLength characters long';
    }
    
    return null;
  }
  
  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'Field'} must be less than $maxLength characters';
    }
    
    return null;
  }
  
  /// Validate address field
  static String? validateAddress(String? value) {
    final requiredError = validateRequired(value, 'Address');
    if (requiredError != null) return requiredError;
    
    if (value!.length < 10) {
      return 'Address must be at least 10 characters long';
    }
    
    return null;
  }
}

/// Formatters for input fields
class Formatters {
  /// Format phone number with spaces
  static String formatPhoneNumber(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (cleanedValue.length <= 10) {
      return cleanedValue;
    }
    return cleanedValue.substring(0, 10);
  }
  
  /// Format PAN card number
  static String formatPanCard(String value) {
    final cleanedValue = value.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (cleanedValue.length <= 10) {
      return cleanedValue;
    }
    return cleanedValue.substring(0, 10);
  }
  
  /// Format Aadhar card number
  static String formatAadharCard(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (cleanedValue.length <= 12) {
      return cleanedValue;
    }
    return cleanedValue.substring(0, 12);
  }
  
  /// Format ZIP code
  static String formatZipCode(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (cleanedValue.length <= 6) {
      return cleanedValue;
    }
    return cleanedValue.substring(0, 6);
  }
  
  /// Capitalize first letter of each word
  static String capitalizeWords(String value) {
    return value.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
  
  /// Format name (capitalize and trim)
  static String formatName(String value) {
    return capitalizeWords(value.trim());
  }
}