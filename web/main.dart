import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'package:xlsx2mc/xlsx2mc.dart';


void main() {
  final form = querySelector('#spreadsheet-form');
  form.onSubmit.listen(onFormSubmit);
}

Future<Null> onFormSubmit(Event event) async {
  final input = querySelector('#file-input') as FileUploadInputElement;
  List<File> files = input.files;

  if (files.isEmpty) {
    // yell at the user
  } else {
    Uint8List bytes = await readFile(files.first);
    new spreadsheetInfo(bytes).finalCommand(0, 0, 0);
  }
}

Future<Uint8List> readFile(Blob blob) {
  final completer = new Completer();
  final reader = new FileReader();

  reader.onLoad.listen((_) => completer.complete(reader.result));
  reader.onError.listen((_) => completer.completeError(reader.error));
  reader.readAsArrayBuffer(blob);

  return completer.future;
}