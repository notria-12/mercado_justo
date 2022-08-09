abstract class ILoginRepository {
  Future<void> sendLoginCodeByEmail({required String email});
  Future<void> loginWithEmailCode(
      {required String code, required String email});
}
