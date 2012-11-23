package Text::Textile::Pluggable::SyntaxHighlight::GeSHi;
use 5.008001;
use strict;
use warnings;
use File::Temp qw/tempfile/;
use HTML::Entities qw/decode_entities/;
use Encode qw/encode_utf8 decode_utf8/;
our $VERSION = '0.01';

my $php_code = << '...';
<?php
include_once "geshi/geshi.php";

$file = $argv[1];
$lang = $argv[2];
$code = file_get_contents($file);

$geshi = new GeSHi($code, $lang);
$html = $geshi->parse_code();

echo $html;
?>
...

my $re_html_code = qr{<pre><code (?:\s language="([^\"]+)" )?>((?:.|\n)*?)</code></pre>}mx;

sub init {
    my $o = shift;
    $o->{'plugin.geshi'} = {
        echo => '/bin/echo',
        php  => '/usr/bin/env php',
    };
}

sub post {
    my $o    = shift;
    my $text = shift;

    my $echo = $o->{'plugin.geshi'}{echo};
    my $php  = $o->{'plugin.geshi'}{php};

    while ( my @m = $text =~ $re_html_code ) {
        my ($lang, $code) = @m;
        $lang ||= 'text';
        chomp($code = decode_entities($code));

        my ($fh, $file) = tempfile(UNLINK => 1);
        print $fh encode_utf8($code);
        close $fh;

        $text =~ s{$re_html_code}{
            decode_utf8( `$echo '$php_code' | $php -- $file $lang` );
        }ex;
    }

    return $text;
}

1;
__END__

=head1 NAME

Text::Textile::Pluggable::Plugin::SyntaxHighlight::GeSHi - Syntax highlighting plugin for Text::Textile, using GeSHI

=head1 SYNOPSIS

  use Text::Textile qw/textile/;

  my $text = << '...';
  bc[perl].
  use strict;
  use warnings;
  print 'foobar.';
  ...

  # procedural usage
  my $html = textile($text, [qw/SyntaxHighlight::GeSHi/]);

  # OOP usage
  my $textile = Text::Textile::Pluggable->new(
      plugins => [qw/SyntaxHighlight::GeSHi/],
  );
  my $html = $textile->process($text);

=head1 DESCRIPTION

Text::Textile::Pluggable::Plugin::SyntaxHighlight::GeSHi is a syntax highlighting plugin for Text::Textile, using PHP library "GeSHi".

=head1 AUTHOR

issm E<lt>issmxx@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
