// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CourseState on _CourseState, Store {
  final _$stateAtom = Atom(name: '_CourseState.state');

  @override
  StateLoaading get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(StateLoaading value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$dataAtom = Atom(name: '_CourseState.data');

  @override
  ObservableList<Course> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableList<Course> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
data: ${data}
    ''';
  }
}
