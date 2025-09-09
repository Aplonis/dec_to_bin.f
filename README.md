# dec_to_bin.f
My own little stand-alone *.f file. 

It accepts a character string of arbitrary-length, allocates memory of equal length, then fills the latter with the same value represented as HEX chars.

As said allocation necessarily contains leading zeros, a word is provided to convert the address and count devoid of those.

Will also convert same hex string to binary. The same string is used for all. So must copy out if wanting HEX and BIN separately.

A small file doing just those three things only.
