use strict;
use Test::More;
use t::Util;
use utf8;

my $textile = new_object( plugins => [qw/ SyntaxHighlight::GeSHi /] );

subtest 'bc..' => sub {
    subtest 'ascii' => sub {
        my $code = << '...';
use strict;
use warnings;

print 'hello';
...
        my $text = "bc.. $code";
        my $html = $textile->process($text);
        like $html, qr{^<pre class="text" style="font-family:monospace;">};
    };

    subtest 'with japanese' => sub {
        my $code = << '...';
use strict;
use warnings;

print 'こんにちは';
...
        my $text = "bc.. $code";
        my $html = $textile->process($text);
        like $html, qr{^<pre class="text" style="font-family:monospace;">};
    };
};

subtest 'bc[lang]..' => sub {
    subtest '-' => sub {
        my $code = << '...';
use strict;
use warnings;

print 'hello';
...
        my $text = "bc[perl].. $code";
        my $html = $textile->process($text);
        like $html, qr{^<pre class="perl" style="font-family:monospace;">};
    };
};

subtest 'bc.' => sub {
    subtest 'ascii' => sub {
        my $code = << '...';
use strict;
use warnings;

print 'hello';
...
        my $text = "bc. $code";
        my $html = $textile->process($text);
        like $html, qr{^<pre class="text" style="font-family:monospace;">};
        #like $html, qr{<p>print &#39;hello&#39;;</p>};
        like $html, qr{<p>print 'hello';</p>};
    };
};

subtest 'bc[lang].' => sub {
    subtest 'ascii' => sub {
        my $code = << '...';
use strict;
use warnings;

print 'hello';
...
        my $text = "bc[perl]. $code";
        my $html = $textile->process($text);
        like $html, qr{^<pre class="perl" style="font-family:monospace;">};
        like $html, qr{<p>print 'hello';</p>};
    };
};

done_testing;
