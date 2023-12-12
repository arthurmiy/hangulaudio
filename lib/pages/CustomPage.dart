import 'dart:async';

import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hangulaudio/features/base64.dart';
import 'package:hangulaudio/features/romanization/romanizer.dart';
import 'package:hangulaudio/features/words/myeongsa.dart';
import 'package:hangulaudio/features/words/translation.dart';
import 'package:hangulaudio/pages/BasicPage.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'dart:math';

class CustomPage extends StatefulWidget {
  final String randomWord;
  final String randomWordTranslation;
  const CustomPage({Key? key, this.randomWordTranslation="",this.randomWord=""}) : super(key: key);

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final controller = FlipController();
  String? finalResult;
  String word = "";



  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  bool isFront=true;
  String mode="question";

  bool hasError=false;

  void flipCardToWidget(Widget widgetTo) {
    if (isFront) {

      backCard=widgetTo;
    } else {

      frontCard=widgetTo;
    }
    setState(() {

    });
    controller.flip();
    isFront=!isFront;
  }


  Widget frontCard=Card(
    child: Padding(
      padding:
      const EdgeInsets.all(
          8.0),
      child: FittedBox(
        child: Container(
            child: Icon(Icons
                .question_mark)),
      ),
    ),
  );
  Widget backCard=Container();

  final String defaultLanguage = 'ko-KR';
  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;
  TextToSpeech tts = TextToSpeech();

  bool langError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initLanguages();
    });

  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String> displayLanguages = await tts.getLanguages();


    if (!displayLanguages.contains("ko-KR")) {
      langError=true;
    }
    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    // final String? defaultLangCode = await tts.getDefaultLanguage();
    // if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
    //   languageCode = defaultLangCode;
    // } else {
    languageCode = defaultLanguage;
    // }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);


    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  void speak() {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);

    }
    tts.setPitch(pitch);
    tts.speak(text);
  }

  void playWord({double rateIn=1}) {

    text = widget.randomWord;
    rate = rateIn;
    speak();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (langError)?Text("Error Loading Korean Voice", style: TextStyle(color: Colors.red),):Text("Training"),

      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  // color: Colors.blue.shade50,
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: [
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {
                                                          if (mode=="romanization") return;
                                                          flipCardToWidget(Card(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: FittedBox(
                                                                child: Text(romanize(widget.randomWord)),
                                                              ),
                                                            ),
                                                          ));
                                                          mode="romanization";
                                                        },
                                                        icon: Text(
                                                          "ㅏ/A",
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        tooltip: "Romanization"),
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {
                                                          if (mode=="english") return;
                                                          flipCardToWidget(Card(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: FittedBox(
                                                                child: Text(widget.randomWordTranslation),
                                                              ),
                                                            ),
                                                          ));
                                                          mode="english";
                                                        },
                                                        icon: Text(
                                                          "EN",
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        tooltip: "Meaning"),
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {
                                                          if (mode=="hangul") return;
                                                          flipCardToWidget(Card(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: FittedBox(
                                                                child: Text(widget.randomWord),
                                                              ),
                                                            ),
                                                          ));
                                                          mode="hangul";
                                                        },
                                                        icon: Text(
                                                          "한글",
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        tooltip: "Answer"),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: (){
                                                      if (mode=="question") return;
                                                      flipCardToWidget(Card(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                          child: FittedBox(
                                                            child: Container(
                                                                child: Icon(Icons
                                                                    .question_mark)),
                                                          ),
                                                        ),
                                                      ));
                                                      mode="question";
                                                    },
                                                    child: Container(
                                                      child: AnimatedFlipWidget(
                                                        front: frontCard,
                                                        back: backCard,
                                                        controller: controller,
                                                        clickable: false,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {
                                                          playWord();
                                                        },
                                                        icon: Icon(Icons
                                                            .play_circle_outline),
                                                        tooltip: "Play"),
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {
                                                          playWord(rateIn: 0.5);

                                                        },
                                                        icon: Icon(Icons
                                                            .slow_motion_video_outlined),
                                                        tooltip: "Play slowly"),
                                                    IconButton(
                                                        iconSize: 50,
                                                        onPressed: () {

                                                            Random random = Random();
                                                            int randomNumber = random.nextInt(listMyeongsa.length);
                                                            var randomWord = listMyeongsa[randomNumber];
                                                            var randomWordTranslation = listMyeongsaTranslated[randomNumber];
                                                        context.beamToNamed('/custom/${encrypt("$randomWord,$randomWordTranslation")}');

                                                        },
                                                        icon: FaIcon(
                                                            FontAwesomeIcons.diceSix),
                                                        tooltip: "New Random Word"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SelectableText(
                                                  word,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 50),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: (word != "")
                                                    ? () {
                                                  word = word.substring(
                                                      0, word.length - 1);

                                                  setState(() {});
                                                }
                                                    : null,
                                                icon: Icon(
                                                  Icons.backspace_outlined,
                                                  color: (word != "")
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  size: 50,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: (word != "")
                                                    ? () {
                                                  text = word;
                                                  rate = 1.0;
                                                  speak();
                                                }
                                                    : null,
                                                icon: FaIcon(
                                                  FontAwesomeIcons.bullhorn,
                                                  color: (word != "")
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  size: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                  flex: 6)
            ],
          ),
          BasicPageInput(function: (s) {
            word = "$word$s";
            setState(() {});
          }),
        ],
      ),
    );
  }
}
