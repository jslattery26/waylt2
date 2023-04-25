import 'dart:io';

class AppleScript {
  final String script;
  final Function? resultsCallback;
  const AppleScript(this.script, [this.resultsCallback]);

  Future<ProcessResult> run() async {
    return Process.run('osascript', ['-e', script]);
  }
}
