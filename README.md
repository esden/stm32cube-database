# This repository

This repository contains the STM32CubeMX part database. Also tracking the
historical ("olddb") data.

## Disclamer

Be cautious of the license under which these files are provided... this
repository is not official or endorsed by ST, but it is there to be a service
to developers using the STM32 ecosystem, without the need to use cumbersome
windows exe/installer digging. :)

## Versioning

The versioning of db is bit odd compared to the STM32CubeMX itself.

A STM32CubeMX version `6.9.1` results in db version `6.0.91`. See how Minor and
Patch fields are collapsed into patch. You can also find the `db` version in
`db/package.xml`.

## Updating

If you need more recent files than this repository or would like to contribute
an update this is the process of updating the `db` directory on Linux. (The
process is similar on other OS)

* Download newer version of [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
* Install STM32CubeMX
* Clone this repository: `git clone https://github.com/esden/stm32cube-database.git`
* Enter the cloned directory: `cd stm32cube-database` 
* Clear the content of the `db` directory in the repository: `rm -r db/*`
* Copy over the STM32CubeMX db files: `cp -a ~/STM32CubeMX/db/* db/`
* Add all modifications: `git add *`
* Commit the changes: `git commit -m "STM32Cube db <data.base.version>"`
