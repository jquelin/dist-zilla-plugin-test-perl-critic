use strict;
use warnings;
package Dist::Zilla::Plugin::CriticTests;
# ABSTRACT: (DEPRECATED) tests to check your code against best practices.

use Moose;
extends 'Dist::Zilla::Plugin::Test::Perl::Critic';
use namespace::autoclean;

before register_component => sub {
  warn "!!! [CriticTests] is deprecated and may be removed in the future; replace it with [Test::Perl::Critic]\n";
};

=head1 SYNOPSIS

PLEASE USE L<Dist::Zilla::Plugin::Test::Perl::Critic> instead.

This module is only a compatibility stub for that module, and should continue to work
as expected.

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
1;


