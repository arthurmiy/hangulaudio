
import 'package:hangul/hangul.dart';

String romanize(String input) {
  List<String> syllables = input.split("");
  String romanized="";
  for (String i in syllables) {
    var a = HangulSyllable.fromString(i);
    romanized="$romanized${onset[a.cho]}${vowel[a.jung]}${a.jong==null?'':coda[a.jong]}";
  }
  return romanized;
}

Map<String,String> vowel = {
// 단모음 monophthongs
'ㅏ' : 'a',
'ㅓ' : 'eo',
'ㅗ' : 'o',
'ㅜ' : 'u',
'ㅡ' : 'eu',
'ㅣ' : 'i',
'ㅐ' : 'ae',
'ㅔ' : 'e',
'ㅚ' : 'oe',
'ㅟ' : 'wi',

// 이중모음 diphthongs
'ㅑ' : 'ya',
'ㅕ' : 'yeo',
'ㅛ' : 'yo',
'ㅠ' : 'yu',
'ㅒ' : 'yae',
'ㅖ' : 'ye',
'ㅘ' : 'wa',
'ㅙ' : 'wae',
'ㅝ' : 'wo',
'ㅞ' : 'we',
'ㅢ' : 'ui', // [붙임 1] ‘ㅢ’는 ‘ㅣ’로 소리 나더라도 ‘ui’로 적는다.
};

Map<String,String> onset = {
// 파열음 stops/plosives
'ㄱ' : 'g',
'ㄲ' : 'kk',
'ㅋ' : 'k',
'ㄷ' : 'd',
'ㄸ' : 'tt',
'ㅌ' : 't',
'ㅂ' : 'b',
'ㅃ' : 'pp',
'ㅍ' : 'p',
// 파찰음 affricates
'ㅈ' : 'j',
'ㅉ' : 'jj',
'ㅊ' : 'ch',
// 마찰음 fricatives
'ㅅ' : 's',
'ㅆ' : 'ss',
'ㅎ' : 'h',
// 비음 nasals
'ㄴ' : 'n',
'ㅁ' : 'm',
// 유음 liquids
'ㄹ' : 'r',
// Null sound
'ㅇ' : '',
};



Map<String,String> coda = {
// 파열음 stops/plosives
'ㄱ' : 'k',
'ㄷ' : 't',
'ㅂ' : 'p',
// 비음 nasals
'ㄴ' : 'n',
'ㅇ' : 'ng',
'ㅁ' : 'm',
// 유음 liquids
'ㄹ' : 'l',

};


