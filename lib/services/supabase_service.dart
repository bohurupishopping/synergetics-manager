import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import '../models/profile.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final _logger = Logger();
  SupabaseClient get client => Supabase.instance.client;
  User? get currentUser => client.auth.currentUser;

  /// Initialize Supabase
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('Attempting to sign in user: $email');
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _logger.i('Sign in successful for user: $email');
      return response;
    } catch (e) {
      _logger.e('Sign in failed: $e');
      rethrow;
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      _logger.i('Signing out current user');
      await client.auth.signOut();
      _logger.i('Sign out successful');
    } catch (e) {
      _logger.e('Sign out failed: $e');
      rethrow;
    }
  }

  /// Get current user profile
  Future<Profile?> getCurrentProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      _logger.i('Fetching profile for user: ${user.id}');
      final response = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) {
        _logger.w('No profile found for user: ${user.id}');
        return null;
      }

      final profile = Profile.fromJson(response);
      _logger.i('Profile fetched successfully for user: ${user.id}');
      return profile;
    } catch (e) {
      _logger.e('Failed to fetch profile: $e');
      rethrow;
    }
  }

  /// Get KYC data for current user
  Future<ProfileKyc?> getCurrentKyc() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      _logger.i('Fetching KYC data for user: ${user.id}');
      final response = await client
          .from('profile_kyc')
          .select()
          .eq('profile_id', user.id)
          .maybeSingle();

      if (response == null) {
        _logger.i('No KYC data found for user: ${user.id}');
        return null;
      }

      final kyc = ProfileKyc.fromJson(response);
      _logger.i('KYC data fetched successfully for user: ${user.id}');
      return kyc;
    } catch (e) {
      _logger.e('Failed to fetch KYC data: $e');
      rethrow;
    }
  }

  /// Submit KYC data
  Future<ProfileKyc> submitKyc(ProfileKyc kyc) async {
    try {
      _logger.i('Submitting KYC data for profile: ${kyc.profileId}');
      
      final kycData = kyc.toJson();
      kycData.remove('id'); // Let database generate ID
      
      final response = await client
          .from('profile_kyc')
          .insert(kycData)
          .select()
          .single();

      final submittedKyc = ProfileKyc.fromJson(response);
      _logger.i('KYC data submitted successfully');
      return submittedKyc;
    } catch (e) {
      _logger.e('Failed to submit KYC data: $e');
      rethrow;
    }
  }

  /// Update KYC data
  Future<ProfileKyc> updateKyc(ProfileKyc kyc) async {
    try {
      _logger.i('Updating KYC data: ${kyc.id}');
      
      final response = await client
          .from('profile_kyc')
          .update(kyc.toJson())
          .eq('id', kyc.id)
          .select()
          .single();

      final updatedKyc = ProfileKyc.fromJson(response);
      _logger.i('KYC data updated successfully');
      return updatedKyc;
    } catch (e) {
      _logger.e('Failed to update KYC data: $e');
      rethrow;
    }
  }

  /// Submit profile references
  Future<List<ProfileReference>> submitReferences(
    String kycId,
    List<ProfileReference> references,
  ) async {
    try {
      _logger.i('Submitting ${references.length} references for KYC: $kycId');
      
      final referencesData = references.map((ref) {
        final data = ref.toJson();
        data.remove('id'); // Let database generate ID
        data['kyc_id'] = kycId;
        return data;
      }).toList();
      
      final response = await client
          .from('profile_references')
          .insert(referencesData)
          .select();

      final submittedReferences = response
          .map((data) => ProfileReference.fromJson(data))
          .toList();
      
      _logger.i('References submitted successfully');
      return submittedReferences;
    } catch (e) {
      _logger.e('Failed to submit references: $e');
      rethrow;
    }
  }

  /// Get references for a KYC record
  Future<List<ProfileReference>> getReferences(String kycId) async {
    try {
      _logger.i('Fetching references for KYC: $kycId');
      
      final response = await client
          .from('profile_references')
          .select()
          .eq('kyc_id', kycId);

      final references = response
          .map((data) => ProfileReference.fromJson(data))
          .toList();
      
      _logger.i('Fetched ${references.length} references');
      return references;
    } catch (e) {
      _logger.e('Failed to fetch references: $e');
      rethrow;
    }
  }

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
}