# XLMS2MC
### Description:
XLMS2MC is a project that allows you to use excel's powerful iterable tools to create command blocks inside a spreadsheet, and then export them to your Minecraft world.
### Spreadsheet Specifications:
To start, create a file in excel or google sheets (you just need to be able to export it into .xlms). You can name the document whatever you want, as long as you keep everything you want to export in a sheet called "Sheet1" (this is the default setting for excel and google sheets). 
The way the spreadsheet translates to minecraft is simple. The columns of the spreadsheet represent z values, and the rows represent x values (all y values are 0). For example, something in square A1 would be in block (0, 0, 0) in minecraft. Don't worry, though, you can set the position of A1 in your minecraft world to specify a start position. For example if you set A1 to be (2, 2, 2), then A2 would be (2, 2, 1). 
### Making a Command:
To specify a square as containg a command block, type a semicolon (;) in that square. Everything you type before the semicolon will customize the command block, and everything after the semicolon will be the command in the command block. Before the semicolon, there our a number of codes you can put to specify different things about the command block. These codes can be uppercase or lowercase and in no specific order. If you specify no codes, the command block will default to be impulse, facing towards -x, uncoditional, and unpowered.
#### Codes:
"C" Makes the command block a chain command block.</p>
"R" Makes the command block a repeating command block.</p>
    The command block is by default an impulse block.</p>
"I" Makes the command block conditional.</p>
"A" Makes the command block always active.</p>
"^" Makes the command block face towards +x (or up in the spreadsheet).</p>
"V" Makes the command block face towards -x (or down in the spreadhseet).</p>
">" Makes the command block face towards +z (or right in the spreadsheet).</p>
"<" Makes the command block face towards -z (or left in the spreadsheet).</p>
#### Examples:
"RAV; /say XLMS2MC is great!" Is a repeating always active command block that contains the command "/say XLMS2MC is great!" and is facing towards -x.</p>
"VCIA; /say It succeeds!!!!" Is a chain conditional always active command block that contains the command "/say it succeeds!!!!" and is facing towards -x.
