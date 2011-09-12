package Perl6::Classify;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);

our $VERSION = 0.1;

our @EXPORT_OK = qw(classify categorize);

sub classify(&@) {
    my $mapper = shift;
    my @list = @_;

    my %classified;
    for (@list) {
        my $key = $mapper->();
        push @{$classified{$key}} => $_;
    }

    return %classified;
}

sub categorize(&@) {
    my $mapper = shift;
    my @list = @_;

    my %categorized;
    for (@list) {
        for my $key ($mapper->()) {
            push @{$categorized{$key}} => $_;
        }
    }

    return %categorized;
}

1;

__END__
