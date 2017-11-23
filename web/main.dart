import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'package:xlsx2mc/xlsx2mc.dart';



void main() {
  final copyButton = querySelector("#copy");
  final form = querySelector('#spreadsheet-form');
  form.onSubmit.listen(onFormSubmit);
  copyButton.onClick.listen(copy);
}



void copy(Event event) {
  final output = querySelector('#output') as TextAreaElement;
  document.body.nodes.addAll([querySelector("#copy"), output]);
  print("alive");
  output.select();
  document.execCommand('copy', null, "");
}

Future<Null> onFormSubmit(Event event) async {
  final inputSheet = querySelector('#file-input') as FileUploadInputElement;
  final output = querySelector('#output');
  final cornerX = int.parse((querySelector('#cornerX') as InputElement).value);
  final cornerY = int.parse((querySelector('#cornerY') as InputElement).value);
  final cornerZ = int.parse((querySelector('#cornerZ') as InputElement).value);
  List<File> files = inputSheet.files;
  event.preventDefault();
  if (files.isEmpty) {
    output.text = "Woah there budy-o, you got'tsa input a fily-o";
  } else if (inputSheet.value.split(".")[1] != "xlsx") {
    output.text = "You must submit a file of the type '.xlsx'.";
  } else {
    Uint8List bytes = await readFile(files.first);
    output.text = new SpreadsheetInfo(bytes).generateCommand(cornerX, cornerY, cornerZ);
  }
}

Future<Uint8List> readFile(Blob blob) {
  final completer = new Completer<Uint8List>();
  final reader = new FileReader();

  reader.onLoad.listen((_) => completer.complete(reader.result));
  reader.onError.listen((_) => completer.completeError(reader.error));
  reader.readAsArrayBuffer(blob);

  return completer.future;
}