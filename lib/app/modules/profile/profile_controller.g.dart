// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<bool>? _$canUpdateComputed;

  @override
  bool get canUpdate =>
      (_$canUpdateComputed ??= Computed<bool>(() => super.canUpdate,
              name: '_ProfileStoreBase.canUpdate'))
          .value;

  late final _$inputNameAtom =
      Atom(name: '_ProfileStoreBase.inputName', context: context);

  @override
  String? get inputName {
    _$inputNameAtom.reportRead();
    return super.inputName;
  }

  @override
  set inputName(String? value) {
    _$inputNameAtom.reportWrite(value, super.inputName, () {
      super.inputName = value;
    });
  }

  late final _$inputPhoneAtom =
      Atom(name: '_ProfileStoreBase.inputPhone', context: context);

  @override
  String? get inputPhone {
    _$inputPhoneAtom.reportRead();
    return super.inputPhone;
  }

  @override
  set inputPhone(String? value) {
    _$inputPhoneAtom.reportWrite(value, super.inputPhone, () {
      super.inputPhone = value;
    });
  }

  late final _$inputEmailAtom =
      Atom(name: '_ProfileStoreBase.inputEmail', context: context);

  @override
  String? get inputEmail {
    _$inputEmailAtom.reportRead();
    return super.inputEmail;
  }

  @override
  set inputEmail(String? value) {
    _$inputEmailAtom.reportWrite(value, super.inputEmail, () {
      super.inputEmail = value;
    });
  }

  late final _$inputCEPAtom =
      Atom(name: '_ProfileStoreBase.inputCEP', context: context);

  @override
  String? get inputCEP {
    _$inputCEPAtom.reportRead();
    return super.inputCEP;
  }

  @override
  set inputCEP(String? value) {
    _$inputCEPAtom.reportWrite(value, super.inputCEP, () {
      super.inputCEP = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_ProfileStoreBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$selectedStateAtom =
      Atom(name: '_ProfileStoreBase.selectedState', context: context);

  @override
  String? get selectedState {
    _$selectedStateAtom.reportRead();
    return super.selectedState;
  }

  @override
  set selectedState(String? value) {
    _$selectedStateAtom.reportWrite(value, super.selectedState, () {
      super.selectedState = value;
    });
  }

  late final _$stateStatusAtom =
      Atom(name: '_ProfileStoreBase.stateStatus', context: context);

  @override
  AppState get stateStatus {
    _$stateStatusAtom.reportRead();
    return super.stateStatus;
  }

  @override
  set stateStatus(AppState value) {
    _$stateStatusAtom.reportWrite(value, super.stateStatus, () {
      super.stateStatus = value;
    });
  }

  late final _$userStatusAtom =
      Atom(name: '_ProfileStoreBase.userStatus', context: context);

  @override
  AppState get userStatus {
    _$userStatusAtom.reportRead();
    return super.userStatus;
  }

  @override
  set userStatus(AppState value) {
    _$userStatusAtom.reportWrite(value, super.userStatus, () {
      super.userStatus = value;
    });
  }

  late final _$userUpdateStatusAtom =
      Atom(name: '_ProfileStoreBase.userUpdateStatus', context: context);

  @override
  AppState get userUpdateStatus {
    _$userUpdateStatusAtom.reportRead();
    return super.userUpdateStatus;
  }

  @override
  set userUpdateStatus(AppState value) {
    _$userUpdateStatusAtom.reportWrite(value, super.userUpdateStatus, () {
      super.userUpdateStatus = value;
    });
  }

  late final _$selectedCityAtom =
      Atom(name: '_ProfileStoreBase.selectedCity', context: context);

  @override
  String? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(String? value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  late final _$cityStatusAtom =
      Atom(name: '_ProfileStoreBase.cityStatus', context: context);

  @override
  AppState get cityStatus {
    _$cityStatusAtom.reportRead();
    return super.cityStatus;
  }

  @override
  set cityStatus(AppState value) {
    _$cityStatusAtom.reportWrite(value, super.cityStatus, () {
      super.cityStatus = value;
    });
  }

  late final _$selectedGenreAtom =
      Atom(name: '_ProfileStoreBase.selectedGenre', context: context);

  @override
  String? get selectedGenre {
    _$selectedGenreAtom.reportRead();
    return super.selectedGenre;
  }

  @override
  set selectedGenre(String? value) {
    _$selectedGenreAtom.reportWrite(value, super.selectedGenre, () {
      super.selectedGenre = value;
    });
  }

  late final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCEP(String? value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setCEP');
    try {
      return super.setCEP(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inputName: ${inputName},
inputPhone: ${inputPhone},
inputEmail: ${inputEmail},
inputCEP: ${inputCEP},
user: ${user},
selectedState: ${selectedState},
stateStatus: ${stateStatus},
userStatus: ${userStatus},
userUpdateStatus: ${userUpdateStatus},
selectedCity: ${selectedCity},
cityStatus: ${cityStatus},
selectedGenre: ${selectedGenre},
canUpdate: ${canUpdate}
    ''';
  }
}
