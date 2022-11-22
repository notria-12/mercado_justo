import 'package:dio/dio.dart';
import 'package:mercado_justo/app/modules/profile/city_model.dart';
import 'package:mercado_justo/app/modules/profile/state_model.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class ProfileRepository {
  Dio _dio;
  ProfileRepository(this._dio);

  Future<List<StateModel>> getStates() async {
    try {
      var result = await _dio.get('/estado-cidade/estados');
      List listState = result.data['dados'] as List;

      return listState.map((e) => StateModel.fromMap(e)).toList();
    } catch (e) {
      throw Failure(title: 'Busca estados', message: 'Falha ao buscar estados');
    }
  }

  Future<List<CityModel>> getCities(String state) async {
    try {
      var result = await _dio.get('/estado-cidade/$state/cidades');
      List listCities = result.data['dados'] as List;

      return listCities.map((e) => CityModel.fromMap(e)).toList();
    } catch (e) {
      throw Failure(title: 'Busca cidades', message: 'Falha ao buscar cidades');
    }
  }

  Future<UserModel> getUser({required String userId}) async {
    try {
      var result = await _dio.get('/usuarios/$userId');
      return UserModel.fromMap(result.data['dados']);
    } catch (e) {
      throw Failure(title: 'Erro Usuário', message: 'Erro ao buscar usuário');
    }
  }
}
