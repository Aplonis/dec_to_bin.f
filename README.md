# dec_to_bin.f
My own little stand-alone *.f file. Tested in VXF Forth, SwiftForth, and gForth.

The main Forth word, `dec.to.hex`, accepts a character string of arbitrary-length containing just only 0 through 9 as a decimal value. Said word allocates memory of equal character length, filling same from right to left with ASCII HEX characters until both values are equal. 

HEX being more compact than decimal, the string in allocated memory will contain leading zeros. Tidy display without leading zeros can be enjoyed via a second Forth word, `hide.zeros`, also provided. It consumes addr & count, returning a new addr & count such as represent the string without leading zeros. This while not affecting the string itself in any way.

A third Forth word, `hex.to.bin`, exists to convert the HEX-filled string to binary. Said conversion happens in-place, overwriting the former HEX.

Binary being unrepresentable in ASCII, yet another Forth word is provided to deal with that. Said word displays binary contents as HEX. This is accomplished by treating each byte instead as a pair of upper and lower nibbles. These it displays separately as 0 thru F. Thus for any given string, converted first to HEX characters, then afterward to binary, a display of its contents at each stage will appear identical. Provided, that is, the correct display word was employed: either `hex.show` or `bin.show`, as appropriate.

Each colon definition is copiously annotated line-by-line stack maps and comments. I need these myself for purposes of maintenance.

Finally, at end-of file is a Forth word, `test.dec.hex.bin`, serving dual purposes: A) to prove out each stage of conversion; and B) demonstrate usage.

A small file doing just those very few things only.
