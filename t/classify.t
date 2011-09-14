use Test::More;

BEGIN { use_ok( 'Perl6::Classify' ); }

# stolen from rakudo's test suite:
# http://svn.pugscode.org/pugs/t/spec/S32-list/classify.t

{
    my @list = (1, 2, 3, 4);
    my %results = Perl6::Classify::classify { $_ % 2 ? 'odd' : 'even' } @list;
    is scalar keys %results, 2,  'got two values back from classify';

    @result_keys = sort keys %results;
    is $result_keys[0], 'even', 'got correct "first" key';
    is $result_keys[1], 'odd',  'got correct "second" key';

    is join(',', @{$results{ $result_keys[0] }}), '2,4', 'correct values from "even" key';
    is join(',', @{$results{ $result_keys[1] }}), '1,3', 'correct values from "odd" key';
}

{
    my %by_five = Perl6::Classify::classify { $_ * 5 } 1, 2, 3, 4;

    is( $by_five{5}->[0],  1);
    is( $by_five{10}->[0], 2);
    is( $by_five{15}->[0], 3);
    is( $by_five{20}->[0], 4);
}

done_testing();
