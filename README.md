# dec_to_bin.f
My own little stand-alone *.f file. 
It accepts a character string of arbitrary-length, allocates memory of equal length, then fills the latter with the same value in binary.
As said allocation necessarily contains leading zeros, a word is provided to convert the address and count devoid of those.
A small file doing just those two things only.
