# dec_to_bin.f
My own little stand-alone *.f file. 

One Forth word accepts a character string of arbitrary-length containing just only 0 through 9 as a decimal value. Said word allocates memory of equal character length, filling same from right to left with ASCII HEX characters until both values are equal. 

HEX being more compact than decimal, the string in allocated memory will contain leading zeros. Another Forth word is therefor provided to facilitate tidy display without leading zeros. This it does by advancing the addr and reducing the count such that only the filled portion is thereby represented.

Another Forth word exists to convert the HEX-filled allocated memory string to binary. Said conversion happens in-place, overwriting the former HEX.

Binary being unreadable, another Forth word is provided as will display binary contents as HEX. This it does by reading a byte, then displaying its lower and upper nibbles separately as 0 thru F.

Each colon definition has, in addition to customary stack map ( before -- after ) at top-of-line, also many a line-by-line stack map. Also many line-by-line text comments.

At end-of file is a Forth word inclosed between "0 [IF]" and "[THEN]" serving dual purposes: A) to prove out each stage of conversions and B) demonstrate usage.

A self-contained small file doing just those few things only.
