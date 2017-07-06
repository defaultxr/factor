! Copyright (C) 2013 John Benediktsson
! See http://factorcode.org/license.txt for BSD license

USING: accessors hash-sets hash-sets.wrapped kernel math
math.hashcodes parser sequences vocabs.loader ;

IN: hash-sets.numbers

ERROR: not-a-number object ;

TUPLE: number-wrapper < wrapped-key ;

C: <number-wrapper> number-wrapper

M: number-wrapper equal?
    over number-wrapper?
    [ [ underlying>> ] bi@ number= ]
    [ 2drop f ] if ; inline

M: number-wrapper hashcode*
    nip underlying>> number-hashcode ; inline

TUPLE: number-hash-set < wrapped-hash-set ;

: <number-hash-set> ( n -- shash-set )
    <hash-set> number-hash-set boa ; inline

M: number-hash-set wrap-key
    drop dup number? [ <number-wrapper> ] [ not-a-number ] if ;

M: number-hash-set clone
    underlying>> clone number-hash-set boa ; inline

: >number-hash-set ( members -- shash-set )
    [ <number-wrapper> ] map >hash-set number-hash-set boa ;

SYNTAX: NHS{ \ } [ >number-hash-set ] parse-literal ;

{ "hash-sets.numbers" "prettyprint" } "hash-sets.numbers.prettyprint" require-when
