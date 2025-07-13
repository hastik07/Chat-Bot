import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class AuthUseCases {
  final AuthRepository repository;
  AuthUseCases(this.repository);

  Future<UserModel?> signUp(String email, String password) => repository.signUp(email, password);
  Future<UserModel?> signIn(String email, String password) => repository.signIn(email, password);
  Future<void> signOut() => repository.signOut();
  UserModel? getCurrentUser() => repository.getCurrentUser();
  Future<void> updateProfile({String? displayName, String? avatarUrl}) => repository.updateProfile(displayName: displayName, avatarUrl: avatarUrl);
} 