# dec_to_bin.f
My own little stand-alone *.f file. 

One Forth word accepts a character string of arbitrary-length containing just only 0 through 9 as a decimal value. Said word allocates memory of equal character length, filling same from right to left with ASCII HEX characters until both values are equal. 

HEX being more compact than decimal, the string in allocated memory will contain leading zeros. Another Forth word is therefor provided to facilitate tidy display without leading zeros. This it does by advancing the addr and reducing the count such that only the filled portion is thereby represented.

Another Forth word exists to convert the HEX-filled allocated memory string to binary. Said conversion happens in-place, overwriting the former HEX.

Binary being doubly more compact than HEX, twice as many leading zeros will remain in the allocated memory string. 

Binary being unrepresentable in ASCII, yet another Forth word is provided for that. It will display binary contents as HEX. This it accomplishes by treating each byte as a pair of upper and lower nibbles. These it displays separately as 0 thru F for each byte.

Each Fort word is copiously annotated with line-by-line stack map and comments. I need these myself for purposes of maintenance.

Finally, at end-of file is a Forth word serving dual purposes: A) to prove out each stage of conversion; and B) demonstrate usage.

A small file doing just those very few things only.
