# ABSTRACT: Driver for the Hebrew tagset.
# Copyright © 2014 Dan Zeman <zeman@ufal.mff.cuni.cz>
# Copyright © 2013 Rudolf Rosa <rosa@ufal.mff.cuni.cz>

package Lingua::Interset::Tagset::HE::Conll;
use strict;
use warnings;
# VERSION: generated by DZP::OurPkgVersion

use utf8;
use open ':utf8';
use namespace::autoclean;
use Moose;
extends 'Lingua::Interset::Tagset::Conll';



#------------------------------------------------------------------------------
# Returns the tagset id that should be set as the value of the 'tagset' feature
# during decoding. Every derived class must (re)define this method! The result
# should correspond to the last two parts in package name, lowercased.
# Specifically, it should be the ISO 639-2 language code, followed by '::' and
# a language-specific tagset id. Example: 'cs::multext'.
#------------------------------------------------------------------------------
sub get_tagset_id
{
    return 'he::conll';
}



#------------------------------------------------------------------------------
# Creates atomic drivers for surface features.
#------------------------------------------------------------------------------
sub _create_atoms
{
    my $self = shift;
    my %atoms;
    # PART OF SPEECH ####################
    $atoms{pos} = $self->create_atom
    (
        'surfeature' => 'pos',
        'decode_map' =>
        {
            'n' => ['pos' => 'noun'],
            'v' => ['pos' => 'verb'],
            't' => ['pos' => 'verb', 'verbform' => 'part'],
            'a' => ['pos' => 'adj'],
            'd' => ['pos' => 'adv'],
            'l' => ['pos' => 'adj', 'prontype' => 'art'],
            'g' => ['pos' => 'part'],
            'c' => ['pos' => 'conj'],
            'r' => ['pos' => 'adp', 'adpostype' => 'prep'],
            'p' => ['pos' => 'noun', 'prontype' => 'prn'],
            'm' => ['pos' => 'num'],
            # Documentation mentions "i" (interjection) and "e" (exclamation).
            # I found only "e" in the data. So I will decode both but encode "e" only.
            'i' => ['pos' => 'int'], # interjection
            'e' => ['pos' => 'int'], # exclamation
            'u' => ['pos' => 'punc'],
            'x' => [] # unknown; sometimes also '-' is used
        },
        'encode_map' =>
        {
            'pos' => { 'noun' => { 'prontype' => { ''  => 'n',
                                                   '@' => 'p' }},
                       'verb' => { 'verbform' => { 'part' => 't',
                                                   '@'    => 'v' }},
                       'adj'  => { 'prontype' => { 'art' => 'l',
                                                   '@'   => 'a' }},
                       'adv'  => 'd',
                       'part' => 'g',
                       'conj' => 'c',
                       'adp'  => 'r',
                       'num'  => 'm',
                       'int'  => 'e',
                       'punc' => 'u',
                       '@'    => 'x' }
        }
    );
    # PERSON ####################
    $atoms{per} = $self->create_simple_atom
    (
        'intfeature' => 'person',
        'simple_decode_map' =>
        {
            '1' => '1',
            '2' => '2',
            '3' => '3'
        },
        'encode_default' => '-'
    );
    return \%atoms;
}



#------------------------------------------------------------------------------
# Creates the list of all surface CoNLL features that can appear in the FEATS
# column. This list will be used in decode().
#------------------------------------------------------------------------------
sub _create_features_all
{
    my $self = shift;
    my @features = ('pos', 'per', 'num', 'ten', 'mod', 'voi', 'gen', 'cas', 'deg');
    return \@features;
}



#------------------------------------------------------------------------------
# Creates the list of surface CoNLL features that can appear in the FEATS
# column with particular parts of speech. This list will be used in encode().
#------------------------------------------------------------------------------
sub _create_features_pos
{
    my $self = shift;
    my %features =
    (
    );
    return \%features;
}



#------------------------------------------------------------------------------
# Decodes a physical tag (string) and returns the corresponding feature
# structure.
#------------------------------------------------------------------------------
sub decode
{
    my $self = shift;
    my $tag = shift;
    my $fs = $self->decode_conll($tag);
    # Default feature values. Used to improve collaboration with other drivers.
    # ... nothing yet ...
    return $fs;
}



#------------------------------------------------------------------------------
# Takes feature structure and returns the corresponding physical tag (string).
#------------------------------------------------------------------------------
sub encode
{
    my $self = shift;
    my $fs = shift; # Lingua::Interset::FeatureStructure
    my $atoms = $self->atoms();
    my $pos = $atoms->{pos}->encode($fs);
    my $subpos = $pos;
    my $feature_names = $self->features_all();
    my $tag = $self->encode_conll($fs, $pos, $subpos, $feature_names);
    return $tag;
}



#------------------------------------------------------------------------------
# Returns reference to list of known tags.
# Tags were collected from the corpus.
#------------------------------------------------------------------------------
sub list
{
    my $self = shift;
    my $list = <<end_of_list
end_of_list
    ;
    # Protect from editors that replace tabs by spaces.
    $list =~ s/ \s+/\t/sg;
    my @list = split(/\r?\n/, $list);
    return \@list;
}



1;

=head1 SYNOPSIS

  use Lingua::Interset::Tagset::HE::Conll;
  my $driver = Lingua::Interset::Tagset::HE::Conll->new();
  my $fs = $driver->decode("NN\tNN\tM|S");

or

  use Lingua::Interset qw(decode);
  my $fs = decode('he::conll', "NN\tNN\tM|S");

=head1 DESCRIPTION

Interset driver for the Hebrew tagset in CoNLL format.
CoNLL tagsets in Interset are traditionally three values separated by tabs.
The values come from the CoNLL columns CPOS, POS and FEAT.

Tagset described in Yoav Goldberg: Automatic Syntactic Processing of Modern
Hebrew Automatic Syntactic Processing of Modern Hebrew (2011), p. 32.
TODO: try to use the official (but not as easy to process) resource:
BGU Computational Linguistics Group. Hebrew morphological tagging guidelines.
Technical report, Ben Gurion University of the Negev, 2008.
L<http://www.cs.bgu.ac.il/~adlerm/tagging-guideline.pdf>

=head1 SEE ALSO

L<Lingua::Interset>,
L<Lingua::Interset::Tagset>,
L<Lingua::Interset::Tagset::Conll>,
L<Lingua::Interset::FeatureStructure>

=cut