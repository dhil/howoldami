# How old am i?
A Unix utility in the `whoami`-family.

## Usage
You can eithe supply your birth date as a commandline argument
```
$ howoldami 1970-01-01
50
```
or set the environment variable `BIRTHDAY` prior to invocation of the utility
```
$ export BIRTHDAY=1970-01-01
$ howoldami
50
```
