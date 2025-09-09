# dec_to_bin.f
My own little stand-alone *.f file. 

It accepts a character string of arbitrary-length, allocates memory of equal length (aligned to CELLS), then fills it with the same value represented as a HEX string.

After conversiont to a HEX string, leading zeros will remain. Therefor a word is provided to convert the address and count exempting of those for tidy display.

Will also convert same hex string to binary. The same string is used for all. So must copy out if wanting HEX and BIN separately.

The file is copiously annotated with stack maps ( before -- after ) and descriptive comments.

A small file doing just those three things only.
