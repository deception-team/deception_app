// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:deception_app/email_customization/email_customization.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const EmailCustomizationPage());
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    const incrementButtonKey = Key(
      'counterView_increment_floatingActionButton',
    );
    const decrementButtonKey = Key(
      'counterView_decrement_floatingActionButton',
    );

    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = MockCounterCubit();
    });

    tearDown(() {
      verifyMocks(counterCubit);
    });

    testWidgets('renders current count', (tester) async {
      const state = 42;
      when(counterCubit).calls(#state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: counterCubit,
          child: CounterView(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      when(counterCubit).calls(#state).thenReturn(0);
      when(counterCubit).calls(#increment).thenReturn();
      await tester.pumpApp(
        BlocProvider.value(
          value: counterCubit,
          child: CounterView(),
        ),
      );
      await tester.tap(find.byKey(incrementButtonKey));
      verify(counterCubit).called(#increment).once();
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      when(counterCubit).calls(#state).thenReturn(0);
      when(counterCubit).calls(#decrement).thenReturn();
      await tester.pumpApp(
        BlocProvider.value(
          value: counterCubit,
          child: CounterView(),
        ),
      );
      await tester.tap(find.byKey(decrementButtonKey));
      verify(counterCubit).called(#decrement).once();
    });
  });
}
