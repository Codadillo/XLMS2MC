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
  final output = querySelector('#output');
  List<File> files = input.files;

  if (files.isEmpty) {
    output.text = "Woah there budy-o, you got'tsa input a fily-o";
    event.preventDefault();
  } else if (input.value.split(".")[1] != "xlsx") {
    output.text = "You must submit a file of the type '.xlsx'.";
    event.preventDefault();
  } else {
    Uint8List bytes = await readFile(files.first);
    output.text = new spreadsheetInfo(bytes).finalCommand(0, 0, 0);
    event.preventDefault();
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