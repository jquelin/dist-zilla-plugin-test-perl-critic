use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::CriticTests;
# ABSTRACT: tests to check your code against best practices

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS

In your dist.ini:

    [CriticTests]


=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing
the following files:

=over 4

=item * t/author/critic.t - a standard test to check your code against best practices

=back

This plugin does not accept any option yet.

=cut

__DATA__
___[ xt/author/critic.t ]___
#!perl

use strict;
use warnings;

use Test::More;
use English qw(-no_match_vars);

eval "use Test::Perl::Critic";
plan skip_all => 'Test::Perl::Critic required to criticise code' if $@;
all_critic_ok();
