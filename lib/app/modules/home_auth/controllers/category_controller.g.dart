// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStoreBase, Store {
  late final _$selectedCategoryAtom =
      Atom(name: '_CategoryStoreBase.selectedCategory', context: context);

  @override
  CategoryModel? get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(CategoryModel? value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$canUpdateAtom =
      Atom(name: '_CategoryStoreBase.canUpdate', context: context);

  @override
  bool get canUpdate {
    _$canUpdateAtom.reportRead();
    return super.canUpdate;
  }

  @override
  set canUpdate(bool value) {
    _$canUpdateAtom.reportWrite(value, super.canUpdate, () {
      super.canUpdate = value;
    });
  }

  late final _$secondaryCategoriesStatusAtom = Atom(
      name: '_CategoryStoreBase.secondaryCategoriesStatus', context: context);

  @override
  AppState get secondaryCategoriesStatus {
    _$secondaryCategoriesStatusAtom.reportRead();
    return super.secondaryCategoriesStatus;
  }

  @override
  set secondaryCategoriesStatus(AppState value) {
    _$secondaryCategoriesStatusAtom
        .reportWrite(value, super.secondaryCategoriesStatus, () {
      super.secondaryCategoriesStatus = value;
    });
  }

  @override
  String toString() {
    return '''
selectedCategory: ${selectedCategory},
canUpdate: ${canUpdate},
secondaryCategoriesStatus: ${secondaryCategoriesStatus}
    ''';
  }
}
