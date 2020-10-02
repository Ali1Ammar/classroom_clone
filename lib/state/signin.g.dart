// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SigninState on _SigninState, Store {
  final _$typeCheckedAtom = Atom(name: '_SigninState.typeChecked');

  @override
  UserType get typeChecked {
    _$typeCheckedAtom.reportRead();
    return super.typeChecked;
  }

  @override
  set typeChecked(UserType value) {
    _$typeCheckedAtom.reportWrite(value, super.typeChecked, () {
      super.typeChecked = value;
    });
  }

  final _$departmentsAtom = Atom(name: '_SigninState.departments');

  @override
  List<Department> get departments {
    _$departmentsAtom.reportRead();
    return super.departments;
  }

  @override
  set departments(List<Department> value) {
    _$departmentsAtom.reportWrite(value, super.departments, () {
      super.departments = value;
    });
  }

  final _$stageAtom = Atom(name: '_SigninState.stage');

  @override
  int get stage {
    _$stageAtom.reportRead();
    return super.stage;
  }

  @override
  set stage(int value) {
    _$stageAtom.reportWrite(value, super.stage, () {
      super.stage = value;
    });
  }

  final _$avatarAtom = Atom(name: '_SigninState.avatar');

  @override
  PickedFile get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(PickedFile value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  final _$_SigninStateActionController = ActionController(name: '_SigninState');

  @override
  void checkType(UserType type) {
    final _$actionInfo = _$_SigninStateActionController.startAction(
        name: '_SigninState.checkType');
    try {
      return super.checkType(type);
    } finally {
      _$_SigninStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
typeChecked: ${typeChecked},
departments: ${departments},
stage: ${stage},
avatar: ${avatar}
    ''';
  }
}
