use strict;
use Test::More;

my $ECHO = '/bin/echo';
my $PHP  = '/usr/bin/env php';

subtest 'echo' => sub {
    my $v = `$ECHO foobar`;
    is $v, "foobar\n";
};

subtest 'php' => sub {
    subtest 'version' => sub {
        my $v = `$PHP --version`;
        ok $v;
    };

    subtest 'check stdin' => sub {
        my $code = << '...';
<?php
echo "ok";
?>
...
        my $out = `$ECHO '$code' | $PHP --`;
        is $out, "ok\n";
    };

    subtest 'check stdin with args' => sub {
        my $code = << '...';
<?php
echo $argv[1] . ":" . $argv[2];
?>
...
        my $out = `$ECHO '$code' | $PHP -- foo bar`;
        is $out, "foo:bar\n";
    };

    subtest 'check geshi' => sub {
        my $code = << '...';
<?php
include_once "geshi/geshi.php";
echo "ok";
?>
...
        my $out = `$ECHO '$code' | $PHP --`;
        is $out, "ok\n";
    };
};

done_testing;
