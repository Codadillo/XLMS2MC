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
  return values[z].toString(); //get desired value from row
}

List<int> getDimensions(path) {
  final newUri = Uri.parse(path); //get Uri from file path
  final bytes = new File.fromUri(newUri).readAsBytesSync(); //read the file into bytes
  final decoder = new SpreadsheetDecoder.decodeBytes(bytes); //decode the bytes into readable spreadsheet
  final table = decoder.tables['Sheet1']; //get 2d array of first sheet
  final rows = table.rows;
  int height = rows.length;
  int width = rows[0].length;
  return [width, height];
}

void finalCommand(String path, int cornerX, int cornerY, int cornerZ) {
  List<int> zs = [];
  List<int> xs = [];
  List<String> commands = [];
  List<int> dirCons = [];
  List<String> types = [];
  List<bool> actives = [];
  print(getDimensions(path)[0].toString() + ", " + getDimensions(path)[1].toString());
  for (int z = 0; z < getDimensions(path)[0]; ++z) {
    for (int x = 0; x < getDimensions(path)[1]; ++x) {
      var content = readCell(z, x, path);
      if (content.contains(';') && content[0] != '#') {
        commands.add(decryptCBlockCom(content));
        dirCons.add(decryptCBlockDirCon(content));
        types.add(decryptCBlockType(content));
        actives.add(decryptCBlockActive(content));
        zs.add(z);
        xs.add(x);
      }
    }
  }
  print(commandFromValues(xs, [0, 0], zs, commands, dirCons, actives, types, cornerX, cornerY, cornerZ));
}


main() => finalCommand("/Users/leoconr/Downloads/Workbook1.xlsx", 2, 4, 4);