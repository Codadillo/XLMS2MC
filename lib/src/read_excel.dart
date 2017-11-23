import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'convert_to_command.dart';

/**
 * This function gets the value of a given cell in a spreadsheet.
 * It takes in coordinates of the cell and path of the workbook.
 * It returns the content of the cell in a String.
 */
class SpreadsheetInfo {
  List<int> bytes;
  SpreadsheetDecoder decoder;
  SpreadsheetTable table;
  SpreadsheetInfo(this.bytes) {
    decoder = new SpreadsheetDecoder.decodeBytes(bytes);
    table = decoder.tables.values.first;
  }

  String readCell(final z, final x) {
    final values = table.rows[x]; //get values of desired row
    return values[z].toString(); //get desired value from row
  }

  List<int> getDimensions() {
    final rows = table.rows;
    final height = rows.length;
    final width = rows[0].length;
    return [width, height];
  }

  String generateCommand(int cornerX, int cornerY, int cornerZ) {
    List<int> zs = [];
    List<int> xs = [];
    List<int> ys = [];
    List<String> commands = [];
    List<int> dirCons = [];
    List<String> types = [];
    List<bool> actives = [];
    for (int z = 0; z < getDimensions()[0]; ++z) {
      for (int x = 0; x < getDimensions()[1]; ++x) {
        var content = readCell(z, x);
        if (content.contains(';') && content[0] != '#') {
          commands.add(decryptCBlockCom(content));
          dirCons.add(decryptCBlockDirCon(content));
          types.add(decryptCBlockType(content));
          actives.add(decryptCBlockActive(content));
          zs.add(z);
          xs.add(x);
          ys.add(0);
        }
      }
    }
    return commandFromValues(xs, ys, zs, commands, dirCons, actives, types, cornerX, cornerY, cornerZ);
  }
}


