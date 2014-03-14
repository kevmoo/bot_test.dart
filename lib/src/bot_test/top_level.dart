part of bot_test;

void pending() {
  fail('Not implemented');
}

final Matcher throwsInvalidOperationError =
  const Throws(const _InvalidOperationError());

final Matcher throwsNullArgumentError =
  const Throws(const _NullArgumentError());

/**
 * **DEPRECATED**
 *
 * Use [throws] or [throwsA] from `unittest` instead.
 */
@deprecated
void expectFutureFail(Future future, [void onException(error)]) {
  assert(future != null);

  final testWait = expectAsync((bool isError, result) {
    assert(isError != null);

    if(!isError) {
      fail('Expected future to throw an exception');
    }
    if(onException != null) {
      onException(result);
    }
  });
  future.then((value) => testWait(false, value), onError: (error) => testWait(true, error));
}

/**
 * **DEPRECATED**
 *
 * Use [completes] or [completion] from `unittest` instead.
 */
@deprecated
void expectFutureComplete(Future future, [Action1 onComplete]) {
  assert(future != null);

  final testWait = expectAsync((bool isError, result) {
    assert(isError != null);

    if(isError) {
      registerException(result[0], result[1]);
    }

    if(onComplete != null) {
      onComplete(result);
    }
  });
  future.then((value) => testWait(false, value), onError: (error, stack) => testWait(true, [error, stack]));
}

/**
 * **DEPRECATED**
 *
 * Use [completion] from `unittest` instead.
 */
@deprecated
Matcher finishes = const _Finishes(null);

/**
 * **DEPRECATED**
 *
 * Use [completes] from `unittest` instead.
 */
@deprecated
Matcher finishesWith(matcher) => new _Finishes(wrapMatcher(matcher));

class _Finishes extends Matcher {
  final Matcher _matcher;

  const _Finishes(this._matcher);

  @override
  bool matches(item, Map matchState) {
    if (item is! Future) return false;
    var done = wrapAsync((fn) => fn());

    item.then((value) {
      done(() { if (_matcher != null) expect(value, _matcher); });
    }, onError: (error, StackTrace stack) {
      done(() => registerException(error, stack));
    });

    return true;
  }

  @override
  Description describe(Description description) {
    if (_matcher == null) {
      description.add('completes successfully');
    } else {
      description.add('completes to a value that ').addDescriptionOf(_matcher);
    }
    return description;
  }
}

class _InvalidOperationError extends TypeMatcher {
  const _InvalidOperationError() : super("InvalidOperationException");

  @override
  bool matches(item, Map matchState) => item is InvalidOperationError;
}

class _NullArgumentError extends TypeMatcher {
  const _NullArgumentError() : super("NullArgumentException");

  @override
  bool matches(item, Map matchState) => item is NullArgumentError;
}
