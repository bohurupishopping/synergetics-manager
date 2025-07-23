import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../models/auth_state.dart' as app_state;
import '../services/supabase_service.dart';

// Import Supabase types
import 'package:supabase_flutter/supabase_flutter.dart' as supabase show AuthState, AuthException;

class AuthCubit extends Cubit<app_state.AuthState> {
  AuthCubit(this._supabaseService) : super(const app_state.AuthState.initial()) {
    _initializeAuth();
  }

  final SupabaseService _supabaseService;
  final _logger = Logger();

  /// Initialize authentication state
  void _initializeAuth() {
    _logger.i('Initializing authentication state');
    
    // Listen to auth state changes
    _supabaseService.authStateChanges.listen((supabaseAuthState) {
      _handleAuthStateChange(supabaseAuthState);
    });

    // Check current session
    _checkCurrentSession();
  }

  /// Handle Supabase auth state changes
  void _handleAuthStateChange(supabase.AuthState supabaseAuthState) {
    _logger.i('Auth state changed: $supabaseAuthState');
    
    if (_supabaseService.currentUser != null) {
      _loadUserProfile();
    } else {
      emit(const app_state.AuthState.unauthenticated());
    }
  }

  /// Check if user has valid session
  Future<void> _checkCurrentSession() async {
    try {
      emit(const app_state.AuthState.loading());
      
      final user = _supabaseService.currentUser;
      if (user != null) {
        await _loadUserProfile();
      } else {
        emit(const app_state.AuthState.unauthenticated());
      }
    } catch (e) {
      _logger.e('Error checking current session: $e');
      emit(app_state.AuthState.error('Failed to check authentication status'));
    }
  }

  /// Load user profile and KYC data
  Future<void> _loadUserProfile() async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        emit(const app_state.AuthState.unauthenticated());
        return;
      }

      final profile = await _supabaseService.getCurrentProfile();
      if (profile == null) {
        _logger.e('No profile found for authenticated user');
        emit(const app_state.AuthState.error('Profile not found'));
        return;
      }

      final kyc = await _supabaseService.getCurrentKyc();
      
      emit(app_state.AuthState.authenticated(
        user: user,
        profile: profile,
        kyc: kyc,
      ));
    } catch (e) {
      _logger.e('Error loading user profile: $e');
      emit(app_state.AuthState.error('Failed to load user profile'));
    }
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(const app_state.AuthState.loading());
      
      await _supabaseService.signIn(
        email: email,
        password: password,
      );
      
      // Auth state change will be handled by listener
    } catch (e) {
      _logger.e('Sign in error: $e');
      String errorMessage = 'Sign in failed';
      
      if (e is supabase.AuthException) {
        switch (e.message) {
          case 'Invalid login credentials':
            errorMessage = 'Invalid email or password';
            break;
          case 'Email not confirmed':
            errorMessage = 'Please verify your email address';
            break;
          default:
            errorMessage = e.message;
        }
      }
      
      emit(app_state.AuthState.error(errorMessage));
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      emit(const app_state.AuthState.loading());
      await _supabaseService.signOut();
      emit(const app_state.AuthState.unauthenticated());
    } catch (e) {
      _logger.e('Sign out error: $e');
      emit(const app_state.AuthState.error('Failed to sign out'));
    }
  }

  /// Refresh user data
  Future<void> refreshUserData() async {
    state.when(
      initial: () {},
      loading: () {},
      authenticated: (user, profile, kyc) async {
        await _loadUserProfile();
      },
      unauthenticated: () {},
      error: (message) {},
    );
  }

  /// Clear error state
  void clearError() {
    state.when(
      initial: () {},
      loading: () {},
      authenticated: (user, profile, kyc) {},
      unauthenticated: () {},
      error: (message) {
        emit(const app_state.AuthState.unauthenticated());
      },
    );
  }
}