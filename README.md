# dec_to_bin.f
My own little stand-alone *.f file. 

One word accepts a character string of arbitrary-length, allocates memory for it (aligned to CELLS), then fills it with the aforementioned string. This done it iterates between the two, filling the latter with a HEX string representing the same value.

Know that conversion from decimal to HEX leaves leading zeros at the front the allocated string. A word is provided to facilitate tidy display by advancing the addr and reduce the count such that only the filled portion is represented.

Another word exists to convert that same hex string to binary in place.

Know that the self-same allocated string is iterated over throughout. And so, in order to have both HEX and binary separately afterward, you will need to copy out the HEX before converting to binary. The original decimal string is left as found.

The file is annotated with stack maps ( before -- after ) at colon definitions, plus also stack maps ( during ) inside of those defitions. These with also verbose text comments.

At end-of file is a test word serving dual purposes: A) to prove out each stage of conversions; and B) demonstrate usage.

A self-contained small file doing just those few things only.
