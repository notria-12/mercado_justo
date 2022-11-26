import 'package:flutter/animation.dart';
import 'package:mercado_justo/app/modules/home_auth/models/problem_model.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/problem_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/utils/error.dart';

part 'problem_controller.g.dart';

class ProblemStore = _ProblemStoreBase with _$ProblemStore;

abstract class _ProblemStoreBase with Store {
  ProblemRepository _repository;
  _ProblemStoreBase(this._repository);
  @observable
  AppState problemStatus = AppStateEmpty();

  void reportProblem(ProblemModel problem) async {
    try {
      problemStatus = AppStateLoading();
      await _repository.reportProblem(problem: problem);
      problemStatus = AppStateSuccess();
    } on Failure catch (e) {
      problemStatus = AppStateError(error: e);
    }
  }
}
