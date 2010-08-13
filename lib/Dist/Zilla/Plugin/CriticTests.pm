use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::CriticTests;
# ABSTRACT: tests to check your code against best practices

use Moose;
use Moose::Util qw( get_all_attribute_values );

# this makes dzil add the sections in __DATA__ as "files"
extends 'Dist::Zilla::Plugin::InlineFiles';

# and when the time comes, treat them like templates
with qw(
    Dist::Zilla::Role::FileMunger
    Dist::Zilla::Role::TextTemplate
);


has critic_config => (
    is      => 'ro',
    isa     => 'Str',
    default => 'perlcritic.rc',
);


# there's probably a better way to get the list of files
# that were added by this plugin... patches please??
my %critic_test_filenames =
    map { $_ => 1 } __PACKAGE__->merged_section_data_names;


sub munge_file {
    my ($self, $file) = @_;

    return unless exists $critic_test_filenames{ $file->name };

    my $template = $file->content;
    my $stash    = get_all_attribute_values( $self->meta, $self);

    my $rendered = $self->fill_in_string( $template, $stash );
    $file->content( $rendered );
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
=pod

=for Pod::Coverage munge_file

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
Test::Perl::Critic->import( -profile => "{{ $critic_config }}" ) if -e {{ $critic_config }};
all_critic_ok();
