# Scripts

Simple utility scripts intended to make life easier when working with Tendermint RPC queries.

## Table of Contents
- [height](#height)

## height

`height.sh` is a crude script to check the height of any number of ledgers via the shell, useful for checking the
sync status of a local ledger to compare with a remote ledger.

Example usage:

```bash
chmod u+x height.sh
./height.sh 192.168.10.123 55.123.11.56
```

Or, alternatively, specify a non-default port:

```bash
./height.sh 192.168.10.123:27657 55.123.11.56
```

```bash
# Add -v flag to show verbose Curl output for debugging connections:
./height.sh -v 192.168.10.123 55.123.11.56
```

Example output:

```bash
Querying latest block height(s):

    IP				PORT	Height

[*] 192.168.10.123	26657	72839
[*] 55.123.11.56	26657	77378
```

### TODO

- I intend to expand the functionality of this to provide greater utility, likely re-implementing in Rust with better
JSON handling from Tendermint.

[Table of Contents](#table-of-contents)

