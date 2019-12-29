import 'dart:ui';

class ZodiacSign {
  String name;
  String cardPath;
  String logoPath;
  Color signColor;
  String signTimeSpan;

  // ignore: sort_constructors_first
  ZodiacSign(
      this.name,
      this.cardPath,
      this.logoPath,
      this.signColor,
      this.signTimeSpan,
      );

  String get getName => name;
  String get getCardPath => cardPath;
  String get getLogoPath => logoPath;
  Color get getColor => signColor;
  String get getSpan => signTimeSpan;
}

final ZodiacSign aquarius = ZodiacSign(
  // ignore: prefer_single_quotes
  "Aquarius",
  // ignore: prefer_single_quotes
  "assets/images/aquarius.png",
  // ignore: prefer_single_quotes
  "assets/strokes/aquarius.png",
  Color(0xFF4297C6),
  // ignore: prefer_single_quotes
  "January 20 to February 18",
);

final ZodiacSign aries = ZodiacSign(
  // ignore: prefer_single_quotes
  "Aries",// ignore: prefer_single_quotes
  "assets/images/aries.png",// ignore: prefer_single_quotes
  "assets/strokes/aries.png",// ignore: prefer_single_quotes
  Color(0xFFEFA91B),
  "March 21 to April 19",// ignore: prefer_single_quotes
);

final ZodiacSign cancer = ZodiacSign(// ignore: prefer_single_quotes
  "Cancer",// ignore: prefer_single_quotes
  "assets/images/cancer.png",// ignore: prefer_single_quotes
  "assets/strokes/cancer.png",// ignore: prefer_single_quotes
  Color(0xFFD83554),
  "June 21 to July 22",// ignore: prefer_single_quotes
);

final ZodiacSign capricorn = ZodiacSign(// ignore: prefer_single_quotes
  "Capricorn",// ignore: prefer_single_quotes
  "assets/images/capricorn.png",// ignore: prefer_single_quotes
  "assets/strokes/capricorn.png",// ignore: prefer_single_quotes
  Color(0xFF9276B7),
  "December 22 to January 19",// ignore: prefer_single_quotes
);

final ZodiacSign gemini = ZodiacSign(// ignore: prefer_single_quotes
  "Gemini",// ignore: prefer_single_quotes
  "assets/images/gemini.png",// ignore: prefer_single_quotes
  "assets/strokes/gemini.png",// ignore: prefer_single_quotes
  Color(0xFFE29A59),
  "May 21 to June 20",// ignore: prefer_single_quotes
);

final ZodiacSign leo = ZodiacSign(
  "Leo",// ignore: prefer_single_quotes
  "assets/images/leo.png",// ignore: prefer_single_quotes
  "assets/strokes/leo.png",// ignore: prefer_single_quotes
  Color(0xFFDB6412),
  "July 23 to August 23",// ignore: prefer_single_quotes
);

final ZodiacSign libra = ZodiacSign(// ignore: prefer_single_quotes
  "Libra",// ignore: prefer_single_quotes
  "assets/images/libra.png",// ignore: prefer_single_quotes
  "assets/strokes/libra.png",// ignore: prefer_single_quotes
  Color(0xFF26AEC4),
  "September 23 to October 22",// ignore: prefer_single_quotes
);

final ZodiacSign pisces = ZodiacSign(// ignore: prefer_single_quotes
  "Pisces",// ignore: prefer_single_quotes
  "assets/images/pisces.png",// ignore: prefer_single_quotes
  "assets/strokes/pisces.png",// ignore: prefer_single_quotes
  Color(0xFFDE4A46),
  "February 19 to March 20",// ignore: prefer_single_quotes
);

final ZodiacSign sagittarius = ZodiacSign(
  // ignore: prefer_single_quotes
  "Sagittarius",// ignore: prefer_single_quotes
  "assets/images/sagittarius.png",// ignore: prefer_single_quotes
  "assets/strokes/sagittarius.png",// ignore: prefer_single_quotes
  Color(0xFFB7294B),
  "November 22 to December 21",// ignore: prefer_single_quotes
);

final ZodiacSign scorpio = ZodiacSign(// ignore: prefer_single_quotes
  "Scorpio",// ignore: prefer_single_quotes
  "assets/images/scorpio.png",// ignore: prefer_single_quotes
  "assets/strokes/scorpio.png",// ignore: prefer_single_quotes
  Color(0xFFC13A2F),
  "October 23 to November 21",// ignore: prefer_single_quotes
);

final ZodiacSign taurus = ZodiacSign(// ignore: prefer_single_quotes
  "Taurus",// ignore: prefer_single_quotes
  // ignore: prefer_single_quotes
  "assets/images/taurus.png",// ignore: prefer_single_quotes
  "assets/strokes/taurus.png",// ignore: prefer_single_quotes
  Color(0xFFBF6F47),
  // ignore: prefer_single_quotes
  "April 20 to May 20",
);

final ZodiacSign virgo = ZodiacSign(// ignore: prefer_single_quotes
  "Virgo",// ignore: prefer_single_quotes
  "assets/images/virgo.png",// ignore: prefer_single_quotes
  "assets/strokes/virgo.png",// ignore: prefer_single_quotes
  Color(0xFF179677),
  "August 24 to September 22",// ignore: prefer_single_quotes
);

final List<ZodiacSign> signs = [
  aquarius,
  aries,
  cancer,
  capricorn,
  gemini,
  leo,
  libra,
  pisces,
  sagittarius,
  scorpio,
  taurus,
  virgo,
];
