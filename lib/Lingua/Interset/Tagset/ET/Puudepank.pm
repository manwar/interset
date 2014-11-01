# ABSTRACT: Driver for the Estonian tagset from the Eesti keele puudepank (Estonian Language Treebank).
# Tag is the part of speech followed by a slash and the morphosyntactic features, separated by commas.
# Copyright © 2011, 2014 Dan Zeman <zeman@ufal.mff.cuni.cz>

package Lingua::Interset::Tagset::ET::Puudepank;
use strict;
use warnings;
# VERSION: generated by DZP::OurPkgVersion

use utf8;
use open ':utf8';
use namespace::autoclean;
use Moose;
extends 'Lingua::Interset::Tagset';



has 'atoms' => ( isa => 'HashRef', is => 'ro', builder => '_create_atoms', lazy => 1 );



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
        'tagset' => 'et::puudepank',
        'surfeature' => 'pos',
        'decode_map' =>
        {
            # n = noun (tuul, mees, kraan, riik, naine)
            'n' => ['pos' => 'noun', 'nountype' => 'com'],
            # prop = proper noun (Arnold, Lennart, Palts, Savisaar, Telia)
            'prop' => ['pos' => 'noun', 'nountype' => 'prop'],
            # art = article ###!!! DOES NOT OCCUR IN THE CORPUS
            'art' => ['pos' => 'adj', 'prontype' => 'art'],
            # v = verb (kutsutud, tahtnud, teadnud, tasunud, polnud)
            'v' => ['pos' => 'verb'],
            # v-fin = finite verb (roniti, valati, sõidutati, lahkunud, prantsatasimegi)
            'v-fin' => ['pos' => 'verb', 'verbform' => 'fin'],
            # v-inf = infinitive?/non-finite verb (lugeda, nuusutada, kiirustamata, laulmast, magama)
            'v-inf' => ['pos' => 'verb', 'verbform' => 'inf'],
            # v-pcp2 = verb participle? (sõidutatud, liigutatud, sisenenud, sõudnud, prantsatatud)
            'v-pcp2' => ['pos' => 'verb', 'verbform' => 'part'],
            # adj = adjective (suur, väike, noor, aastane, hall)
            'adj' => ['pos' => 'adj'],
            # adj-nat = nationality adjective (prantsuse, tšuktši)
            'adj-nat' => ['pos' => 'adj', 'nountype' => 'prop', 'nametype' => 'nat'],
            # adv = adverb (välja, edasi, ka, siis, maha)
            'adv' => ['pos' => 'adv'],
            # prp = preposition (juurde, taga, all, vastu, kohta)
            'prp' => ['pos' => 'adp', 'adpostype' => 'prep'],
            # pst = preposition/postposition (poole, järele, juurde, pealt, peale)
            'pst' => ['pos' => 'adp', 'adpostype' => 'post'],
            # conj-s = subordinating conjunction (et, kui, sest, nagu, kuigi)
            'conj-s' => ['pos' => 'conj', 'conjtype' => 'sub'],
            # conj-c = coordinating conjunction (ja, aga, või, vaid, a)
            'conj-c' => ['pos' => 'conj', 'conjtype' => 'coor'],
            # conj-p = prepositional conjunction ??? ###!!! DOES NOT OCCUR IN THE CORPUS
            'conj-p' => ['pos' => 'conj', 'other' => {'subpos' => 'prep'}],
            # pron = pronoun (to be specified) (pronoun type may be specified using features) (nood, sel, niisugusest, selle, sellesama)
            'pron' => ['pos' => 'noun', 'prontype' => 'prn'],
            # pron-pers = personal pronoun (ma, mina, sa, ta, tema, me, nad, nemad)
            'pron-pers' => ['pos' => 'noun', 'prontype' => 'prs'],
            # pron-rel = relative pronoun (mis, kes)
            'pron-rel' => ['pos' => 'noun', 'prontype' => 'rel'],
            # pron-int = interrogative pronoun ###!!! DOES NOT OCCUR IN THE CORPUS (is included under relative pronouns)
            'pron-int' => ['pos' => 'noun', 'prontype' => 'int'],
            # pron-dem = demonstrative pronoun (see, üks, siuke, selline, too)
            'pron-dem' => ['pos' => 'noun', 'prontype' => 'dem'],
            # pron-indef = indefinite pronoun (mõned)
            'pron-indef' => ['pos' => 'noun', 'prontype' => 'ind'],
            # pron-poss = possessive pronoun (ise)
            'pron-poss' => ['pos' => 'noun', 'prontype' => 'prs', 'poss' => 'poss'],
            # pron-def = possessive (?) pronoun (keegi, mingi)
            'pron-def' => ['pos' => 'noun', 'prontype' => 'prs', 'poss' => 'poss'],
            # pron-refl = reflexive pronoun (enda, endasse)
            'pron-refl' => ['pos' => 'noun', 'prontype' => 'prs', 'reflex' => 'reflex'],
            # num = numeral (kaks, neli, viis, seitse, kümme)
            'num' => ['pos' => 'num'],
            # intj = interjection (no, kurat)
            'intj' => ['pos' => 'int'],
            # infm = infinitive marker ###!!! DOES NOT OCCUR IN THE CORPUS
            'infm' => ['pos' => 'part', 'parttype' => 'inf'],
            # punc = punctuation (., ,, ', -, :)
            'punc' => ['pos' => 'punc'],
            # sta = statement ??? ###!!! DOES NOT OCCUR IN THE CORPUS
            # abbr = abbreviation (km/h, cm)
            'abbr' => ['abbr' => 'abbr'],
            # x = undefined word class (--, pid, viis-, ta-)
            'x' => [],
            # b = discourse particle (only in sul.xml (spoken language)) (noh, nigu, vä, nagu, ei)
            'b' => ['pos' => 'part']
        },
        'encode_map' =>

            { 'prontype' => { ''    => { 'pos' => { 'noun' => { 'nountype' => { 'prop' => 'prop',
                                                                                '@'    => 'n' }},
                                                    'adj'  => { 'nametype' => { 'nat' => 'adj-nat',
                                                                                '@'   => 'adj' }},
                                                    'num'  => 'num',
                                                    'verb' => { 'verbform' => { 'part'  => 'v-pcp2',
                                                                                'trans' => 'v-pcp2',
                                                                                'inf'   => 'v-inf',
                                                                                'fin'   => 'v-fin',
                                                                                '@'     => 'v' }},
                                                    'adv'  => 'adv',
                                                    'adp'  => { 'adpostype' => { 'post' => 'pst',
                                                                                 '@'    => 'prp' }},
                                                    'conj' => { 'conjtype' => { 'sub' => 'conj-s',
                                                                                '@'   => 'conj-c' }},
                                                    'part' => { 'parttype' => { 'inf' => 'infm',
                                                                                '@'   => 'b' }},
                                                    'int'  => 'intj',
                                                    'punc' => 'punc',
                                                    '@'    => 'x' }},
                              'prs' => { 'poss' => { 'poss' => 'pron-poss',
                                                     '@'    => 'pron-pers' }},
                              'art' => 'art',
                              # Encoding of pronoun types is inconsistent in the corpus.
                              # The type is always the first feature but sometimes it is also part of the part-of-speech tag (pron-dem/dem), next time it is not (pron/dem).
                              # We can decode pron-(dem|indef|int|rel) but we do not encode it. Our list of known tags only contains the pron/dem variant.
                              '@'   => 'pron' }}
    );
    # FEATURES ####################
    $atoms{feature} = $self->create_atom
    (
        'surfeature' => 'feature',
        'decode_map' =>
        {
        # SUBCLASS FEATURES:
        # Noun:
            # com ... common noun (tuul, mees, kraan, riik, naine)
            # nominal ... nominal abbreviation (Kaabel-TV, EE, kaabelTV) ... used rarely and inconsistently, should be ignored
            'com'   => ['nountype' => 'com'],
        # Pronoun:
            # dem ... demonstrative pronoun (see = it/this/that, üks = one, selline = that/such, too = that/such)
            # det ... pron/det: totality pronoun (iga = each/every, kõik = all)
            # det ... pron-poss/pos,det,refl: reflexive possessive pronoun (ise = oneself)
            # indef ... pron-def/indef (!) (keegi = someone/anyone, mingi = some/any)
            # indef ... pron-def/inter,rel,indef (mitu = several/many)
            # inter ... pron/inter: interrogative pronoun (mitu = how many, milline = what/which, mis = which/what)
            # inter ... pron-def/inter,rel,indef (mitu = how many/several/many)
            # inter ... pron-rel/inter,rel (kes = who)
            # pers ... pron/pers || pron-pers/pers (ma, mina = I, sa = you, ta, tema = he/she/it, me = we, nad, nemad = they)
            # rec ... pron/rec: reciprocal pronoun (üksteisele = each other)
            # refl ... pron/refl || pron-poss/pos,det,refl || pron-refl/refl: reflexive pronoun (ise = oneself, enda = own [genitive of 'ise'], oma = my/your/his/her/its/our/their)
            # rel ... pron/rel: relative pronoun (mis, kes)
            # rel ... pron-def/inter,rel,indef (mitu)
            # rel ... pron-rel/inter,rel || pron-rel/rel (mis, kes)
            'dem'   => ['prontype' => 'dem'],
            'det'   => ['prontype' => 'tot'],
            'indef' => ['prontype' => 'ind'],
            'inter' => ['prontype' => 'int'],
            'pers'  => ['prontype' => 'prs'],
            'rec'   => ['prontype' => 'rcp'],
            'refl'  => ['reflex' => 'reflex'],
            'rel'   => ['prontype' => 'rel'],
        # Numeral:
            # digit ... numeral written in digits (21, 120, 20_000, 15.40, 1875)
            # card ... cardinal numerals (kaks = two, neli = four, viis = five, seitse = seven, kümme = ten)
            # ord ... adj/ord || num/ord (esimene = first, teine = second, kolmas = third)
            'digit' => ['numform' => 'digit'],
            'card'  => ['numtype' => 'card'],
            'ord'   => ['numtype' => 'ord'],
        # Verb:
            # aux ... v/aux || v-fin/aux: auxiliary verb (ole = to be, ei = not, saaks = to)
            # mod ... v/mod || v-fin/mod: modal verb (saa = can, pean = have/need?, võib = can)
            # main ... main verb:
            # main ... v/main (teha = do, saada = get, hakata = start, pakkuda = offer, müüa = sell)
            # main ... v-fin/main (olen = I am, tatsan, sõidan = I drive, ütlen = I say, ujun = I swim)
            # main ... v-inf/main (magama = sleep, hingama = breathe, uudistama = gaze, külastama = visit, korjama = pick)
            # main ... v-pcp2/main (liikunud = moved, roninud = climbed, tilkunud = dripped, tõusnud = increased, prantsatanud = crashed)
            'main'  => [], # main is the default type of verb
            'aux'   => ['verbtype' => 'aux'],
            'mod'   => ['verbtype' => 'mod'],
        # Adposition:
            # pre ... prp/pre: preposition (vastu = against, enne = before, pärast = after, hoolimata = in spite of, üle = over)
            # post ... prp/post: postposition (mööda = along, juurde = to/by/near, taga = behind, all = under, vastu = against)
            # post ... pst/post: postposition (vahet = between, poole = to, järele = for, pealt = from, peale = after)
            'pre'   => ['adpostype' => 'prep'],
            'post'  => ['adpostype' => 'post'],
        # Conjunction:
            # crd ... conj-c/crd || conj-s/crd: coordination (ja = and, aga = but, või = or, vaid = but, ent = however)
            #         conj-c/crd,sub (kui = if/as/when/that)
            # sub ... conj-s/sub || conj-c/sub: subordination (et = that, kui = if/as/when/that, sest = because, nagu = as/like, kuigi = although)
            'crd'   => ['conjtype' => 'coor'],
            'sub'   => ['conjtype' => 'sub'],
        # Punctuation:
            # Com ... comma (,)
            # Exc ... exclamation mark (!)
            # Fst ... full stop (., ...)
            # Int ... question mark (?)
            'Com'   => ['punctype' => 'comm'],
            'Exc'   => ['punctype' => 'excl'],
            'Fst'   => ['punctype' => 'peri'],
            'Int'   => ['punctype' => 'qest'],
        # INFLECTIONAL FEATURES:
        # Number:
            # sg ... singular (abbreviations, adjectives, nouns, numerals, pronouns, proper nouns, verbs
            # pl ... plural (ditto)
            'sg'    => ['number' => 'sing'],
            'pl'    => ['number' => 'plur'],
        # Case:
            # nom ... nominative (tuul, mees, kraan, riik, naine)
            # gen ... genitive (laua, mehe, ukse, metsa, tee)
            # abes ... abessive? (aietuseta)
            # abl ... ablative (maalt, laevalt, põrandalt, teelt, näolt)
            # ad ... adessive (aastal, tänaval, hommikul, õhtul, sammul)
            # adit ... additive (koju, tuppa, linna, kööki, aeda) ... tenhle pád česká, anglická ani estonská Wikipedie estonštině nepřipisuje, ale značky Multext ho obsahují
            #    additive has the same meaning as illative, exists only for some words and only in singular
            # all ... allative (põrandala, kaldale, rinnale, koerale, külalisele)
            # el ... elative (hommikust, trepist, linnast, toast, voodist)
            # es ... essive (naisena, paratamatusena, tulemusena, montöörina, tegurina)
            # ill ... illative (voodisse, ämbrisse, sahtlisse, esikusse, autosse)
            # in ... inessive (toas, elus, unes, sadulas, lumes)
            # kom ... comitative (kiviga, jalaga, rattaga, liigutusega, petrooliga)
            # part ... partitive (vett, tundi, ust, verd, rada)
            # term ... terminative (õhtuni, mereni, ääreni, kaldani, kroonini)
            # tr ... translative (presidendiks, ajaks, kasuks, müüjaks, karjapoisiks)
            'nom'   => ['case' => 'nom'],
            'gen'   => ['case' => 'gen'],
            'abes'  => ['case' => 'abe'],
            'abl'   => ['case' => 'abl'],
            'ad'    => ['case' => 'ade'],
            'adit'  => ['case' => 'add'],
            'all'   => ['case' => 'all'],
            'el'    => ['case' => 'ela'],
            'es'    => ['case' => 'ess'],
            'ill'   => ['case' => 'ill'],
            'in'    => ['case' => 'ine'],
            'kom'   => ['case' => 'com'],
            'part'  => ['case' => 'par'],
            'term'  => ['case' => 'ter'],
            'tr'    => ['case' => 'tra'],
        # Subcategorization cases of adpositions:
            # .el, %el ... preposition requires ellative (hoolimata = in spite of)
            # .gen, %gen ... preposition requires genitive (juurde = to, taga = behind, all = under, vastu = against, kohta = for)
            # .nom, %nom ... preposition requires nominative (tagasi = back)
            # .kom, %kom ... preposition requires comitative (koos = with)
            # .part, %part ... preposition requires partitive (mööda = along, vastu = against, keset = in the middle of, piki = along, enne = before)
            '.nom'  => ['case' => 'nom'],
            '.gen'  => ['case' => 'gen'],
            '.el'   => ['case' => 'ela'],
            '.kom'  => ['case' => 'com'],
            '.part' => ['case' => 'par'],
        # Degree of comparison:
            # The feature 'pos' seems to be the only feature with multiple meanings depending on the part of speech.
            # With adjectives, it means probably 'positive degree'. With pronouns, it is probably 'possessive'.
            # pos ... adj/pos (suur = big, väike = small, noor = young, aastane = annual, hall = gray)
            # pos ... adj/pos,partic (unistav = dreamy, rahulolev = contented, kägardunud = pushed, hautatud = stew, solvatud = hurt)
            # pos ... pron/pos (oma = my/your/his/her/its/our/their)
            # pos ... pron-poss/pos (oma)
            # pos ... pron-poss/pos,det,refl (ise, enda, oma)
            # comp ... comparative (tugevam = stronger, parem = better, tõenäolisem = more likely, enam = more, suurem = greater)
            'pos'   => ['degree' => 'pos'],
            'comp'  => ['degree' => 'comp'],
        # Person:
            # ps1 ... first person (ma, mind)
            # ps2 ... second person (sind)
            # ps3 ... third person (neil, neile, nende, nad, neid, tal, talle, tema, ta)
            'ps1'   => ['person' => 1],
            'ps2'   => ['person' => 2],
            'ps3'   => ['person' => 3],
        # Personativity of verbs: is the person of the verb known? (###!!! DZ: tagset documentation missing, misinterpretation possible!)
            # ps ... (olen = I am, sõidan = I drive, ütlen = I say, ujun = I swim, liigutan = I move)
            # imps ... (räägitakse = it's said, kaalutakse = it's considered; mängiti = played, visati = thrown, eelistati = preferred, hakati = began)
        # Verb form and mood:
            # inf ... infinitive (teha, saada, hakata, pakkuda, müüa)
            # sup ... supine (informeerimata, tulemast, avaldamast, otsima, tegema)
            # partic ... adjectives and verbs ... participles (keedetud, tuntud, tunnustatud)
            # ger ... gerund (arvates, naeratades, vaadates, näidates, saabudes)
            # indic ... indicative (oli, pole, ole, on, ongi)
            # imper ... imperative (vala, sõiduta)
            # cond ... conditional (saaks, moodustaksid)
            # quot ... quotative mood (olevat, tilkuvat)
            'inf'   => ['verbform' => 'inf'],
            'sup'   => ['verbform' => 'sup'],
            'partic'=> ['verbform' => 'part'],
            'ger'   => ['verbform' => 'ger'],
            'indic' => ['verbform' => 'fin', 'mood' => 'ind'],
            'imper' => ['verbform' => 'fin', 'mood' => 'imp'],
            'cond'  => ['verbform' => 'fin', 'mood' => 'cnd'],
            'quot'  => ['verbform' => 'fin', 'mood' => 'qot'],
        # Tense:
            # pres ... present (saaks, moodustaksid, oleks, asetuks, kaalutakse)
            # past ... past (tehtud, antud, surutud, kirjutatud, arvatud)
            # impf ... imperfect (oli, käskisin, helistasin, olid, algasid)
            'pres'  => ['tense' => 'pres'],
            'past'  => ['tense' => 'past'],
            'impf'  => ['tense' => 'imp', 'aspect' => 'imp'],
        # Negativeness:
            # af ... affirmative verb (oli, saime, andsin, sain, ütlesin)
            # neg ... negative verb (ei, kutsutud, tahtnud, teadnud, polnud)
            'af'    => ['negativeness' => 'pos'],
            'neg'   => ['negativeness' => 'neg'],
        # Subcategorization of verbs:
            # .Intr, %Intr ... intransitive verb
            # .Int, %Int ... verb subcategorization? another code for intransitive?
            # .InfP, %InfP ... infinitive phrase
            # .FinV, %FinV ... finite verb
            # .NGP-P, %NGP-P ... verb subcategorization? for what?
            # .Abl, %Abl ... noun phrase in ablative
            # .All, %All ... noun phrase in allative
            # .El, %El ... noun phrase in elative
            # .Part, %Part ... noun phrase in partitive
        # l ... ordinal adjectives and cardinal and ordinal numerals; unknown meaning
        # y ... noun abbreviations? (USA, AS, EBRD, CIA, ETV)
        # ? ... abbreviations, numerals; unknown meaning
        # .? ... abbreviations, adjectives, adverbs, nouns, proper nouns; unknown meaning
        # x? ... numerals; unknown meaning
        # .cap, %cap ... capitalized word (abbreviations: KGB; adjectives: Inglise; adverbs: Siis; conj-c: Ja; nouns: Poistelt; pronouns: Meile; prop: Jane...)
        # .gi ... adjectives and nouns with the suffix '-gi' (rare feature)
        # .ja, %ja ... words with suffix '-ja' (pakkujad, vabastaja)
        # .janna ... words with suffix '-janna' (pekimägi-käskijanna)
        # .ke ... words with suffix '-ke' (aiamajakese, sammukese, klaasikese)
        # .lik ... words with suffix '-lik' (pidulikku)
        # .line ... adjectives or nouns with suffix '-line', '-lis-' (mustavereline)
        # .m ... adjectives; unknown meaning (rare feature; just one occurrence: väiksemagi)
        # .mine, %mine ... nouns with suffix '-mis-' (rare feature; nõudmised, kurtmised)
        # .nud, %nud ... words with suffix '-nud'
        # .tav, %tav ... words with suffix '-tav' (laetav, väidetavasti)
        # .tud, %tud ... words with suffix '-tud'
        # .v, %v ... participial adjectives with suffix '-v', '-va-'
        # -- ... meaning no features
        },
        'encode_map' =>

            { 'pos' => '' }
    );
    # NOUNTYPE ####################
    $atoms{nountype} = $self->create_atom
    (
        'surfeature' => 'nountype',
        'decode_map' =>
        {
            # com ... common noun (tuul, mees, kraan, riik, naine)
            'com'     => ['nountype' => 'com'],
            # nominal ... nominal abbreviation (Kaabel-TV, EE, kaabelTV) ... used rarely and inconsistently, should be ignored
            'nominal' => []
        },
        'encode_map' =>
        {
            'nountype' => { '@' => 'com' }
        }
    );
    # PRONTYPE ####################
    $atoms{prontype} = $self->create_atom
    (
        'surfeature' => 'prontype',
        'decode_map' =>
        {
            # demonstrative: sel (this), samal (the same), see (it, this), niisugune (such), too (that)
            'dem'   => ['prontype' => 'dem'],
            # total: iga (each, every, any), kõik (everything, all), mõlemad (both)
            'det'   => ['prontype' => 'tot'],
            # indefinite or negative: teised (other), midagi (nothing), üht (one), mõne (a few), keegi (one), mingi (some), mitu (several)
            'indef' => ['prontype' => 'ind|neg'],
            # interrogative: milline (what), mis (which), kes (who)
            'inter' => ['prontype' => 'int']
        },
        'encode_map' =>
        {
            'prontype' => { 'dem' => 'dem',
                            'tot' => 'det',
                            'ind' => 'indef',
                            'neg' => 'indef',
                            'int' => 'inter' }
        }
    );
    # NUMBER ####################
    $atoms{number} = $self->create_simple_atom
    (
        'intfeature' => 'number',
        'simple_decode_map' =>
        {
            # sg ... singular (abbreviations, adjectives, nouns, numerals, pronouns, proper nouns, verbs
            # pl ... plural (ditto)
            'sg' => 'sing',
            'pl' => 'plur'
        }
    );
    # CASE ####################
    $atoms{case} = $self->create_simple_atom
    (
        'intfeature' => 'case',
        'simple_decode_map' =>
        {
            # nom ... nominative (tuul, mees, kraan, riik, naine)
            # gen ... genitive (laua, mehe, ukse, metsa, tee)
            # abes ... abessive? (aietuseta)
            # abl ... ablative (maalt, laevalt, põrandalt, teelt, näolt)
            # ad ... adessive (aastal, tänaval, hommikul, õhtul, sammul)
            # adit ... additive (koju, tuppa, linna, kööki, aeda) ... tenhle pád česká, anglická ani estonská Wikipedie estonštině nepřipisuje, ale značky Multext ho obsahují
            #    additive has the same meaning as illative, exists only for some words and only in singular
            # all ... allative (põrandala, kaldale, rinnale, koerale, külalisele)
            # el ... elative (hommikust, trepist, linnast, toast, voodist)
            # es ... essive (naisena, paratamatusena, tulemusena, montöörina, tegurina)
            # ill ... illative (voodisse, ämbrisse, sahtlisse, esikusse, autosse)
            # in ... inessive (toas, elus, unes, sadulas, lumes)
            # kom ... comitative (kiviga, jalaga, rattaga, liigutusega, petrooliga)
            # part ... partitive (vett, tundi, ust, verd, rada)
            # term ... terminative (õhtuni, mereni, ääreni, kaldani, kroonini)
            # tr ... translative (presidendiks, ajaks, kasuks, müüjaks, karjapoisiks)
            'nom'  => 'nom',
            'gen'  => 'gen',
            'abes' => 'abe',
            'abl'  => 'abl',
            'ad'   => 'ade',
            'adit' => 'add',
            'all'  => 'all',
            'el'   => 'ela',
            'es'   => 'ess',
            'ill'  => 'ill',
            'in'   => 'ine',
            'kom'  => 'com',
            'part' => 'par',
            'term' => 'ter',
            'tr'   => 'tra'
        }
    );
    return \%atoms;
}



#------------------------------------------------------------------------------
# Decodes a physical tag (string) and returns the corresponding feature
# structure.
#------------------------------------------------------------------------------
sub decode
{
    my $self = shift;
    my $tag = shift;
    my $fs = Lingua::Interset::FeatureStructure->new();
    $fs->set_tagset('et::puudepank');
    my $atoms = $self->atoms();
    # Tag is the part of speech followed by a slash and the morphosyntactic features, separated by commas.
    # example: n/com,sg,nom
    my ($pos, $features) = split(/\//, $tag);
    # Two dashes are used if there are no features.
    $features = '' if($features eq '--');
    my @features = split(/,/, $features);
    $atoms->{pos}->decode_and_merge_hard($pos, $fs);
    foreach my $feature (@features)
    {
        $atoms->{feature}->decode_and_merge_hard($feature, $fs);
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
    my $pos = $atoms->{pos}->encode($fs);
    my $features = '--';
    my @feature_names = ();
    if($pos eq 'n')
    {
        @feature_names = ('nountype', 'number', 'case');
    }
    elsif($pos eq 'pron')
    {
        @feature_names = ('prontype', 'number', 'case');
    }
    my @features = ();
    foreach my $feature (@feature_names)
    {
        push(@features, $atoms->{$feature}->encode($fs));
    }
    if(@features)
    {
        $features = join(',', @features);
    }
    my $tag = "$pos/$features";
    return $tag;
}



#------------------------------------------------------------------------------
# Returns reference to list of known tags.
# Tags were collected from the corpus.
# 598 tags have been observed in the corpus.
# We removed some tags due to inconsistency between pos and features (e.g.
# conj-c/sub).
# Removed features:
# .cap, %cap ... the word starts with an uppercase letter
# .gi ... adjectives and nouns with the suffix '-gi' (rare feature)
# .ja, %ja ... words with suffix '-ja' (pakkujad, vabastaja)
# .janna ... words with suffix '-janna' (pekimägi-käskijanna)
# .ke ... words with suffix '-ke' (aiamajakese, sammukese, klaasikese)
# .lik ... words with suffix '-lik' (pidulikku)
# .line ... adjectives or nouns with suffix '-line', '-lis-' (mustavereline)
# .m ... adjectives; unknown meaning (rare feature; just one occurrence: väiksemagi)
# .mine, %mine ... nouns with suffix '-mis-' (rare feature; nõudmised, kurtmised)
# .nud, %nud ... words with suffix '-nud'
# .tav, %tav ... words with suffix '-tav' (laetav, väidetavasti)
# .tud, %tud ... words with suffix '-tud'
# .v, %v ... participial adjectives with suffix '-v', '-va-'
# 409 tags survived.
#------------------------------------------------------------------------------
sub list
{
    my $self = shift;
    my $list = <<end_of_list
abbr/?
abbr/sg,gen,.?
adj/--
adj/comp,pl,ad
adj/comp,pl,nom
adj/comp,pl,part
adj/comp,sg,gen
adj/comp,sg,nom
adj/comp,sg,tr
adj/ord,pl,in,l
adj/ord,sg,abl,l
adj/ord,sg,ad,l
adj/ord,sg,all,l
adj/ord,sg,el,l
adj/ord,sg,gen,l
adj/ord,sg,nom
adj/ord,sg,part,l
adj/ord,sg,tr,l
adj/pos
adj/pos,partic
adj/pos,pl,el
adj/pos,pl,es
adj/pos,pl,gen
adj/pos,pl,gen,partic
adj/pos,pl,ill
adj/pos,pl,in
adj/pos,pl,nom
adj/pos,pl,part
adj/pos,pl,part,partic,.?
adj/pos,pl,part,partic
adj/pos,pl,tr
adj/pos,sg,ad
adj/pos,sg,adit
adj/pos,sg,all
adj/pos,sg,all,partic
adj/pos,sg,el
adj/pos,sg,gen
adj/pos,sg,gen,partic
adj/pos,sg,ill
adj/pos,sg,ill,partic
adj/pos,sg,in
adj/pos,sg,in,partic
adj/pos,sg,nom
adj/pos,sg,nom,partic
adj/pos,sg,part
adj/pos,sg,part,partic
adj/pos,sg,tr
adj-nat/--
adv/--
adv/.?
adv/adv
adv/partic
b/--
conj-c/--
conj-c/crd
conj-c/crd,sub
conj-s/sub
intj/--
n/y
n/--
n/com,pl,abl
n/com,pl,ad
n/com,pl,all
n/com,pl,el
n/com,pl,es
n/com,pl,gen
n/com,pl,ill
n/com,pl,in
n/com,pl,in,.?
n/com,pl,kom
n/com,pl,nom
n/com,pl,nom,.?
n/com,pl,part
n/com,pl,tr
n/com,sg,abes
n/com,sg,abl
n/com,sg,ad
n/com,sg,adit
n/com,sg,ad
n/com,sg,all
n/com,sg,all,.?
n/com,sg,el
n/com,sg,el,.?
n/com,sg,es
n/com,sg,gen
n/com,sg,gen,.?
n/com,sg,ill
n/com,sg,ill,.?
n/com,sg,in
n/com,sg,in,.?
n/com,sg,kom
n/com,sg,kom,.?
n/com,sg,nom
n/com,sg,nom,.?
n/com,sg,part
n/com,sg,part,.?
n/com,sg,term
n/com,sg,tr
n/nominal,sg,nom,y
n/nominal,y
num/--
num/card,?,digit
num/card,digit
num/card,pl,ill,l
num/card,pl,nom,l
num/card,pl,part,l
num/card,sg,abl,l
num/card,sg,adit,l
num/card,sg,all,l
num/card,sg,el,l
num/card,sg,gen,l
num/card,sg,in,l
num/card,sg,kom,l
num/card,sg,nom
num/card,sg,nom,l
num/card,sg,part,l
num/card,sg,term,l
num/card,x?,digit
num/ord,digit
num/ord,sg,adit,l
num/ord,sg,ad,l
num/ord,sg,nom,l
num/ord,sg,part,l
num/ord,x?,digit
pron/dem,pl,gen
pron/dem,pl,nom
pron/dem,sg,ad
pron/dem,sg,el
pron/dem,sg,es
pron/dem,sg,gen
pron/dem,sg,kom
pron/dem,sg,nom
pron/dem,sg,part
pron/dem,sg,term
pron/dem,sg,tr
pron/det,pl,el
pron/det,pl,gen
pron/det,pl,nom
pron/det,sg,ad
pron/det,sg,all
pron/det,sg,gen
pron/det,sg,nom
pron/indef,pl,el
pron/indef,pl,gen
pron/indef,pl,nom
pron/indef,pl,part
pron/indef,sg,abl
pron/indef,sg,adit
pron/indef,sg,all
pron/indef,sg,gen
pron/indef,sg,ill
pron/indef,sg,in
pron/indef,sg,nom
pron/indef,sg,part
pron/inter,pl,nom
pron/inter,sg,gen
pron/inter,sg,nom
pron/pers,ps1,sg,nom
pron/pers,ps1,sg,part
pron/pers,ps2,sg,part
pron/pers,ps3,pl,ad
pron/pers,ps3,pl,all
pron/pers,ps3,pl,gen
pron/pers,ps3,pl,nom
pron/pers,ps3,pl,part
pron/pers,ps3,sg,ad
pron/pers,ps3,sg,all
pron/pers,ps3,sg,gen
pron/pers,ps3,sg,nom
pron-pers/pers,ps1,pl,ad
pron-pers/pers,ps1,pl,gen
pron-pers/pers,ps1,pl,nom
pron-pers/pers,ps1,pl,part
pron-pers/pers,ps1,sg,ad
pron-pers/pers,ps1,sg,all
pron-pers/pers,ps1,sg,gen
pron-pers/pers,ps1,sg,nom
pron-pers/pers,ps1,sg,part
pron-pers/pers,ps2,sg,gen
pron-pers/pers,ps2,sg,nom
pron-pers/pers,ps3,pl,el
pron-pers/pers,ps3,pl,gen
pron-pers/pers,ps3,pl,nom
pron-pers/pers,ps3,sg,ad
pron-pers/pers,ps3,sg,all
pron-pers/pers,ps3,sg,el
pron-pers/pers,ps3,sg,gen
pron-pers/pers,ps3,sg,nom
pron-pers/pers,ps3,sg,part
pron/pos,sg,gen
pron/pos,sg,kom
pron/pos,sg,nom
pron-poss/pos,det,refl,sg,ad
pron-poss/pos,det,refl,sg,all
pron-poss/pos,det,refl,sg,el
pron-poss/pos,det,refl,sg,gen
pron-poss/pos,det,refl,sg,nom
pron-poss/pos,det,refl,sg,part
pron-poss/pos,det,refl,sg,term
pron-poss/pos,sg,gen
pron/rec,sg,all
pron/refl,sg,all
pron/refl,sg,kom
pron/refl,sg,part
pron-refl/refl,sg,gen
pron-refl/refl,sg,ill
pron/rel,pl,nom
pron/rel,pl,part
pron/rel,sg,abl
pron/rel,sg,ad
pron/rel,sg,gen
pron/rel,sg,kom
pron/rel,sg,nom
pron/rel,sg,part
pron-rel/inter,rel,sg,nom
pron-rel/rel,sg,nom
prop/--
prop/prop,pl,nom,.?
prop/prop,pl,part
prop/prop,sg,abl
prop/prop,sg,adit
prop/prop,sg,ad
prop/prop,sg,all
prop/prop,sg,all,.?
prop/prop,sg,el
prop/prop,sg,gen
prop/prop,sg,gen,.?
prop/prop,sg,ill
prop/prop,sg,ill,.?
prop/prop,sg,in
prop/prop,sg,kom
prop/prop,sg,kom,.?
prop/prop,sg,nom
prop/prop,sg,nom,.?
prop/prop,sg,part
prop/prop,sg,part,.?
prop/prop,sg,tr
prp/--
prp/post
prp/post,%el
prp/post,%gen
prp/post,%nom
prp/pre
prp/pre,%el
prp/pre,%gen
prp/pre,%kom
prp/pre,.gen
prp/pre,.kom
prp/pre,.part
pst/post
pst/post,.el
pst/post,.gen
pst/post,.nom
pst/post,.part
punc/--
punc/Com
punc/Exc
punc/Fst
punc/Int
v/--
v/aux,cond,pres,ps,neg
v/aux,indic,impf,ps3,sg,ps,af
v/aux,indic,pres,ps3,sg,ps,af
v/aux,indic,pres,ps,neg
v/aux,neg
v/main,cond,pres,ps3,pl,ps,af
v/main,cond,pres,ps3,sg,ps,af
v/main,cond,pres,ps,neg
v/main,ger
v/main,ger,af,.Intr
v/main,indic,impf,imps,af
v/main,indic,impf,imps,neg
v/main,indic,impf,ps1,pl,ps,af
v/main,indic,impf,ps1,sg,ps,af
v/main,indic,impf,ps3,pl,ps,af
v/main,indic,impf,ps3,sg,ps,af
v/main,indic,impf,ps,neg
v/main,indic,impf,ps,neg,,,%InfP
v/main,indic,pres,imps,af
v/main,indic,pres,ps1,pl,ps,af
v/main,indic,pres,ps1,sg,ps,af
v/main,indic,pres,ps2,pl,ps,af
v/main,indic,pres,ps3,pl,ps,af
v/main,indic,pres,ps3,pl,ps,af,,,%All
v/main,indic,pres,ps3,sg,ps,af
v/main,indic,pres,ps,neg
v/main,inf
v/main,partic,past,imps
v/main,partic,past,ps
v/main,quot,pres,ps,af
v/main,sup,ps,abes
v/main,sup,ps,el
v/main,sup,ps,ill
v/mod,cond,pres,ps3,sg,ps,af
v/mod,cond,pres,ps,neg
v/mod,indic,impf,ps3,sg,ps,af
v/mod,indic,impf,ps,neg
v/mod,indic,pres,ps1,sg,ps,af
v/mod,indic,pres,ps3,pl,ps,af
v/mod,indic,pres,ps3,sg,ps,af
v/mod,indic,pres,ps,neg
v-fin/aux,cond,pres,ps,af,.FinV,.Intr
v-fin/aux,indic,impf,ps1,sg,ps,af,.FinV,.Intr
v-fin/aux,indic,impf,ps3,pl,ps,af,.FinV,.Intr
v-fin/aux,indic,impf,ps3,sg,ps,af,.FinV,.Intr
v-fin/aux,indic,pres,ps2,sg,ps,af,.FinV,.Intr
v-fin/aux,indic,pres,ps3,pl,ps,af,.FinV,.Intr
v-fin/aux,indic,pres,ps3,sg,ps,af,.FinV,.Intr
v-fin/main,cond,past,ps,af,.FinV,.Intr
v-fin/main,cond,pres,imps,af,.FinV,.NGP-P
v-fin/main,imper,pres,ps2,sg,ps,af,.FinV,.NGP-P
v-fin/main,indic,impf,imps,af,.FinV,.Intr
v-fin/main,indic,impf,imps,af,.FinV,.NGP-P
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV,.Intr
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV,.NGP-P
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV,.NGP-P,.Abl
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV,.NGP-P,.InfP,.El,.All
v-fin/main,indic,impf,ps1,pl,ps,af,.FinV,.Part
v-fin/main,indic,impf,ps1,sg,ps,af,.FinV
v-fin/main,indic,impf,ps1,sg,ps,af,.FinV,.Intr
v-fin/main,indic,impf,ps1,sg,ps,af,.FinV,.NGP-P
v-fin/main,indic,impf,ps1,sg,ps,af,.FinV,.NGP-P,.Abl
v-fin/main,indic,impf,ps1,sg,ps,af,.FinV,.Part
v-fin/main,indic,impf,ps2,sg,ps,af,.FinV
v-fin/main,indic,impf,ps2,sg,ps,af,.FinV,.Intr
v-fin/main,indic,impf,ps2,sg,ps,af,.FinV,.Part
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV,.InfP
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV,.Intr
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV,.NGP-P
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV,.NGP-P,.InfP,.El,.All
v-fin/main,indic,impf,ps3,pl,ps,af,.FinV,.Part
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.InfP
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.Int
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.Intr
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.Intr,.Ill
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.NGP-P
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.Part
v-fin/main,indic,impf,ps3,sg,ps,af,.FinV,.Part-P
v-fin/main,indic,impf,ps,neg,.FinV,.Intr
v-fin/main,indic,pres,imps,af,.FinV,.NGP-P
v-fin/main,indic,pres,ps1,pl,ps,af,.FinV,.Intr
v-fin/main,indic,pres,ps1,sg,ps,af,.FinV,.Intr
v-fin/main,indic,pres,ps1,sg,ps,af,.FinV,.NGP-P
v-fin/main,indic,pres,ps2,sg,ps,af,.FinV,.Intr
v-fin/main,indic,pres,ps2,sg,ps,af,.FinV,.NGP-P,.InfP
v-fin/main,indic,pres,ps3,pl,ps,af,.FinV
v-fin/main,indic,pres,ps3,pl,ps,af,.FinV,.Intr
v-fin/main,indic,pres,ps3,pl,ps,af,.FinV,.NGP-P
v-fin/main,indic,pres,ps3,pl,ps,af,.FinV,.Part
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.InfP
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.Int
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.Intr
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.NGP-P
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.NGP-P,.InfP
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.Part
v-fin/main,indic,pres,ps3,sg,ps,af,.FinV,.Part-P
v-fin/main,indic,pres,ps,neg,.FinV,.Intr
v-fin/main,indic,pres,ps,neg,.FinV,.NGP-P
v-fin/main,quot,pres,ps,af,.FinV,.Intr
v-fin/mod,indic,impf,ps3,sg,ps,af,.FinV,.sup,.NGP-P
v-fin/mod,indic,pres,ps3,sg,ps,af,.FinV,.NGP-P
v-inf/main,inf,.NGP-P
v-inf/main,inf,.Part
v-inf/main,sup,ps,abes
v-inf/main,sup,ps,el
v-inf/main,sup,ps,ill
v-inf/main,sup,ps,ill,.Intr
v-inf/main,sup,ps,ill,.Intr,.ill,.all
v-inf/main,sup,ps,ill,.NGP-P
v-inf/main,sup,ps,ill,.NGP-P,.El,.Abl
v-inf/main,sup,ps,ill,.NGP-P,.InfP
v-inf/main,sup,ps,ill,.Part
v-inf/main,sup,ps,ill,.Part-P
v-inf/main,sup,ps,ill,.Part-P,.InfP
v-inf/main,sup,ps,in,.NGP-P
v-inf/main,sup,ps,in,.NGP-P,.InfP
v-pcp2/main,partic,past,imps,.NGP-P
v-pcp2/main,partic,past,imps,.Part
v-pcp2/main,partic,past,ps
v-pcp2/main,partic,past,ps,.Intr
v-pcp2/main,partic,past,ps,.NGP-P
x/--
end_of_list
    ;
    # Protect from editors that replace tabs by spaces.
    $list =~ s/[ \t]+/\t/sg;
    my @list = split(/\r?\n/, $list);
    return \@list;
}



1;

=head1 SYNOPSIS

  use Lingua::Interset::Tagset::ET::Puudepank;
  my $driver = Lingua::Interset::Tagset::ET::Puudepank->new();
  my $fs = $driver->decode('n/com,sg,nom');

or

  use Lingua::Interset qw(decode);
  my $fs = decode('et::puudepank', 'n/com,sg,nom');

=head1 DESCRIPTION

Interset driver for the Estonian tagset from the Eesti keele puudepank (Estonian Language Treebank).
Tag is the part of speech followed by a slash and the morphosyntactic features, separated by commas.

=head1 SEE ALSO

L<Lingua::Interset>,
L<Lingua::Interset::Tagset>,
L<Lingua::Interset::FeatureStructure>

=cut
