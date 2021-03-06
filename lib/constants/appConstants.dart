import 'dart:core';
import 'package:sqflite/sqflite.dart';

import '../services/getData.dart';

const String SETTINGS_SCREEN_TITLE = 'Settings';
const String ABOUT_APP_SCREEN_TITLE = 'About App';
const String ABBREVIATIONS_SCREEN_TITLE = 'Abbreviations';
const String SEARCH_SCREEN_TITLE = 'Search';
const String BROWSE_SCREEN_TITLE = 'Browse';
const String NOTIFICATION_SCREEN_TITLE = 'Notifications';
const String DONATE_SCREEN_TITLE = 'Donate';
const String MORE_APPS = 'More Apps';
const String ALL_MY_APPS = 'All Apps By Me';

const String ABOUT_APP = '''
    <br>
    <p style="text-align:center">The <i><b>Dictionary of Modern Written Arabic</b></i> is an Arabic-English dictionary compiled by 
    <a href="https://en.wikipedia.org/wiki/Hans_Wehr" title="Hans Wehr">Hans Wehr</a> and edited by 
    <a href="https://en.wikipedia.org/wiki/J_Milton_Cowan" title="J Milton Cowan">J Milton Cowan</a>.''';
const String WHATS_NEW =
    '''<p style="text-align:center"><b> What's New :</b><br>
    - Splash Screen <br>
    <a href = "https://github.com/MuslimTechNet/HansWehrDictionary/blob/master/README.md">Source Code, Full Release Notes and Future Work</a></p><br>''';
const String COMMUNITY_INVITE =
    '''<p style="text-align:center">If you are a Muslim tech professional or aspiring to be one join the <br>
    <b>Muslim Tech Network</b></p><br>''';
const String DISCORD_INVITE_LINK = 'https://discord.gg/QFKwtFC';
const String REDDIT_INVITE_LINK = 'https://www.reddit.com/r/muslimtechnet/';
const String DONATE_LINK = 'https://www.islamic-relief.org/';
const String DISCLAIMER =
    '''<p style="text-align:center"><b>DISCLAIMER - Not 100% Accurate.</b></br>
    Text was extracted from scanned pages and may have errors.</p>''';

const String CONTACT_ME = '''<p style="text-align:center"><b>CONTACT ME</b></br>
    If you have an idea for an app or have a job offer <br><a href = "mailto: gibreel.khan@gmail.com">gibreel.khan@gmail.com</a><br></p><br>''';

const String COURTSEY = '''<p style="text-align:center"><b>COURTSEY</b>
    <ul>
      <li><a href="https://github.com/jamalosman/hanswehr-app">Jamal Osman and Muhammad Abdurrahman</a> for the digitisation of the dictionary.
      <li><a href="https://corpus.quran.com/">Quran.com</a> for their word-by-word breakdown of Quranic text</li>
    </ul>
    </p><br>''';
final DatabaseAccess databaseObject = new DatabaseAccess();
final Future<Database> databaseConnection =
    DatabaseAccess().openDatabaseConnection();

const String LANE_LEXICON_ANDROID_LINK =
    'https://play.google.com/store/apps/details?id=com.muslimtechnet.lanelexicon';

const String HANS_WEHR_ANDROID_LINK =
    'https://play.google.com/store/apps/details?id=com.muslimtechnet.hanswehr';

const List<String> VERB_FORMS = [
  'I - فَعَل/فَعُل/فَعِل',
  'II - فَعّل',
  'III - فَاعَل',
  'IV - أَفْعَل',
  'V - تَفَعّل',
  'VI - تَفَاعَل',
  'VII - اِنْفَعَل',
  'VIII - اِفْتَعَل',
  'IX - اِفْعَل',
  'X - اِسْتَفْعَل',
];

const List<String> VERB_FORM_DESCRIPTIONS = [
  'Basic root',
  'Doing something intensively/ repeatedly, doing or causing something to someone else',
  'To try to do something, to do something with someone else',
  'Transitive, immediate, doing something to other/ someone else, causing something ',
  'Doing something intensively/ repeatedly, doing or causing something to yourself',
  'Doing something with each other, to pretend to do something, expressing a state ',
  'Intransitive, Passive meaning ',
  'No consistent meaning pattern, being in a state of something ',
  'Used for colors or defects',
  'To seek or ask something, wanting, trying',
];

const List<String> VERB_FORM_EXAMPLES = [
  'غفر - He forgave',
  'علّم - He taught',
  'قاتل - He fought',
  'اخرج - He took out',
  'توكّل - He trusted',
  'تعاون - He cooperated',
  'اِنْفَقلب - He overturned',
  'اِختلف - He differed',
  'اِحمرّ - He became red',
  'اِسْتَغفر - He sought forgiveness',
];

const List<String> ALL_ALPHABETS = [
  "آ",
  "ا",
  "ب",
  "ت",
  "ث",
  "ج",
  "ح",
  "خ",
  "د",
  "ذ",
  "ر",
  "ز",
  "س",
  "ش",
  "ص",
  "ض",
  "ط",
  "ظ",
  "ع",
  "غ",
  "ف",
  "ق",
  "ك",
  "ل",
  "م",
  "ن",
  "ه",
  "و",
  "ي"
];

const List<String> ABBREVIATIONS = [
  "A",
  "abstr.",
  "acc.",
  "A.D.",
  "adj.",
  "adm.",
  "adv.",
  "A.H.",
  "Alg.",
  "alg.",
  "a.m.",
  "anat.",
  "approx.",
  "arch.",
  "archeol.",
  "arith.",
  "astron.",
  "athlet.",
  "B",
  "biol.",
  "bot.",
  "Brit.",
  "C",
  "ca.",
  "caus.",
  "cf.",
  "chem.",
  "Chr.",
  "coll.",
  "colloq.",
  "com.",
  "conj.",
  "constr.-eng.",
  "Copt.",
  "cosm.",
  "D",
  "dam.",
  "def.",
  "dem.",
  "dial.",
  "dimin.",
  "dipl.",
  "do.",
  "E",
  "E",
  "econ.",
  "Eg.",
  "eg.",
  "e.g.",
  "el.",
  "ellipt.",
  "Engl.",
  "esp.",
  "ethnol.",
  "F",
  "f.",
  "fem.",
  "fig.",
  "fin.",
  "foll.",
  "Fr.",
  "G",
  "G.",
  "G.B.",
  "genit.",
  "geogr.",
  "geom.",
  "Gr.",
  "gram.",
  "H",
  "Hebr.",
  "hij.",
  "hort.",
  "I",
  "i.e.",
  "imp.",
  "imperf.",
  "indef.",
  "interj.",
  "Intern. Law",
  "intr.",
  "Ir.",
  "ir.",
  "Isl.",
  "It.",
  "J",
  "Jord.",
  "journ.",
  "Jud.",
  "jur.",
  "L",
  "Leb.",
  "leb.",
  "lex.",
  "lit",
  "M",
  "m.",
  "magn.",
  "Magr.",
  "Magr.",
  "maso.",
  "math",
  "med.",
  "mil.",
  "min.",
  "Mor.",
  "mor.",
  "mus.",
  "myst.",
  "N",
  "N",
  "n.",
  "N.Afr",
  "NE",
  "naut.",
  "neg.",
  "nom.",
  "n. un.",
  "n. vic.",
  "NW",
  "O",
  "obi.",
  "opt.",
  "o.s.",
  "Ott.",
  "P",
  "Pal.",
  "pal.",
  "parl.",
  "part.",
  "pass.",
  "path.",
  "perf.",
  "pers.",
  "pers.",
  "pharm.",
  "philos.",
  "phon.",
  "phot.",
  "phys.",
  "physiol.",
  "pl.",
  "pl. comm.",
  "p.m.",
  "poet.",
  "pol.",
  "prep.",
  "pron.",
  "psych.",
  "Q",
  "q.v.",
  "R",
  "refl.",
  "rel.",
  "relig.",
  "rhet.",
  "S",
  "S",
  "Saudi Ar.",
  "saud.-ar.",
  "SE",
  "sing.",
  "s.o.",
  "Span.",
  "specif.",
  "s.th.",
  "styl.",
  "subj.",
  "subst.",
  "surg.",
  "SW",
  "Syr.",
  "syr.",
  "T",
  "techn.",
  "tel.",
  "temp.",
  "theat.",
  "theol.",
  "trans.",
  "Tun.",
  "tun.",
  "Turk.",
  "typ.",
  "U",
  "U.A.R.",
  "uninfl.",
  "V",
  "verb.",
  "W",
  "W",
  "Y",
  "Yem.",
  "yem.",
  "Z",
  "zool.",
];
const List<String> FULL_FORM = [
  "",
  "abstract",
  "accusative",
  "anno Domini",
  "adjective",
  "administration",
  "adverb",
  "year of the Hegira",
  "Algeria",
  "Algerian",
  "ante meridiem",
  "anatomy",
  "approximately",
  "architecture",
  "archeology",
  "arithmetic",
  "astronomy",
  "athletics",
  "",
  "biology",
  "botany",
  "British",
  "",
  "circa, about",
  "causative",
  "compare",
  "chemistry",
  "Christian",
  "collective",
  "colloquial",
  "commerce",
  "conjunction",
  "construction engineering",
  "Coptic",
  "cosmetics",
  "",
  "Damascene",
  "definite",
  "demonstrative",
  "dialectal",
  "diminutive",
  "diplomacy",
  "ditto",
  "",
  "east, eastern",
  "economy",
  "Egypt",
  "Egyptian",
  "for example",
  "electricity",
  "elliptical",
  "English",
  "especially",
  "ethnology",
  "",
  "feminine",
  "feminine",
  "figuratively",
  "finance",
  "following",
  "French",
  "",
  "German",
  "Great Britain",
  "genitive",
  "geography",
  "geometry",
  "Greek",
  "grammar",
  "",
  "Hebrew",
  "Hejazi",
  "horticulture",
  "",
  "that is",
  "imperative",
  "imperfect",
  "indefinite",
  "interjection",
  "International Law",
  "intransitive",
  "Iraq",
  "Iraqi",
  "Islam, Islamic",
  "Italian",
  "",
  "Jordan Kingdom",
  "journalism",
  "Judaism",
  "jurisprudence",
  "",
  "Lebanon",
  "Lebanese",
  "lexicography",
  "literally",
  "",
  "masculine",
  "magnetism",
  "Maghrib",
  "Maghribi",
  "masculine",
  "mathematics",
  "medicine",
  "military",
  "mineralogy",
  "Morocoo",
  "Moroccan",
  "music",
  "mysticism",
  "",
  "north, northern",
  "noun, nomen",
  "North Africa",
  "northeast, northeastern",
  "nautics",
  "negation",
  "nominative",
  "nomen unitatis",
  "nomen vicis",
  "northwest, northwestern",
  "",
  "obliquua",
  "optics",
  "oneself",
  "Ottoman",
  "",
  "Palestine",
  "Palestinian",
  "parliamentary language",
  "particle",
  "passive",
  "pathology",
  "perfect",
  "Persian",
  "person, personal",
  "pharmacy",
  "philosophy",
  "phonetics",
  "photography",
  "physics",
  "physiology",
  "plural",
  "pluralis communia",
  "post meridiem",
  "poetry",
  "politica",
  "preposition",
  "pronoun",
  "psychology",
  "",
  "which see",
  "",
  "reflexive",
  "relative",
  "religion",
  "rhetoric",
  "",
  "south, southern",
  "Saudi Arabia",
  "Saudi-Arabian",
  "southeast, southeastern",
  "singular",
  "someone",
  "Spanish",
  "specifically",
  "something",
  "stylistics",
  "subjunctive",
  "substantive",
  "surgery",
  "southwest, southwestern",
  "Syria",
  "Syrian",
  "",
  "technology",
  "telephone",
  "temporal",
  "theatrical art",
  "theology",
  "transitive",
  "Tunisia",
  "Tunisian",
  "Turkish",
  "typography",
  "",
  "United Arab Republic",
  "uninflected",
  "",
  "verbal",
  "",
  "west, western",
  "",
  "Yemen",
  "Yemenite usage",
  "",
  "zoology",
];
