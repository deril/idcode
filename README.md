# idcode

Generates random personal (identity) code of the Baltic states (Estonia, Latvia, Lithuania)

## Parameters

Program accepts country code as argument.


| Argument | Country   | Example run with docker               |
|----------|-----------|---------------------------------------|
| ee       | Estonia   | `docker run -it --rm deril/idcode ee` |
| lv       | Latvia    | `docker run -it --rm deril/idcode lv` |
| lt       | Lithuania | `docker run -it --rm deril/idcode lt` |

- Only one argument should be specified as country code
- Programm cannot be run without arguments

## Build from source

- clone this repo - `git clone https://github.com/deril/idcode.git`
- build the idcode - `cd idcode && docker build -t deril/idcode .`
- try it `docker run -it --rm deril/idcode ee` 
