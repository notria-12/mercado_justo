abstract class ILoginRepository {
  Future<void> sendLoginCodeByEmail({required String email});
}
