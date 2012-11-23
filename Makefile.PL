use inc::Module::Install;
name 'Text-Textile-Pluggable-SyntaxHighlight-GeSHi';
all_from 'lib/Text/Textile/Pluggable/SyntaxHighlight/GeSHi.pm';

requires 'Text::Textile::Pluggable' => '0.03';
requires 'Encode';
requires 'HTML::Entities';

tests 't/*.t';
#author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
