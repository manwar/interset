# ABSTRACT: Driver for the Universal Part-of-Speech Tagset + Universal Features, version 2014-10-01, part of Universal Dependencies.
# http://universaldependencies.github.io/docs/
# Copyright © 2014 Dan Zeman <zeman@ufal.mff.cuni.cz>

package Lingua::Interset::Tagset::MUL::Uposf;
use strict;
use warnings;
# VERSION: generated by DZP::OurPkgVersion

use utf8;
use open ':utf8';
use namespace::autoclean;
use Moose;
use Lingua::Interset::FeatureStructure;
extends 'Lingua::Interset::Tagset';



has 'upos_driver' => ( isa => 'Lingua::Interset::Tagset::MUL::Upos', is => 'ro', default => new Lingua::Interset::Tagset::MUL::Upos );



#------------------------------------------------------------------------------
# Decodes a physical tag (string) and returns the corresponding feature
# structure.
#------------------------------------------------------------------------------
sub decode
{
    my $self = shift;
    my $tag = shift;
    # There are two parts separated by a tabulator: part-of-speech tag and features.
    my ($pos, $features) = split(/\t/, $tag);
    $features = '' if($features eq '_');
    my $fs = $self->upos_driver()->decode($pos);
    $fs->set_tagset('mul::uposf');
    my @features = split(/\|/, $features);
    foreach my $pair (@features)
    {
        if($pair =~ m/^(.*?)=(.*)$/)
        {
            my $feature = lc($1);
            my $value = lc($2);
            $fs->set($feature, $value);
        }
    }
    return $fs;
}



#------------------------------------------------------------------------------
# Takes feature structure and returns the corresponding physical tag (string).
#------------------------------------------------------------------------------
sub encode
{
    my $self = shift;
    my $fs = shift; # Lingua::Interset::FeatureStructure
    my $pos = $self->upos_driver()->encode($fs);
    my @features = $fs->get_ufeatures();
    my $tag;
    if(@features)
    {
        $tag = "$pos\t".join('|', @features);
    }
    else
    {
        $tag = "$pos\t_";
    }
    return $tag;
}



#------------------------------------------------------------------------------
# Returns reference to list of known tags.
# We return the list of the universal part-of-speech tags, without features.
# In future we may want to add all combinations of features observed in corpora
# of various languages.
#------------------------------------------------------------------------------
sub list
{
    my $self = shift;
    return $self->upos_driver()->list();
}



1;

=head1 SYNOPSIS

  use Lingua::Interset::Tagset::MUL::Uposf;
  my $driver = Lingua::Interset::Tagset::MUL::Uposf->new();
  my $fs = $driver->decode("NOUN\tCase=Nom|Gender=Masc|Number=Sing");

or

  use Lingua::Interset qw(decode);
  my $fs = decode('mul::uposf', "NOUN\tCase=Nom|Gender=Masc|Number=Sing");

=head1 DESCRIPTION

Interset driver for the Universal Part-of-Speech Tagset + Universal Features
as of its extended version for the Universal Dependencies (2014-10-01),
see L<http://universaldependencies.github.io/docs/>.

=head1 SEE ALSO

L<Lingua::Interset>
L<Lingua::Interset::Tagset>,
L<Lingua::Interset::Tagset::MUL::Upos>,
L<Lingua::Interset::Atom>,
L<Lingua::Interset::FeatureStructure>

=cut
