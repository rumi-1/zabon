import '../models/study_models.dart';

/// Returns true when [text] contains any Arabic/Perso-Arabic/Pashto script.
bool hasScript(String text) {
  return text.runes.any((r) =>
      (r >= 0x0600 && r <= 0x06FF) ||
      (r >= 0x0750 && r <= 0x077F) ||
      (r >= 0xFB50 && r <= 0xFDFF) ||
      (r >= 0xFE70 && r <= 0xFEFF));
}

/// Looks up the romanization for a script string.
/// Returns null if no entry found (caller should hide the caption).
String? getRomanization(String text, StudyLanguage lang) {
  if (!hasScript(text)) return null;
  return lang == StudyLanguage.dari ? _dari[text] : _pashto[text];
}

// ─── Dari · Kabul Afghan dialect ────────────────────────────────────────────
// Key markers: shash (6 not shesh), no (9 not noh), yak (1 not yek),
//              qermez (q not gh), safed (not sefid), gershna (not gersone)

const Map<String, String> _dari = {
  // Greetings
  'سلام': 'salâm',
  'خداحافظ': 'khodâhâfez',
  'صبح بخیر': 'sob ba-khair',
  'شب بخیر': 'shab ba-khair',
  'سلام علیکم': 'salâm alaikum',
  // Courtesy
  'تشکر': 'tashakor',
  'متشکرم': 'tashakor',
  'لطفاً': 'lotfan',
  'ببخشید': 'bebakhshid',
  'بله': 'bale',
  'نه': 'na',
  'خوش آمدید': 'khosh âmadid',
  'خواهش می‌کنم': 'khâhesh mikonam',
  // Numbers
  'صفر': 'sifr',
  'یک': 'yak',
  'دو': 'do',
  'سه': 'se',
  'چهار': 'châr',
  'پنج': 'panj',
  'شش': 'shash',
  'هفت': 'haft',
  'هشت': 'hasht',
  'ده': 'dah',
  // Pronouns & basic verbs
  'من': 'man',
  'تو': 'to',
  'او': 'u',
  'ما': 'mâ',
  'شما': 'shomâ',
  'هستم': 'hastam',
  'خوبم': 'khubam',
  'من هستم': 'man hastam',
  'شما هستید': 'shomâ hastid',
  'او است': 'u ast',
  'ما هستیم': 'mâ hastim',
  // Introductions
  'اسم': 'esm',
  'از': 'az',
  // Family
  'مادر': 'mâdar',
  'پدر': 'pedar',
  'برادر': 'barâdar',
  'خواهر': 'khâhar',
  'پدربزرگ': 'pedarbozorg',
  'مادربزرگ': 'mâdarbozorg',
  'کاکا': 'kâkâ',
  'خاله': 'khâle',
  'پسرکاکا': 'pesar-kâkâ',
  'دخترکاکا': 'dokhtar-kâkâ',
  'عمو': 'amo',
  'پسرعمو': 'pesar-amo',
  // Days
  'شنبه': 'shanbe',
  'یکشنبه': 'yekshanbe',
  'دوشنبه': 'doshanbe',
  'سه‌شنبه': 'seshanbe',
  'چهارشنبه': 'chahârshanbe',
  'پنج‌شنبه': 'panjshanbe',
  'جمعه': 'joma',
  // Food
  'نان': 'nân',
  'برنج': 'berenj',
  'گوشت': 'gosht',
  'سبزی': 'sabzi',
  'چای': 'châi',
  'قهوه': 'qahwa',
  'آب': 'âb',
  'آبمیوه': 'âbmiwa',
  'خوردن': 'khordan',
  'نوشیدن': 'noshidan',
  'گرسنه': 'gershna',
  'تشنه': 'teshna',
  'خوشمزه': 'khoshmaza',
  // Colors
  'قرمز': 'qermez',
  'آبی': 'âbi',
  'سبز': 'sabz',
  'زرد': 'zard',
  'سیاه': 'syâh',
  'سفید': 'safed',
  'نارنجی': 'nâranji',
  'بنفش': 'banafsh',
  // Adjectives
  'بزرگ': 'bozorg',
  'کوچک': 'kochak',
  'خوب': 'khub',
  'بد': 'bad',
  'زیبا': 'zibâ',
  'زشت': 'zesht',
  // Activities
  'بیدار شدن': 'bidâr shodan',
  'شستن': 'shostan',
  'لباس پوشیدن': 'lebâs pushidan',
  'خوابیدن': 'khâbidan',
  'استراحت کردن': 'estirâhat kardan',
  'کار کردن': 'kâr kardan',
  // Weather
  'آفتابی': 'âftâbi',
  'ابری': 'abri',
  'بارانی': 'bârâni',
  'برفی': 'barfi',
  'گرم': 'garm',
  'سرد': 'sard',
  'باد': 'bâd',
  'هوای خوب': 'havây khub',
  // Misc
  'زیاد': 'zyâd',
  'بسیار': 'besyâr',
};

// ─── Pashto · Afghan Standard Literary Pashto ───────────────────────────────
// No Urdu/Indic borrowings. Kandahar-Kabul literary standard.
// ږ=g/zh  ځ=dz  ښ=kh  ګ=g  ې=e  ۍ=ai

const Map<String, String> _pashto = {
  // Greetings
  'سلام': 'salâm',
  'خدای پامان': 'khodây pamân',
  'صبح پخیر': 'sobh pakhair',
  'ماخستن پخیر': 'mâkhsten pakhair',
  'مننه': 'mananà',
  'خوش آمدی': 'khwash âmdi',
  'ببخښه': 'bakhkha',
  'هو': 'ho',
  'نه': 'na',
  'ستا مننه': 'stâ mananà',
  // Courtesy
  'مهرباني': 'mehrbâni',
  'بخښه غواړم': 'bakhkha ghwâram',
  'ښه': 'kha',
  // Numbers
  'صفر': 'sifr',
  'یو': 'yo',
  'دوه': 'dwa',
  'درې': 'dre',
  'څلور': 'tsalor',
  'پنځه': 'pinza',
  'شپږ': 'shpag',
  'اووه': 'owa',
  'اته': 'ata',
  'لس': 'las',
  // Pronouns
  'زه': 'za',
  'ته': 'ta',
  'هغه': 'hagha',
  'مونږ': 'mundzh',
  'تاسو': 'tâso',
  'هغوی': 'haghwi',
  'یم': 'yam',
  'یې': 'ye',
  'دی': 'dai',
  // Introductions
  'نوم': 'num',
  'زما': 'zmâ',
  'زما نوم': 'zmâ num',
  'چیرې': 'chirè',
  'یاست': 'yâst',
  // Family
  'مور': 'mor',
  'پلار': 'plâr',
  'ورور': 'wror',
  'خور': 'khor',
  'نیکه': 'neka',
  'نیا': 'nyâ',
  'کاکا': 'kâkâ',
  'ماما': 'mâmâ',
  'تره': 'tra',
  'ترور': 'tror',
  'د کاکا زوی': 'da kâkâ zuy',
  'د خور زوی': 'da khor zuy',
  // Days (Afghan Pashto uses Persian-origin day names)
  'شنبه': 'shanbe',
  'یکشنبه': 'yekshanbe',
  'دوشنبه': 'doshanbe',
  'سه‌شنبه': 'seshanbe',
  'چهارشنبه': 'chahârshanbe',
  'پنج‌شنبه': 'panjshanbe',
  'جمعه': 'joma',
  // Food
  'ډوډۍ': 'daway',
  'وریجې': 'wrije',
  'غوښه': 'ghwakha',
  'سبزي': 'sabzi',
  'چای': 'châi',
  'اوبه': 'oba',
  'خوراک': 'khwrâk',
  'وږی': 'wegay',
  'تږی': 'tegay',
  'خوندور': 'khwandor',
  // Colors
  'سور': 'soor',
  'شین': 'shin',
  'زرغون': 'zarghun',
  'ژیړ': 'zhyir',
  'تور': 'tor',
  'سپین': 'spin',
  'نارنجي': 'nâranji',
  'بنفشي': 'banafshi',
  // Adjectives
  'لوی': 'loy',
  'کوچنی': 'kochni',
  'بد': 'bad',
  'ښکلی': 'khkalay',
  'ښکلې': 'khkale',
  // Activities
  'پاڅیدل': 'pâtsidal',
  'مخ مینځل': 'mukh mendzhal',
  'خوب کول': 'khob kawul',
  'خوراک خوړل': 'khwrâk khwral',
  'اوبه څکل': 'oba tsakal',
  'لوستل': 'lwastal',
  'خبرې کول': 'khabre kawul',
  // Weather
  'لمریز': 'lmariz',
  'وریځ': 'wrij',
  'باران': 'bârân',
  'واوره': 'wâwra',
  'ګرم': 'garm',
  'ساړه': 'sâra',
  'باد': 'bâd',
  // Misc
  'ډیره': 'dera',
  'ستا': 'stâ',
  'هم': 'ham',
};
