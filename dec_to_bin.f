\ dec_to_bin.f
\ Decimal strings of arbitray length to binary array
\ Version 2025-09-09 Copyright Gan Uesli Starling

\ Reformat addr & count sans leading zeros
: hide.zeros ( c-addr c -- c-addr c )
  DUP 0 DO       \ Iterate over array
    OVER I + C@
    0<> IF       \ 1st non-zero
      I - SWAP   \ Shorten count
      I + SWAP   \ Advance addr
      LEAVE
    THEN
  LOOP
;

\ Translate to HEX char
: nibble.to.hex ( c -- c )
    $F AND
    DUP 9 > IF 
      55          \ ASCII offset for A-F
    ELSE 
      48          \ ASCII offset for 0-9
    THEN 
    + 
;

\ Display binary array as hex where upper nibbles always all zeros.
: hex.show ( c-addr u ) \ Hex array & count
  hide.zeros            ( c-addr c )
  0 DO                  ( addr )
    DUP I + C@          ( addr c ) \ Assumed $00 thru $0F
    nibble.to.hex EMIT  \ Display lower nibble
  LOOP
 DROP
;

\ Display binary array as hex where upper nibbles not all zeros
: bin.show ( c-addr u ) \ Binary array & count
  hide.zeros            ( c-addr c )
  0 DO                  ( addr )
    DUP I + C@          ( addr c )   \ Curent byte
    DUP 4 RSHIFT        ( addr c c ) \ Upper nibble now lower
    nibble.to.hex EMIT  ( addr c )   \ Upper nibble displayed
    nibble.to.hex EMIT  ( addr )     \ Lower nibble displayed
  LOOP
 DROP

;

\ Holder for addr of binary numeric array
0 VALUE a_bin 

\ Convert decimal to hex
: num.to.hex       ( c-addr c carry_in -- c-addr c ) 
  0 2 PICK 1- DO   \ Iterate array right-to-left
    I a_bin +      ( c-addr c c addr_h )
    DUP C@ 10 *    ( c-addr c c addr_h raw )
    ROT +          ( c-addr c addr-h raw+c ) 
    DUP 16 MOD     ( c-addr c addr-h raw+c raw+c%16 )
    ROT C!         ( c-addr c raw )
    16 /           ( c-addr c carry_out )
  -1 +LOOP
  DROP
;

\ Parse string for chars, offseting from ASCII
: str.to.dec         ( c-addr c -- )
  DUP 0 DO           \ Iterate string left-to-right
    OVER I + C@ 48 - \ ASCII char to decimal number
    num.to.hex       ( c-addr c )
  LOOP
  NIP
  a_bin SWAP         ( c-addr c ) \ Contains binary
;

\ Adjust allocation reqest to align with CELLS.
: align.alloc ( u -- u )
  DUP 1 CELLS MOD 8 SWAP - + 
;

\ Consume ASCII string & count
\ Return binary array & count. Will have leading zeros.
: dec.to.hex ( c-addr c -- c-addr c ) 
  DUP align.alloc
  ALLOCATE 0= IF    ( c-addr c )
    TO a_bin            ( c-addr c ) \ Store addr
    a_bin OVER ERASE    ( c-addr c ) \ Fill with zeros
    str.to.dec          ( c-addr c -- c-addr c )
  ELSE 
    2DROP
    CR ." Oops! Memory not successfully allocated in word dec.hex. "
  THEN 
;

\ Merge adjacent zero-prefixed nibbles into bytes
\ Even adders (from right-most down) hold merged bytes.
\ Odd addrs left as found: garbage.
: hex.bin.merge   ( c-addr c -- c-addr c )
  2DUP + 1-       ( c-addr c addr )            \ Right-most adder
  OVER 1- 0 DO       ( c-addr c addr )
    DUP I -       ( c-addr c addr addr )       \ Current adder
    DUP 1-        ( c-addr c addr addr addr )  \ Addr left of current
    C@ 4 LSHIFT   ( c-addr c addr addr c )     \ Promote to high nibble
    OVER C@ OR    ( c-addr c addr addr c )     \ Two now a byte
    SWAP C!       ( c-addr c addr )            \ Store even addr
  2 +LOOP
  DROP
;

\ Squeeze out garbage-holding odd-addrs left by hex.bin.merge
: hex.bin.shrink   ( c-addr c -- c-addr c )
  2DUP + 1-        ( c-addr c addr )       \ Right-most byte
  OVER 2 / 0 DO
    DUP I -        ( c-addr c addr addr )  \ Store-to addr
    OVER I 2 * -   ( c-addr c addr addr )  \ Fetch-from addr
    C@ SWAP C!
  LOOP
  DROP
;

\ Erase garbage-holding top addrs left hex.bin.shrink
: hex.bin.clear    ( c-addr c -- c-addr c )
  DUP 2 / 1+ 0 DO  ( c-addr c )
    0 2 PICK I +   ( c-addr c 0 addr )
    C!
  LOOP
;

\ Remove the leading zero of each HEX byte.
: hex.to.bin ( c-addr c -- c-addr c )
  hex.bin.merge   \ Merge adjacent nibble-bytes into whole bytes
  hex.bin.shrink  \ Move whole bytes from even-addrs to adjacent
  hex.bin.clear   \ Zero out left-over nibble-bytes
;

\ Uncomment to test interpretation mode
\ CR S" 340193404210632335760508365704335069440" dec.bin hex.show

1 [IF] \ Set non-zero to test

  : test.dec.hex.bin
    CR CR ." Testing dec.to.hex & hex.to.bin ... "
    CR ." Reading in ASCII string below. "
    CR S" 340193404210632335760508365704335069440" 2DUP TYPE
    CR ." Converting above to hex. "
    CR ." Desired result of conversion shown as CHAR string below. "
    CR ." FFEEDDCCBBAA99887766554433221100"
    dec.to.hex
    CR 2DUP hex.show
    CR ." Actual result displayed as HEX string above. They should match. "
    CR ." Converting now from HEX string to BINARY string. "
    hex.to.bin
    CR 2DUP bin.show
    CR ." Resulting binary string displayed as HEX above. Should also match. "
    CR ." NOTES: "
    CR ." 1. Each result displayed above was of the same c-array. "
    CR ." 2. Said array was " 
    DUP align.alloc . 
    ." bytes in this instance. Array length will "
    CR ." vary since memory is ALLOCATED to hold the decimal string provided. "
    CR ." 3. Good practice calls for freeing memory when no longer needed. "
    CR ." Will now call FREE to release said " 
    align.alloc . 
    ." bytes starting at addr " DUP . CR
    FREE 0= IF ." Okay! No error reported by the word FREE. " 
    ELSE ." Oops! An error reported by FREE . " 
    THEN
    CR ." Done. " CR CR
  ;

  test.dec.hex.bin

[THEN]


