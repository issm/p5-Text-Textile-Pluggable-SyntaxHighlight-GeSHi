use inc::Module::Install;
name 'Text-Textile-Pluggable-Plugin-SyntaxHighlight-GeSHi';
all_from 'lib/Text/Textile/Pluggable/Plugin/SyntaxHighlight/GeSHi.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;