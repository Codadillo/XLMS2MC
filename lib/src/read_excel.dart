import 'dart:io';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

/**
 * This function gets the value of a given cell in a spreadsheet.
 * It takes in coordinates of the cell and path of the workbook.
 * It returns the content of the cell in a String.
 */
String readCell(final z, final x, final path) { //the spreadsheet is oriented so z+ is right and x+ is up
  final newUri = Uri.parse(path); //get Uri from file path
  final bytes = new File.fromUri(newUri).readAsBytesSync(); //read the file into bytes
  final decoder = new SpreadsheetDecoder.decodeBytes(bytes); //decode the bytes into readable spreadsheet
  final table = decoder.tables['Sheet1']; //get 2d array of first sheet
  final values = table.rows[z]; //get values of desired row
  return values[x]; //get desired value from row
}
