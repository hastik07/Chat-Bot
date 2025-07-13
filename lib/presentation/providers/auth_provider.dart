import 'package:flutter/material.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthUseCases _authUseCases;
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._authUseCases) {
    _user = _authUseCases.getCurrentUser();
  }

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authUseCases.signUp(email, password);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authUseCases.signIn(email, password);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authUseCases.signOut();
      _user = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> updateProfile({String? displayName, String? avatarUrl}) async {
    _setLoading(true);
    try {
      await _authUseCases.updateProfile(displayName: displayName, avatarUrl: avatarUrl);
      _user = _authUseCases.getCurrentUser();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
} 