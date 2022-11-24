// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<bool>? _$canUpdateComputed;

  @override
  bool get canUpdate =>
      (_$canUpdateComputed ??= Computed<bool>(() => super.canUpdate,
              name: '_ProfileStoreBase.canUpdate'))
          .value;

  final _$inputNameAtom = Atom(name: '_ProfileStoreBase.inputName');

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

  final _$inputPhoneAtom = Atom(name: '_ProfileStoreBase.inputPhone');

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

  final _$inputEmailAtom = Atom(name: '_ProfileStoreBase.inputEmail');

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

  final _$inputStreetAtom = Atom(name: '_ProfileStoreBase.inputStreet');

  @override
  String? get inputStreet {
    _$inputStreetAtom.reportRead();
    return super.inputStreet;
  }

  @override
  set inputStreet(String? value) {
    _$inputStreetAtom.reportWrite(value, super.inputStreet, () {
      super.inputStreet = value;
    });
  }

  final _$inputNeighborhoodAtom =
      Atom(name: '_ProfileStoreBase.inputNeighborhood');

  @override
  String? get inputNeighborhood {
    _$inputNeighborhoodAtom.reportRead();
    return super.inputNeighborhood;
  }

  @override
  set inputNeighborhood(String? value) {
    _$inputNeighborhoodAtom.reportWrite(value, super.inputNeighborhood, () {
      super.inputNeighborhood = value;
    });
  }

  final _$inputComplementAtom = Atom(name: '_ProfileStoreBase.inputComplement');

  @override
  String? get inputComplement {
    _$inputComplementAtom.reportRead();
    return super.inputComplement;
  }

  @override
  set inputComplement(String? value) {
    _$inputComplementAtom.reportWrite(value, super.inputComplement, () {
      super.inputComplement = value;
    });
  }

  final _$inputCEPAtom = Atom(name: '_ProfileStoreBase.inputCEP');

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

  final _$userAtom = Atom(name: '_ProfileStoreBase.user');

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

  final _$selectedStateAtom = Atom(name: '_ProfileStoreBase.selectedState');

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

  final _$stateStatusAtom = Atom(name: '_ProfileStoreBase.stateStatus');

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

  final _$userStatusAtom = Atom(name: '_ProfileStoreBase.userStatus');

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

  final _$userUpdateStatusAtom =
      Atom(name: '_ProfileStoreBase.userUpdateStatus');

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

  final _$selectedCityAtom = Atom(name: '_ProfileStoreBase.selectedCity');

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

  final _$cityStatusAtom = Atom(name: '_ProfileStoreBase.cityStatus');

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

  final _$selectedGenreAtom = Atom(name: '_ProfileStoreBase.selectedGenre');

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

  final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase');

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
  void setStreet(String? value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setStreet');
    try {
      return super.setStreet(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeighborhood(String? value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setNeighborhood');
    try {
      return super.setNeighborhood(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComplement(String? value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setComplement');
    try {
      return super.setComplement(value);
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
inputStreet: ${inputStreet},
inputNeighborhood: ${inputNeighborhood},
inputComplement: ${inputComplement},
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
