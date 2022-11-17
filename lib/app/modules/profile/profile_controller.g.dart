// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  final _$selectedStateAtom = Atom(name: '_ProfileStoreBase.selectedState');

  @override
  StateModel? get selectedState {
    _$selectedStateAtom.reportRead();
    return super.selectedState;
  }

  @override
  set selectedState(StateModel? value) {
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

  final _$selectedCityAtom = Atom(name: '_ProfileStoreBase.selectedCity');

  @override
  CityModel? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(CityModel? value) {
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

  @override
  String toString() {
    return '''
selectedState: ${selectedState},
stateStatus: ${stateStatus},
selectedCity: ${selectedCity},
cityStatus: ${cityStatus}
    ''';
  }
}
