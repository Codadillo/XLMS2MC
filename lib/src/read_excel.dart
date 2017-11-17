import 'dart:io';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'convert_to_command.dart';

/**
 * This function gets the value of a given cell in a spreadsheet.
 * It takes in coordinates of the cell and path of the workbook.
 * It returns the content of the cell in a String.
 */
String readCell(final z, final x, final path) { //the spreadsheet is oriented so z+ is right and x- is down, but the spreadsheet's coords are based on down being + (z, -x) = (x, y)
  final newUri = Uri.parse(path); //get Uri from file path
  final bytes = new File.fromUri(newUri).readAsBytesSync(); //read the file into bytes
  final decoder = new SpreadsheetDecoder.decodeBytes(bytes); //decode the bytes into readable spreadsheet
  final table = decoder.tables['Sheet1']; //get 2d array of first sheet
  final values = table.rows[x]; //get values of desired row
  return values[z]; //get desired value from row
}

void finalCommand(String path) {
  List<int> zs = [];
  List<int> xs = [];
  List<String> commands = [];
  List<int> dirCons = [];
  List<String> types = [];
  List<bool> actives = [];


  for (int z = 0; z < 1; ++z) {
    for (int x = 0; x < 2; ++x) {
      var content = readCell(z, x, path);
      commands.add(decryptCBlockCom(content));
      dirCons.add(decryptCBlockDirCon(content));
      types.add(decryptCBlockType(content));
      actives.add(decryptCBlockActive(content));
      zs.add(z);
      xs.add(x);
    }
  }
  print(commandFromValues(xs, [0, 0], zs, commands, dirCons, actives, types));
}

main() => finalCommand("/Users/leoconr/Downloads/Workbook1.xlsx");