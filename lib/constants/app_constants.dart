/// Application constants
class AppConstants {
  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // App Information
  static const String appName = 'Synergetics Manager';
  static const String appVersion = '1.0.0';
  
  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxNameLength = 100;
  static const int phoneNumberLength = 10;
  static const int panCardLength = 10;
  static const int aadharCardLength = 12;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 8.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration splashDuration = Duration(seconds: 2);
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String onboardingCompleteKey = 'onboarding_complete';
  
  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String genericError = 'Something went wrong. Please try again.';
  static const String authError = 'Authentication failed. Please check your credentials.';
  static const String kycPendingMessage = 'Your KYC application is under review. You will be notified once approved.';
  static const String kycRejectedMessage = 'Your KYC application was rejected. Please resubmit with correct information.';
  
  // Validation Messages
  static const String requiredFieldError = 'This field is required';
  static const String invalidEmailError = 'Please enter a valid email address';
  static const String invalidPhoneError = 'Please enter a valid 10-digit phone number';
  static const String invalidPanError = 'Please enter a valid PAN card number (10 characters)';
  static const String invalidAadharError = 'Please enter a valid Aadhar card number (12 digits)';
  static const String passwordTooShortError = 'Password must be at least 6 characters long';
  
  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^[6-9]\d{9}$';
  static const String panPattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
  static const String aadharPattern = r'^[0-9]{12}$';
  
  // KYC Steps
  static const List<String> kycSteps = [
    'Personal Information',
    'Documents',
    'References',
    'Review & Submit',
  ];
  
  // Reference Types
  static const List<String> referenceTypes = [
    'Professional',
    'Personal',
    'Academic',
  ];
  
  // Relationship Types
  static const List<String> relationshipTypes = [
    'Friend',
    'Colleague',
    'Manager',
    'Teacher',
    'Neighbor',
    'Relative',
    'Other',
  ];
  
  // Indian States
  static const List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Jammu and Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry',
  ];
}