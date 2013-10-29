library test_bot_test;

import 'dart:async';
import 'package:unittest/unittest.dart';
import 'package:bot/bot.dart';
import 'package:bot_test/bot_test.dart';

const _failMessage = 'failing, per request';
const _successValue = 42;

void main() {
  group('bot_test', () {
    test('expectFutureComplete', _testExpectFutureComplete);
    test('expectFutureComplete with complete', _testExpectFutureCompleteWithComplete);
    test('expectFutureException', _testExpectFutureException);
    test('expectFutureException with complete', _testExpectFutureExceptionWithComplete);

    test('throwsNullArgumentError', () {
      expect(() {
        throw new NullArgumentError('foo');
      }, throwsNullArgumentError);
    });
  });
}

void _testExpectFutureComplete() {
  expectFutureComplete(_getFuture(false));

  // TODO: test the negative case as well -- not sure how to do this safely
}

void _testExpectFutureCompleteWithComplete() {
  final onComplete = expectAsync1((value) {
    expect(value, _successValue);
  });
  expectFutureComplete(_getFuture(false), onComplete);

  // TODO: test the negative case as well -- not sure how to do this safely
}

void _testExpectFutureException() {
  expectFutureFail(_getFuture(true));

  // TODO: test the negative case as well -- not sure how to do this safely
}

void _testExpectFutureExceptionWithComplete() {
  final onFail = expectAsync1((error) {
    expect(error, _failMessage);
  });
  expectFutureFail(_getFuture(true), onFail);

  // TODO: test the negative case as well -- not sure how to do this safely
}

Future _getFuture(bool shouldFail) {
  if(shouldFail) {
    return new Future.error(_failMessage);
  }
  return new Future.value(_successValue);
}
