# dec_to_bin.f
My own little stand-alone *.f file. 

One Forth word accepts a character string of arbitrary-length containing just only 0 through 9 as a decimal value. Said word allocates memory of equal character length, filling same from right to left until both values are equal. 

HEX being more compact than decimal, the allocated array will contain leading zeros. Another Forth word is therefor provided to facilitate tidy display without leading zeros. This it does by advancing the addr and reducing the count such that only the filled portion is represented.

Another Forth word exists to convert the allocated string (once filled with HEX) instead to binary. Said conversion happens in-place, overwriting the HEX.

Each colon definition has, in addition to customary stack map ( before -- after ) at top, also many a line-by-line stack map. Also many line-by-line text comments.

At end-of file is a Forth word inclosed between "0 [IF]" and "[THEN]" serving dual purposes: A) to prove out each stage of conversions and B) demonstrate usage.

A self-contained small file doing just those few things only.
