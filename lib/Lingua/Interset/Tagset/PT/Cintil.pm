# ABSTRACT: Driver for the Portuguese tagset of the CINTIL corpus (Corpus Internacional do Portugu&ecir;s).
# http://cintil.ul.pt/
# Copyright © 2014 Martin Popel <popel@ufal.mff.cuni.cz>
# Copyright © 2014 Dan Zeman <zeman@ufal.mff.cuni.cz>

package Lingua::Interset::Tagset::PT::Cintil;
use strict;
use warnings;
# VERSION: generated by DZP::OurPkgVersion

use utf8;
use open ':utf8';
use namespace::autoclean;
use Moose;
extends 'Lingua::Interset::Tagset::Conll';



#------------------------------------------------------------------------------
# Creates atomic drivers for surface features.
# See http://cintil.ul.pt/cintilwhatsin.html#guidelines
#------------------------------------------------------------------------------
sub _create_atoms
{
    my $self = shift;
    my %atoms;
    # PART OF SPEECH ####################
    $atoms{pos} = $self->create_atom
    (
        'tagset' => 'pt::cintil',
        'surfeature' => 'pos',
        'decode_map' =>
        {
            # Adjective
            'ADJ'    => ['pos' => 'adj'],
            # Adverb
            'ADV'    => ['pos' => 'adv'],
            # Cardinal number
            'CARD'   => ['pos' => 'num', 'numtype' => 'card'],
            # Conjunction (e, que, como)
            'CJ'     => ['pos' => 'conj'],
            # Clitic (-se, o, -lhe)
            ###!!! Should Interset have a new feature for encliticized personal pronouns? They are not necessarily reflexive.
            'CL'     => ['pos' => 'noun', 'prontype' => 'prs', 'variant' => 'short', 'other' => {'pos' => 'clitic'}],
            # Common noun
            'CN'     => ['pos' => 'noun', 'nountype' => 'com'],
            # Definite article (o, a, os, as)
            'DA'     => ['pos' => 'adj', 'prontype' => 'art', 'definiteness' => 'def'],
            # Demonstrative pronoun or determiner
            'DEM'    => ['pos' => 'noun|adj', 'prontype' => 'dem'],
            # Denominator of a fraction
            'DFR'    => ['pos' => 'num', 'numtype' => 'frac'],
            # Roman numeral
            'DGTR'   => ['pos' => 'num', 'numform' => 'roman'],
            # Number expressed in digits
            'DGT'    => ['pos' => 'num', 'numform' => 'digit'],
            # Discourse marker "olá"
            'DM'     => ['pos' => 'int'],
            # Electronic address
            'EADR'   => ['pos' => 'noun', 'other' => {'pos' => 'url'}],
            # End of enumeration etc.
            'EOE'    => ['pos' => 'part', 'abbr' => 'abbr'],
            # Exclamation (ah, ei)
            'EXC'    => ['pos' => 'int'],
            # Gerund (sendo, afirmando, vivendo)
            'GER'    => ['pos' => 'verb', 'verbform' => 'part', 'tense' => 'pres', 'aspect' => 'prog'],
            # Gerund of an auxiliary verb in compound tenses (tendo, havendo)
            'GERAUX' => ['pos' => 'verb', 'verbtype' => 'aux', 'verbform' => 'part', 'tense' => 'pres', 'aspect' => 'prog'],
            # Indefinite article (uns, umas)
            'IA'     => ['pos' => 'adj', 'prontype' => 'art', 'definiteness' => 'ind'],
            # Indefinite pronoun or determiner (tudo, alguém, ninguém)
            'IND'    => ['pos' => 'noun|adj', 'prontype' => 'ind|neg|tot'],
            # Infinitive (ser, afirmar, viver)
            'INF'    => ['pos' => 'verb', 'verbform' => 'inf'],
            # Infinitive of an auxiliary verb in compound tenses (ter, haver)
            'INFAUX' => ['pos' => 'verb', 'verbtype' => 'aux', 'verbform' => 'inf'],
            # Interrogative pronoun, determiner or adverb (quem, como, quando)
            'INT'    => ['pos' => 'noun|adj|adv', 'prontype' => 'int'],
            # Interjection (bolas, caramba)
            'ITJ'    => ['pos' => 'int'],
            # Letter (a, b, c)
            'LTR'    => ['pos' => 'sym', 'other' => {'pos' => 'letter'}],
            # Magnitude class (unidade, dezena, dúzia, resma)
            # unidade = unit; dezena = dozen; dúzia = dozen; resma = ream = hromada
            'MGT'    => ['pos' => 'noun', 'numtype' => 'card', 'numform' => 'word'],
            # Month (Janeiro, Dezembro)
            'MTH'    => ['pos' => 'noun'],
            # Noun phrase (idem)
            'NP'     => ['pos' => 'noun', 'abbr' => 'abbr'],
            # Ordinal numeral (primeiro, centésimo, penúltimo)
            'ORD'    => ['pos' => 'adj', 'numtype' => 'ord'],
            # Part of address (rua, av., rot.)
            'PADR'   => ['pos' => 'noun'],
            # Part of name (Lisboa, António, Jo&atil;o)
            'PNM'    => ['pos' => 'noun', 'nountype' => 'prop'],
            # Punctuation (., ?, (, ))
            'PNT'    => ['pos' => 'punc'],
            # Possessive pronoun or determiner (meu, teu, seu)
            'POSS'   => ['pos' => 'adj', 'prontype' => 'prs', 'poss' => 'poss'],
            # Past participle not in compound tenses (sido, afirmados, vivida)
            'PPA'    => ['pos' => 'adj', 'verbform' => 'part', 'tense' => 'past'],
            # Prepositional phrase (algures = somewhere)
            'PP'     => ['pos' => 'adv'],
            # Past participle in compound tenses (sido, afirmado, vivido)
            'PPT'    => ['pos' => 'verb', 'verbform' => 'part', 'tense' => 'past'],
            # Preposition (de, para, em redor de)
            'PREP'   => ['pos' => 'adp', 'adptype' => 'prep'],
            # Personal pronoun (eu, tu, ele)
            'PRS'    => ['pos' => 'noun', 'prontype' => 'prs'],
            # Quantifier (todos, muitos, nenhum)
            'QNT'    => ['pos' => 'adj', 'prontype' => 'ind|tot|neg'],
            # Relative pronoun, determiner or adverb (que, cujo, tal que)
            'REL'    => ['pos' => 'noun|adj|adv', 'prontype' => 'rel'],
            # Social title (Presidente, drª., prof.)
            'STT'    => ['pos' => 'noun', 'abbr' => 'abbr'],
            # Symbol (@, #, &)
            'SYB'    => ['pos' => 'sym'],
            # Optional termination ((s), (as))
            'TERMN'  => [],
            # "um" or "uma" (they could be either indefinite articles or cardinal numerals meaning "one")
            'UM'     => ['pos' => 'adj', 'prontype' => 'art', 'definiteness' => 'ind', 'numtype' => 'card', 'numform' => 'word', 'numvalue' => '1'],
            # Abbreviated measurement unit (kg., km.)
            'UNIT'   => ['pos' => 'noun', 'abbr' => 'abbr'],
            # Finite form of an auxiliary verb in compound tenses (temos, haveriam)
            'VAUX'   => ['pos' => 'verb', 'verbtype' => 'aux', 'verbform' => 'fin'],
            # Verb (other than PPA, PPT, INF or GER) (falou, falaria)
            'V'      => ['pos' => 'verb', 'verbform' => 'fin'],
            # Day of week (segunda, terça-feira, sábado)
            'WD'     => ['pos' => 'noun']
        },
        'encode_map' =>

            { 'prontype' => { 'prs' => { 'poss' => { 'poss' => 'POSS',
                                                     '@'    => 'PRS' }},
                              'art' => { 'definiteness' => { 'def' => 'DA',
                                                             '@'   => 'IA' }},
                              'dem' => 'DEM',
                              'ind' => 'IND',
                              'neg' => 'IND',
                              'tot' => 'IND',
                              'int' => 'INT',
                              'rel' => 'REL',
                              '@'   => { 'pos' => { 'noun' => 'CN',
                                                    'adj'  => { 'verbform' => { 'part' => 'PPA',
                                                                                '@'    => 'ADJ' }},
                                                    'num'  => 'CARD',
                                                    'verb' => { 'verbtype' => { 'aux' => { 'verbform' => { 'inf'  => 'INFAUX',
                                                                                                           'ger'  => 'GERAUX',
                                                                                                           'part' => 'GERAUX',
                                                                                                           '@'    => 'VAUX' }},
                                                                                '@'   => { 'verbform' => { 'inf'  => 'INF',
                                                                                                           'ger'  => 'GER',
                                                                                                           'part' => { 'tense' => { 'pres' => 'GER',
                                                                                                                                    '@'    => 'PPT' }},
                                                                                                           '@'    => 'V' }}}},
                                                    'adv'  => 'ADV',
                                                    'adp'  => 'PREP',
                                                    'conj' => 'CJ',
                                                    'int'  => 'ITJ',
                                                    'sym'  => 'SYB' }}}}
    );
    # FEATURES ####################
    $atoms{feature} = $self->create_atom
    (
        'surfeature' => 'feature',
        'decode_map' =>
        {
            'm'    => ['gender' => 'masc'],
            'f'    => ['gender' => 'fem'],
            's'    => ['number' => 'sing'],
            'p'    => ['number' => 'plur'],
            # diminutive
            'dim'  => ['other' => {'diminutive' => 'yes'}],
            'comp' => ['degree' => 'comp'],
            'sup'  => ['degree' => 'sup'],
            '1'    => ['person' => '1'],
            '2'    => ['person' => '2'],
            '3'    => ['person' => '3'],
            # presente do indicativo
            'pi'   => ['mood' => 'ind', 'tense' => 'pres'],
            # préterito perfeito do indicativo
            'ppi'  => ['mood' => 'ind', 'tense' => 'past', 'aspect' => 'perf'],
            # préterito imperfeito do indicativo
            'ii'   => ['mood' => 'ind', 'tense' => 'past', 'aspect' => 'imp'],
            # préterito mais que perfeito do indicativo
            'mpi'  => ['mood' => 'ind', 'tense' => 'pqp', 'aspect' => 'perf'],
            # futuro do indicativo
            'fi'   => ['mood' => 'ind', 'tense' => 'fut'],
            # condicional
            'c'    => ['mood' => 'cnd'],
            # presente do conjuntivo
            'pc'   => ['mood' => 'sub', 'tense' => 'pres'],
            # préterito imperfeito do conjuntivo
            'ic'   => ['mood' => 'sub', 'tense' => 'past', 'aspect' => 'imp'],
            # futuro do conjuntivo
            'fc'   => ['mood' => 'sub', 'tense' => 'fut'],
            # imperativo
            'imp'  => ['mood' => 'imp'],
            # inflected infinitive (???)
            'ifl'  => [],
            # uninflected infinitive (???)
            'nifl' => [],
            # undocumented features that occur in the data
            'inf'  => [], # infinitive?
            'ninf' => [], # same as nifl?
            'nInf' => [], # same as nifl?
            'g'    => [], # undetermined gender?
            'n'    => [], # undetermined number?
            '?'    => [],
            '??'   => []
        },
        'encode_map' =>

            { 'pos' => '' }
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
    my @features = ('mood', 'tense', 'voice', 'number', 'person', 'degree', 'gender', 'definiteness', 'transcat', 'case', 'def', 'possessor', 'reflexive', 'register');
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
        'NC' => ['gender', 'number', 'case', 'def'],
        'NP' => ['case'],
        'AN' => ['degree', 'gender', 'number', 'case', 'def', 'transcat'],
        'AD' => ['degree', 'transcat'],
        'AC' => ['case'],
        'AO' => ['case'],
        'PC' => ['number', 'case'],
        'PD' => ['gender', 'number', 'case', 'register'],
        'PI' => ['gender', 'number', 'case', 'register'],
        'PO' => ['person', 'gender', 'number', 'case', 'possessor', 'reflexive', 'register'],
        'PP' => ['person', 'gender', 'number', 'case', 'reflexive', 'register'],
        'PT' => ['gender', 'number', 'case', 'register'],
        'RG' => ['degree'],
        'V.infin'  => ['mood', 'voice'],
        'V.indic'  => ['mood', 'tense', 'voice'],
        'V.imper'  => ['mood'],
        'V.partic' => ['mood', 'tense', 'number', 'gender', 'definiteness', 'transcat', 'case'],
        'V.trans'  => ['mood', 'tense', 'transcat'],
        'V.gerund' => ['mood', 'number', 'gender', 'definiteness', 'case']
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
    my $fs = $self->decode_conll($tag, 'da::conll');
    # Default feature values. Used to improve collaboration with other drivers.
    # Some pronoun forms can be declared accusative/oblique case.
    if($fs->prontype() eq 'prs' && !$fs->is_possessive() && $fs->case() eq '')
    {
        # Most nominative personal pronouns have case=nom. Examples: jeg (I), du (you), han (he), hun (she), vi (we), I (you), de (they).
        # Most accusative personal pronouns have case=unmarked. Examples: mig (me), dig (you), ham (him), hende (her), os (us), jer (you), dem (them), sig (oneself).
        # It is unclear what to do with 3rd person singular pronouns "den" and "det", which have case=unmarked but I suspect they can be used also as nominative.
        $fs->set_case('acc');
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
    my $atoms = $self->atoms();
    my $subpos = $atoms->{pos}->encode($fs);
    my $fpos = $subpos;
    if($fpos =~ m/^V[AE]$/)
    {
        my $verbform = $fs->verbform();
        my $surface_mood = $verbform eq 'trans' ? 'trans' : $atoms->{mood}->encode($fs);
        $fpos = "V.$surface_mood";
    }
    elsif($fpos eq 'AN')
    {
        my $transcat = $atoms->{transcat}->encode($fs);
        if($transcat eq 'adverbial')
        {
            $fpos = 'AD';
        }
    }
    my $feature_names = $self->get_feature_names($fpos);
    my $pos = $subpos =~ m/^(RG|SP)$/ ? $subpos : substr($subpos, 0, 1);
    my $tag = $self->encode_conll($fs, $pos, $subpos, $feature_names);
    return $tag;
}



#------------------------------------------------------------------------------
# Returns reference to list of known tags.
# Tags were collected from the corpus.
# 240 tag-features combinations have been observed in the sample Jo&atil;o sent
# us. Some of them are errors and were removed from our list. (We can decode
# them but we will not try to encode them.)
#------------------------------------------------------------------------------
sub list
{
    my $self = shift;
    my $list = <<end_of_list
ADJ	ADJ	fp
ADJ	ADJ	fp-comp
ADJ	ADJ	fp-sup
ADJ	ADJ	fs
ADJ	ADJ	fs-comp
ADJ	ADJ	fs-dim
ADJ	ADJ	fs-sup
ADJ	ADJ	gn
ADJ	ADJ	gp
ADJ	ADJ	gp-comp
ADJ	ADJ	gs
ADJ	ADJ	gs-comp
ADJ	ADJ	mp
ADJ	ADJ	mp-comp
ADJ	ADJ	mp-dim
ADJ	ADJ	mp-sup
ADJ	ADJ	ms
ADJ	ADJ	ms-comp
ADJ	ADJ	ms-dim
ADJ	ADJ	ms-sup
ADV	ADV	_
CARD	CARD	fp
CARD	CARD	fs
CARD	CARD	gp
CARD	CARD	mp
CARD	CARD	ms
CJ	CJ	_
CL	CL	fp3
CL	CL	fs3
CL	CL	gn13
CL	CL	gn3
CL	CL	gp2
CL	CL	gp3
CL	CL	gs1
CL	CL	gs2
CL	CL	gs3
CL	CL	mp3
CL	CL	ms3
CN	CN	PNM
CN	CN	fp
CN	CN	fp-dim
CN	CN	fs
CN	CN	fs-dim
CN	CN	gp
CN	CN	gs
CN	CN	mn
CN	CN	mp
CN	CN	mp-dim
CN	CN	ms
CN	CN	ms-dim
CN	CN	ms-sup
DA	DA	fp
DA	DA	fs
DA	DA	mp
DA	DA	ms
DEM	DEM	fp
DEM	DEM	fs
DEM	DEM	gp
DEM	DEM	gs
DEM	DEM	mp
DEM	DEM	ms
DFR	DFR	_
DGT	DGT	_
DGTR	DGTR	_
DM	DM	_
GER	GER	_
IA	IA	fp
IA	IA	mp
IND	IND	mp
IND	IND	ms
INF	INF	ifl-1p
INF	INF	ninf
INFAUX	INFAUX	ninf
INT	INT	_
ITJ	ITJ	_
LADV1	LADV1	_
LADV2	LADV2	_
LADV3	LADV3	_
LADV4	LADV4	_
LADV5	LADV5	_
LADV6	LADV6	_
LADV7	LADV7	_
LDFR1	LDFR1	_
LDFR2	LDFR2	_
LPREP1	LPREP1	_
LTR	LTR	_
MGT	MGT	mp
MTH	MTH	ms
ORD	ORD	fn
ORD	ORD	fp
ORD	ORD	fs
ORD	ORD	mn
ORD	ORD	mp
ORD	ORD	ms
PADR	PADR	fs
PADR	PADR	ms
PNT	PNT	_
POSS	POSS	fp
POSS	POSS	fs
POSS	POSS	mp
POSS	POSS	ms
PP	PP	_
PPA	PPA	fp
PPA	PPA	fs
PPA	PPA	gp
PPA	PPA	gs
PPA	PPA	mp
PPA	PPA	ms
PPT	PPT	_
PREP	PREP	_
PRS	PRS	fp3
PRS	PRS	fs3
PRS	PRS	gp1
PRS	PRS	gp2
PRS	PRS	gs1
PRS	PRS	gs2
PRS	PRS	gs3
PRS	PRS	mp1
PRS	PRS	mp3
PRS	PRS	ms1
PRS	PRS	ms3
QNT	QNT	fp
QNT	QNT	fs
QNT	QNT	gp
QNT	QNT	gs
QNT	QNT	mp
QNT	QNT	ms
REL	REL	_
REL	REL	fp
REL	REL	fs
REL	REL	gp
REL	REL	gs
REL	REL	mp
REL	REL	ms
STT	STT	fs
STT	STT	ms
SYB	SYB	_
UM	UM	fs
UM	UM	ms
V	V	GER
V	V	INF-1p
V	V	INF-3p
V	V	INF-3s
V	V	INF-nInf
V	V	PPT-gs
V	V	PPT-ms
V	V	c-1p
V	V	c-1s
V	V	c-2s
V	V	c-3p
V	V	c-3s
V	V	fc-1p
V	V	fc-2s
V	V	fc-3p
V	V	fc-3s
V	V	fi-1p
V	V	fi-1s
V	V	fi-2s
V	V	fi-3p
V	V	fi-3s
V	V	ger
V	V	ic-1p
V	V	ic-2s
V	V	ic-3p
V	V	ic-3s
V	V	ii-1p
V	V	ii-1s
V	V	ii-2s
V	V	ii-3p
V	V	ii-3s
V	V	imp-2s
V	V	inf-3p
V	V	inf-3s
V	V	inf-nInf
V	V	mpi-3s
V	V	pc-1p
V	V	pc-1s
V	V	pc-3p
V	V	pc-3s
V	V	pi-1p
V	V	pi-1s
V	V	pi-2s
V	V	pi-3p
V	V	pi-3s
V	V	ppi-1p
V	V	ppi-1s
V	V	ppi-2s
V	V	ppi-3p
V	V	ppi-3s
VAUX	VAUX	c-3p
VAUX	VAUX	c-3s
VAUX	VAUX	fi-3s
VAUX	VAUX	ic-3s
VAUX	VAUX	ii-3p
VAUX	VAUX	ii-3s
VAUX	VAUX	pc-3p
VAUX	VAUX	pc-3s
VAUX	VAUX	pi-1s
VAUX	VAUX	pi-3p
VAUX	VAUX	pi-3s
WD	WD	fs
WD	WD	mp
WD	WD	ms
end_of_list
    ;
    # Protect from editors that replace tabs by spaces.
    $list =~ s/\s+/\t/sg;
    my @list = split(/\r?\n/, $list);
    return \@list;
}



1;

=head1 SYNOPSIS

  use Lingua::Interset::Tagset::PT::Cintil;
  my $driver = Lingua::Interset::Tagset::PT::Cintil->new();
  my $fs = $driver->decode("CN\nCN\nms");

or

  use Lingua::Interset qw(decode);
  my $fs = decode('pt::cintil', "CN\nCN\nms");

=head1 DESCRIPTION

Interset driver for the Portuguese tagset of the CINTIL corpus
(Corpus Internacional do Portugu&ecir;s,
L<http://cintil.ul.pt/>).

=head1 SEE ALSO

L<http://cintil.ul.pt/cintilwhatsin.html#guidelines>

L<Lingua::Interset>,
L<Lingua::Interset::Tagset>,
L<Lingua::Interset::FeatureStructure>

=cut
