import 'package:mercado_justo/shared/utils/error.dart';

abstract class AppState {}

class AppStateEmpty implements AppState {}

class AppStateLoading implements AppState {}

class AppStateSuccess implements AppState {}

class AppStateError implements AppState {
  final Failure error;
  AppStateError({required this.error});
}
