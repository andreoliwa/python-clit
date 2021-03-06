# python-clib

[![Travis CI](https://travis-ci.com/andreoliwa/python-clib.svg?branch=master)](https://travis-ci.com/andreoliwa/python-clib)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/ambv/black)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=andreoliwa/python-clib)](https://dependabot.com)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

Python CLI library, tools and scripts to help in everyday life.

## Installation

First, [install `pipx`](https://github.com/pipxproject/pipx#install-pipx).

Then install `clib` in an isolated environment:

    pipx install --spec git+https://github.com/andreoliwa/python-clib clib

## Development

You can clone the repo locally and then install it:

    cd ~/Code
    git clone https://github.com/andreoliwa/python-clib.git
    pipx install -e --spec ~/Code/python-clib/ clib

This project is not on PyPI because:

- it's not that generic;
- from the beginning, it was not built as a package to be published (it would need some adptations);
- the code is not super clean;
- it doesn't have proper tests;
- etc.

# Available commands

[backup-full](#backup-full) |
[docker-find](#docker-find) |
[docker-volume](#docker-volume) |
[pycharm-cli](#pycharm-cli) |
[pypi](#pypi) |
[postgresx](#postgresx) |
[pytestx](#pytestx)

## backup-full

    $ backup-full --help
    Usage: backup-full [OPTIONS]

      Perform all backups in a single script.

    Options:
      -n, --dry-run   Dry-run
      -k, --kill      Kill files when using rsync (--del)
      -p, --pictures  Backup pictures
      --help          Show this message and exit.

## docker-find

    $ docker-find --help
    usage: docker-find [-h] {scan,rm,ls,yml} ...

    find docker.compose.yml files

    optional arguments:
      -h, --help        show this help message and exit

    commands:
      {scan,rm,ls,yml}
        scan            scan directories and add them to the list
        rm              remove directories from the list
        ls              list yml files
        yml             choose one of the yml files to call docker-compose on

---

    $ docker-find scan --help
    usage: docker-find scan [-h] [dir [dir ...]]

    positional arguments:
      dir         directory to scan

    optional arguments:
      -h, --help  show this help message and exit

---

    $ docker-find rm --help
    usage: docker-find rm [-h] dir [dir ...]

    positional arguments:
      dir         directory to remove

    optional arguments:
      -h, --help  show this help message and exit

---

    $ docker-find ls --help
    usage: docker-find ls [-h]

    optional arguments:
      -h, --help  show this help message and exit

---

    $ docker-find yml --help
    usage: docker-find yml [-h] yml_file ...

    positional arguments:
      yml_file            partial name of the desired .yml file
      docker_compose_arg  docker-compose arguments

    optional arguments:
      -h, --help          show this help message and exit

## docker-volume

    $ docker-volume --help
    usage: docker-volume [-h] {backup,b,restore,r} ...

    backup and restore Docker volumes

    optional arguments:
      -h, --help            show this help message and exit

    commands:
      {backup,b,restore,r}
        backup (b)          backup a Docker volume
        restore (r)         restore a Docker volume

---

    $ docker-volume backup --help
    usage: docker-volume backup [-h] backup_dir volume_name [volume_name ...]

    positional arguments:
      backup_dir   directory to store the backups
      volume_name  Docker volume name

    optional arguments:
      -h, --help   show this help message and exit

---

    $ docker-volume restore --help
    usage: docker-volume restore [-h] tgz_file [volume_name]

    positional arguments:
      tgz_file     full path of the .tgz file created by the 'backup' command
      volume_name  volume name (default: basename of .tgz file)

    optional arguments:
      -h, --help   show this help message and exit

## pycharm-cli

    $ pycharm-cli --help
    Usage: pycharm-cli [OPTIONS] [FILES]...

      Invoke PyCharm on the command line.

      If a file doesn't exist, call `which` to find out the real location.

    Options:
      --help  Show this message and exit.

## pypi

    $ pypi --help
    Usage: pypi [OPTIONS] COMMAND [ARGS]...

      Commands to publish packages on PyPI.

    Options:
      --help  Show this message and exit.

    Commands:
      changelog  Preview the changelog.
      full       The full process to upload to PyPI (bump version, changelog,...

---

    $ pypi changelog --help
    Usage: pypi changelog [OPTIONS]

      Preview the changelog.

    Options:
      --help  Show this message and exit.

---

    $ pypi full --help
    Usage: pypi full [OPTIONS]

      The full process to upload to PyPI (bump version, changelog, package,
      upload).

    Options:
      -p, --part [major|minor|patch]  Which part of the version number to bump
      -d, --allow-dirty               Allow bumpversion to run on a dirty repo
      --help                          Show this message and exit.

## postgresx

    $ postgresx --help
    usage: postgresx [-h] server_uri {backup,restore} ...

    PostgreSQL helper tools

    positional arguments:
      server_uri        database server URI
                        (postgresql://user:password@server:port)

    optional arguments:
      -h, --help        show this help message and exit

    commands:
      {backup,restore}
        backup          backup a PostgreSQL database to a SQL file
        restore         restore a PostgreSQL database from a SQL file

---

    $ postgresx backup --help
    usage: postgresx [-h] server_uri {backup,restore} ...

    PostgreSQL helper tools

    positional arguments:
      server_uri        database server URI
                        (postgresql://user:password@server:port)

    optional arguments:
      -h, --help        show this help message and exit

    commands:
      {backup,restore}
        backup          backup a PostgreSQL database to a SQL file
        restore         restore a PostgreSQL database from a SQL file

---

    $ postgresx restore --help
    usage: postgresx [-h] server_uri {backup,restore} ...

    PostgreSQL helper tools

    positional arguments:
      server_uri        database server URI
                        (postgresql://user:password@server:port)

    optional arguments:
      -h, --help        show this help message and exit

    commands:
      {backup,restore}
        backup          backup a PostgreSQL database to a SQL file
        restore         restore a PostgreSQL database from a SQL file

## pytestx

    $ pytestx --help
    Usage: pytestx [OPTIONS] COMMAND [ARGS]...

      Extra commands for py.test.

    Options:
      --help  Show this message and exit.

    Commands:
      results  Parse a file with the output of failed tests, then re-run only...
      run      Run pytest with some shortcut options.

---

    $ pytestx results --help
    Usage: pytestx results [OPTIONS]

      Parse a file with the output of failed tests, then re-run only those
      failed tests.

    Options:
      -f, --result-file FILENAME
      -j, --jenkins-url TEXT
      -s                          Don't capture output
      --help                      Show this message and exit.

---

    $ pytestx run --help
    Usage: pytestx run [OPTIONS] [CLASS_NAMES_OR_ARGS]...

      Run pytest with some shortcut options.

    Options:
      -d, --delete          Delete pytest directory first
      -f, --failed          Run only failed tests
      -c, --count INTEGER   Repeat the same test several times
      -r, --reruns INTEGER  Re-run a failed test several times
      --help                Show this message and exit.
