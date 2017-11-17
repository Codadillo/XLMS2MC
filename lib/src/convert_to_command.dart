/**
 * This function takes in a string from a cell containing command block info.
 * It returns the desired command of the block.
 */
String decryptCBlockCom(String cellString) {
  final dissect = cellString.split(';'); //divorce nbt and command
  return dissect[1]; //return command
}

/**
 * This function takes in a string from a cell containing command block info.
 * It returns the type of the desired block.
 */
String decryptCBlockType(String cellString) {
  final dissect = cellString.split(';'); //divorce nbt and command
  final nbt = dissect[0].toLowerCase(); //normalize nbt
  //read nbt for type and return
  if (nbt.contains("c")) {
    return "chain";
  } else if (nbt.contains("r")) {
    return "repeating";
  }
  return "impulse";
}

/**
 * This function takes in a string from a cell containing command block info.
 * It returns the direction and conditionality of the desired block.
 */
int decryptCBlockDirCon(String cellString) {
  final dissect = cellString.split(';'); //divorce command and nbt
  final nbt = dissect[0].toLowerCase(); //normalize nbt
  int out = 0; //define output
  if (nbt.contains('i')) {
    out += 8; //brings to conditional
  } if (nbt.contains('^')) {
    out += 5; //x+
  } else if (nbt.contains('>')) {
    out += 3;//z+
  } else if (nbt.contains('<')) {
    out += 2;//z-
  } else {
    out += 4; //x-
  }
  return out;
}

/**
 * This function takes in a string from a cell containing command block info.
 * It returns whether or not the command block should be 'Always Active.'
 */
bool decryptCBlockActive(String cellString) {
  final dissect = cellString.split(';'); //divorce nbt and command
  final nbt = dissect[0].toLowerCase(); //normalize nbt
  //read for nbt and return bool
  if (nbt.contains("a")) {
    return true;
  }
  return false;
}

/**
 * This function creates a single command the creates the construction of blocks lain out in the spreadsheet.
 * It takes in arrays, where each element id corresponds to a cell of the sheet.
 * It's specific parameters are the coordinates, the command, the direction and conditionality, the poweredness, and the type of the block.
 * It returns a String with the copy and paste ready single command.
 */
String commandFromValues(final x, final y, final z, final command, final dirCon, final active, final type, int cornerX, int cornerY, int cornerZ) {
  String outputCommand = '/summon falling_block ~ ~1 ~ {'; //start the command
  String closer = ''; //start keeping track of final parenthesis in command (to comply with syntax)
  for (var i = 0; i < command.length; ++i) { //repeat for every block
    //reformat block type
    if(type[i] != 'impulse') {
      type[i] += '_';
    } else {
      type[i] = '';
    }
    //iterable mc syntax shell for data
    outputCommand += 'Block:command_block,Time:1,TileEntityData:{Command:"/setblock ' + (0-x[i]+cornerX).toString() + ' ' + (y[i]+cornerY).toString() + ' ' + (z[i]+cornerZ).toString() + ' ' + type[i] + 'command_block ' + dirCon[i].toString() + ' 0 {auto:' + active[i] + ',Command:\\"' + command[i] + '\\"}"}';
    if (i != command.length-1) {
      outputCommand += ",Passengers:[{id:falling_block,";
      closer += '}]';
    }
  }
  outputCommand += closer + '}'; //append closing parenthesis to command
  return outputCommand; //return final command
}