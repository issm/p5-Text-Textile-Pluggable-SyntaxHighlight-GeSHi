use strict;
use Test::More;
use t::Util;

ok ! exists new_object()->{'plugin.geshi'};

my $textile = new_object( plugins => [qw/ SyntaxHighlight::GeSHi /] );
is_deeply (
    $textile->{__modules},
    [qw/ Text::Textile::Pluggable::SyntaxHighlight::GeSHi /],
);

ok exists $textile->{'plugin.geshi'};
ok exists $textile->{'plugin.geshi'}{echo};
ok exists $textile->{'plugin.geshi'}{php};
is $textile->{'plugin.geshi'}{echo}, '/bin/echo';
is $textile->{'plugin.geshi'}{php}, '/usr/bin/env php';

done_testing;
