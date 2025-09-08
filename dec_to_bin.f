\ dec_to_bin.f
\ Decimal strings of arbitray length to binary array
\ Version 2025-09-08 Copyright Gan Uesli Starling

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

\ Display binary array as hex
: hex.show ( addr u ) \ Binary array & count
  hide.zeros
  0 DO
    DUP I + C@    ( addr u ) 
    DUP 9 > IF 
      55          \ ASCII offset for A-F
    ELSE 
      48          \ ASCII offset for 0-9
    THEN 
    + EMIT        \ Promote to ASCII & show
  LOOP
 DROP
;

\ Holder for addr of binary numeric array
\ When allocated, will have leading zeros
\ due to column reduction dec-to-bin
0 VALUE a_bin 

\ Convert decimal to binary
: dec.to.bin       ( c-addr c carry_in -- c-addr c ) 
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
    dec.to.bin       ( c-addr c )
  LOOP
  NIP
  a_bin SWAP     ( c-addr c ) \ Contains binary
;

\ Consume ASCII string & count
\ Return binary array & count. Will have leading zeros.
: dec.bin ( c-addr c -- c-addr c ) 
  DUP ALLOCATE 0= IF    ( c-addr c )
    TO a_bin            ( c-addr c ) \ Store addr
    a_bin OVER ERASE    ( c-addr c ) \ Fill with zeros
    str.to.dec          ( c-addr c -- c-addr c )
  ELSE 
    2DROP
    CR ." Oops! Memory not allocated in word dec.bin."
  THEN 
;

\ Uncomment to test interpretation mode
\ CR S" 340193404210632335760508365704335069440" dec.bin hex.show

0 [IF] \ Set non-zero to test

  : test.dec.bin
    CR ." Testing dec.bin ..."
    CR ." Reading in ASCII string below."
    CR S" 340193404210632335760508365704335069440" 2DUP TYPE
    CR ." Converting above to binary."
    dec.bin
    CR ." Showing result as hex below."
    CR hex.show
    CR ." FFEEDDCCBBAA99887766554433221100"
    CR ." Above two lines should be identical."
    CR
  ;

  test.dec.bin

[THEN]


