# Weakcrypt
[![Build Status](https://travis-ci.org/maservant/Weakcrypt.svg?branch=master)](https://travis-ci.org/maservant/Weakcrypt)

## Description
This software implements the Elliptic curve ElGamal encryption scheme as
described in
[this paper](http://www.ams.org/journals/mcom/1987-48-177/S0025-5718-1987-0866109-5/)
by Neal Koblitz, and the ChaCha20 symmetric encryption system.
However, it deliberately contains a crippling weakness
that allows an adversary to decrypt any file encrypted with this software
with a common laptop and a few minutes.

__You read that right. DO NOT use this software for securing actual secret data!__

The point of this project is to show that you should NOT attempt to implement
your own crypto. Use OpenSSL, or another peer-reviewed, well implemented crypto
library to handle your secret data. Hand-written crypto is almost guaranteed to
not work properly, be easily crackable or leak data through side channels.

## Vulnerability
Let's play a little game: I will post a file containing a Bitcoin P2SH script
and the private keys that unlock its balance. First to find the weakness
decrypts the file, reads the private keys, and claims the loot.
I will fund the address with 0.03 BTC (about $25 CAD at the time of writing).

If the vulnerability is not found within 60 days, I will reclaim the coins
and post the source code of the decryption tool.

## Compiling
This software uses no libraries except stdlib, stdio and math. It should be fairly
simple to simply `cd` into the directory and run `make`.

The inline assembly is GNU-style, and the program reads from `/dev/urandom`.
If you're on Windows, you'll need to build with Cygwin to handle this.
