import 'package:flutter/animation.dart';
import 'package:mercado_justo/app/modules/profile/city_model.dart';
import 'package:mercado_justo/app/modules/profile/profile_repository.dart';
import 'package:mercado_justo/app/modules/profile/state_model.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'profile_controller.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final ProfileRepository _repository;

  _ProfileStoreBase(this._repository);

  @observable
  UserModel? user;

  @observable
  String? selectedState;

  @observable
  AppState stateStatus = AppStateEmpty();

  @observable
  AppState userStatus = AppStateEmpty();

  ObservableList<StateModel> states = ObservableList.of([]);

  @observable
  String? selectedCity;

  @observable
  AppState cityStatus = AppStateEmpty();

  ObservableList<CityModel> cities = ObservableList.of([]);
  void getStates() async {
    try {
      stateStatus = AppStateLoading();

      states = ObservableList.of(await _repository.getStates());
      stateStatus = AppStateSuccess();
    } on Failure catch (e) {
      stateStatus = AppStateError(error: e);
    }
  }

  void getCities() async {
    try {
      cityStatus = AppStateLoading();

      cities = ObservableList.of(await _repository.getCities(selectedState!));

      selectedCity =
          user!.address!.state == selectedState ? user!.address!.city : null;
      cityStatus = AppStateSuccess();
    } on Failure catch (e) {
      cityStatus = AppStateError(error: e);
    }
  }

  void getUser(String userId) async {
    try {
      userStatus = AppStateLoading();
      user = await _repository.getUser(userId: userId);
      userStatus = AppStateSuccess();
    } on Failure catch (e) {
      userStatus = AppStateError(error: e);
    }
  }
}
