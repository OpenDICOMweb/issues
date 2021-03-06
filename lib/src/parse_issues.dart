// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

/// A class that contains a [List<String>] describing errors encountered
/// when parsing a value.
class ParseIssues {
  final String type;
  final String value;
  final int start;
  final int end;
  List<String> _issues;

  ParseIssues(this.type, this.value, [this.start = 0, this.end, this._issues]);

  ParseIssues operator +(String issue) {
    add(issue);
    return this;
  }

  List<String> get issues => _issues ??= <String>[];

  bool get isEmpty => issues.length == 0;

  String get term {
    if (issues.length == 0) return "has no issues.";
    if (issues.length == 1) return "has the following issue:\n ";
    return "has the following issues:\n ";
  }

  List<String> add(String msg) {
    if (msg != "") issues.add(msg);
    return issues;
  }

  /// Check the length of a value.
  void checkLength(int length, int min, int max, [String subtype]) {
    var name = (subtype == null) ? "" : '$subtype: ';
    if (length < min)
      issues.add('$name Invalid length($length) too short - minimun($min)');
    if (length > max)
      issues.add('${name}Invalid length($length) too long - maximum($max)');
  }

  String get info => '$type "$value" $term $this';

  @override
  String toString() =>
      (issues.length == 0) ? "" : '$type:\n${issues.join('\n  ')}';
}
