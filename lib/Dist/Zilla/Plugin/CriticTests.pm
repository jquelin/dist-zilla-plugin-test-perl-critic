#
# This file is part of Dist-Zilla-Plugin-CriticTests
#
# This software is copyright (c) 2009 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::CriticTests;
BEGIN {
  $Dist::Zilla::Plugin::CriticTests::VERSION = '1.111450';
}
# ABSTRACT: tests to check your code against best practices

use Moose;
use Moose::Util qw( get_all_attribute_values );

use Dist::Zilla::File::InMemory;
use Data::Section 0.004 -setup;

# and when the time comes, treat them like templates
with qw(
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::TextTemplate
);


has critic_config => (
    is      => 'ro',
    isa     => 'Maybe[Str]',
    default => 'perlcritic.rc',
);

sub gather_files {
    my ($self) = @_;

    my $data = $self->merged_section_data;
    return unless $data and %$data;

    my $stash = get_all_attribute_values( $self->meta, $self);
    $stash->{critic_config} ||= 'perlcritic.rc';

    # NB: This code is a bit generalised really, and could be forked into its
    # own plugin.
    for my $name ( keys %$data ){
        my $template = ${$data->{$name}};
        $self->add_file( Dist::Zilla::File::InMemory->new({
            name => $name,
            content => $self->fill_in_string( $template, $stash )
        }));
    }
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;



=pod

=head1 NAME

Dist::Zilla::Plugin::CriticTests - tests to check your code against best practices

=head1 VERSION

version 1.111450

=head1 SYNOPSIS

In your dist.ini:

    [CriticTests]
    critic_config = perlcritic.rc   ; relative to project root

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing
the following files:

=over 4

=item * t/author/critic.t - a standard test to check your code against best practices

=back

This plugin accept the C<critic_config> option, to specify your own config
file for L<Perl::Critic>. It defaults to C<perlcritic.rc>, relative to the
project root.

=for Pod::Coverage gather_file

=head1 AUTHOR

Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

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
Test::Perl::Critic->import( -profile => "{{ $critic_config }}" ) if -e "{{ $critic_config }}";
all_critic_ok();
