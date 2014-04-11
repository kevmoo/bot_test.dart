library harness_console;

import 'package:unittest/unittest.dart';
import 'test_shared.dart' as shared;
import 'test_dump_render_tree.dart' as drt;

void main() {
  groupSep = ' - ';

  shared.main();
  drt.main();
}
