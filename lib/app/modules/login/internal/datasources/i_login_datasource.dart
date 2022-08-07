abstract class ILoginDatasource {
  Future<void> sendLoginCodeByEmail({required String email});
}
