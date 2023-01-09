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
  String? inputName;

  @action
  void setName(String value) {
    inputName = value;
  }

  @observable
  String? inputPhone;

  @action
  void setPhone(String value) {
    inputPhone = value;
  }

  @observable
  String? inputEmail;

  @action
  void setEmail(String value) {
    inputEmail = value;
  }

  @observable
  String? inputStreet;

  @action
  void setStreet(String? value) {
    inputStreet = value;
  }

  @observable
  String? inputNeighborhood;

  @action
  void setNeighborhood(String? value) {
    inputNeighborhood = value;
  }

  @observable
  String? inputComplement;

  @action
  void setComplement(String? value) {
    inputComplement = value;
  }

  @observable
  String? inputCEP;

  @action
  void setCEP(String? value) {
    inputCEP = value;
  }

  @observable
  UserModel? user;

  @observable
  String? selectedState;

  @observable
  AppState stateStatus = AppStateEmpty();

  @observable
  AppState userStatus = AppStateEmpty();

  @observable
  AppState userUpdateStatus = AppStateEmpty();

  ObservableList<StateModel> states = ObservableList.of([]);

  @observable
  String? selectedCity;

  @observable
  AppState cityStatus = AppStateEmpty();

  ObservableList<CityModel> cities = ObservableList.of([]);

  ObservableList<String> genreList =
      ObservableList.of(['Masculino', 'Feminino', 'Outros']);

  @observable
  String? selectedGenre;

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
          user!.address != null && user!.address!.state == selectedState
              ? user!.address!.city
              : null;
      cityStatus = AppStateSuccess();
    } on Failure catch (e) {
      cityStatus = AppStateError(error: e);
    }
  }

  void getUser(String userId) async {
    try {
      userStatus = AppStateLoading();
      user = await _repository.getUser(userId: userId);
      setName(user!.name);
      setPhone(user!.phone);
      setEmail(user!.email);
      if (user!.address != null) {
        setStreet(user!.address!.street);
        setNeighborhood(user!.address!.neighborhood);
        setComplement(user!.address!.complement);
        setCEP(user!.address!.cep);
      }
      if (user!.genre != null) {
        selectedGenre = user!.genre!.substring(0, 1).toUpperCase() +
            user!.genre!.substring(1);
      }
      if (user!.address != null) {
        selectedState = user!.address!.state;
      }
      userStatus = AppStateSuccess();
    } on Failure catch (e) {
      userStatus = AppStateError(error: e);
    }
  }

  void updateUser() async {
    try {
      userUpdateStatus = AppStateLoading();
      if (selectedState != null && selectedCity != null) {
        UserModel newUser = user!.copyWith(
            name: inputName,
            phone: inputPhone,
            email: inputEmail,
            genre: selectedGenre!.toLowerCase(),
            address: AddressModel(
                state: selectedState!,
                city: selectedCity!,
                street: inputStreet,
                neighborhood: inputNeighborhood,
                complement: inputComplement,
                cep: inputCEP));
        user = await _repository.updateUser(user: newUser);
        userUpdateStatus = AppStateSuccess();
      } else {
        throw Failure(
            title: 'Cidade e estado',
            message: 'Estado e cidade são obrigatórios');
      }
    } on Failure catch (e) {
      userUpdateStatus = AppStateError(error: e);
    }
  }

  @computed
  bool get canUpdate {
    return (user!.name != inputName ||
        user!.phone != inputPhone ||
        user!.email != inputEmail ||
        (user!.address != null && user!.address!.state != selectedState) ||
        user!.genre !=
            (selectedGenre != null ? selectedGenre!.toLowerCase() : null) ||
        (user!.address != null && user!.address!.city != selectedCity) ||
        (user!.address != null &&
            user!.address!.street != inputStreet &&
            inputStreet!.isNotEmpty) ||
        (user!.address != null &&
            user!.address!.neighborhood != inputNeighborhood &&
            inputNeighborhood!.isNotEmpty) ||
        (user!.address != null &&
            user!.address!.complement != inputComplement &&
            inputComplement!.isNotEmpty) ||
        (user!.address != null &&
            user!.address!.cep != inputCEP &&
            inputCEP!.isNotEmpty));
  }
}
