#!/usr/bin/perl

use warnings;
use strict;
use Test::More;

my $cppcheck;
for my $check (qw|/usr/bin/cppcheck
                  /usr/local/bin/cppcheck
                 |) {
    if(-x $check) {
        $cppcheck = $check;
        last;
    }
}

plan skip_all => 'requires cppcheck' unless $cppcheck;
plan tests    => 2;

my $cmd = $cppcheck." --force --inline-suppr --template '{file}:{line},{severity},{id},{message}' -q --config-exclude=neb_module/ . 2>&1";
ok($cmd, $cmd);
my $out = `$cmd`;
chomp($out);
if($out eq "") {
    ok(1, "cppcheck: no errors detected");
} else {
    fail($out);
}
