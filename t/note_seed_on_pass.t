#!/usr/bin/perl

# Test that the random seed is displayed verbosely when the tests pass

use strict;
use warnings;

# Ensures that our END block will come after theirs
require Test::Sims;
require Test::More;
Test::More->import;

# This is going to do the real testing
my $test = Test::Builder->create;

# This is going to be trapped
my $tb = Test::More->builder->new;

my %output = (
    tap         => '',
    err         => '',
    todo        => ''
);
$tb->output        (\$output{tap});
$tb->failure_output(\$output{err});
$tb->todo_output   (\$output{todo});

$tb->plan( tests => 1 );
pass("Passing test");


END {
    $test->plan( tests => 2 );
    $test->like( $output{tap},   qr/TEST_SIMS_SEED/ );
    $test->unlike( $output{err}, qr/TEST_SIMS_SEED/ );
}
