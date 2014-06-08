library bot_test.test;

import 'package:unittest/unittest.dart';
import 'package:bot/bot.dart';
import 'package:bot_test/bot_test.dart';

void main() {
  test('throwsNullArgumentError', () {
    expect(() {
      throw new NullArgumentError('foo');
    }, throwsNullArgumentError);
  });
}
