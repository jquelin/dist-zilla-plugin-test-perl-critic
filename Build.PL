
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Path" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Moose::Autobox" => 0,
    "Test::DZil" => 0,
    "Test::More" => "0.94",
    "autodie" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "tests to check your code against best practices",
  "dist_author" => [
    "Jerome Quelin"
  ],
  "dist_name" => "Dist-Zilla-Plugin-Test-Perl-Critic",
  "dist_version" => "2.112410",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::Test::Perl::Critic",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Data::Section" => "0.004",
    "Dist::Zilla::File::InMemory" => 0,
    "Dist::Zilla::Role::FileGatherer" => 0,
    "Dist::Zilla::Role::TextTemplate" => 0,
    "Moose" => 0,
    "Moose::Util" => 0,
    "namespace::autoclean" => 0,
    "perl" => "5.008",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
