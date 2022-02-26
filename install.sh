#!/bin/bash

function exec_command() {
    ${1}
    exit_status = $(($?))
    if [ ${exit_status} -ne 0 ];then
        exit ${exit_status}
    fi
}

exec_command "apt-get install autoscan"
exec_command "apt-get install aclocal"
exec_command "apt-get install autoheader"
exec_command "apt-get install automake"
exec_command "apt-get install autoconf"
exec_command "apt-get install libtool"
exec_command "cd CUnit*"
exec_command "mv configure.in configure.ac"
exec_command "libtoolize --automake --copy --debug --force"
exec_command "automakd --add-missing"
exec_command "autoconf"
if [ -d "/usr/include/unittest" ];then
    exec_command "rm -rf /usr/include/unittest"
fi
exec_command "./configure --prefix=/usr/include/unittest"
exec_command "make"
exec_command "make install"
