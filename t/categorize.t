use Test::More;

BEGIN { use_ok( 'Perl6::Classify' ); }

{
    my @list = (1, 2, 3, 4);
    my %primes = map {$_ => 1} (2, 3, 5);
    my %results = Perl6::Classify::categorize {
        my @keys = ($_ % 2 ? 'odd' : 'even'); push @keys, 'prime' if $primes{$_}; @keys
    } @list;
    is scalar keys %results, 3,  'got three values back from categorize';

    @result_keys = sort keys %results;
    is $result_keys[0], 'even',  'got correct "first" key';
    is $result_keys[1], 'odd',   'got correct "second" key';
    is $result_keys[2], 'prime', 'got correct "third" key';

    is join(',', @{$results{ $result_keys[0] }}), '2,4', 'correct values from "even" key';
    is join(',', @{$results{ $result_keys[1] }}), '1,3', 'correct values from "odd" key';
    is join(',', @{$results{ $result_keys[2] }}), '2,3', 'correct values from "prime" key';
}

{
    my %by_five = Perl6::Classify::categorize { $_ * 5 } 1, 2, 3, 4;

    is( $by_five{5}->[0],  1);
    is( $by_five{10}->[0], 2);
    is( $by_five{15}->[0], 3);
    is( $by_five{20}->[0], 4);
}

done_testing();
