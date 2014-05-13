library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import 'package:hop_docgen/hop_docgen.dart';
import '../test/harness_console.dart' as test_console;

void main(List<String> args) {

  addTask('test', createUnitTestTask(test_console.main));

  addTask('docs', createDocGenTask('../compiled_dartdoc_viewer'));

  //
  // Analyzer
  //
  addTask('analyze_libs', createAnalyzerTask(_getLibs));

  addTask('analyze_test_libs', createAnalyzerTask(
      ['test/harness_browser.dart', 'test/harness_console.dart']));

  //
  // Dart2js
  //
  final paths = ['test/harness_browser.dart'];

  addTask('dart2js', createDartCompilerTask(paths, liveTypeAnalysis: true));

  runHop(args);
}

Future<List<String>> _getLibs() {
  return new Directory('lib').list()
      .where((FileSystemEntity fse) => fse is File)
      .map((File file) => file.path)
      .toList();
}
