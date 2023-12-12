import 'package:flutter/material.dart';
import 'package:hangul/hangul.dart';

import '../widgets/CustomKeyboard.dart';

class BasicPageInput extends StatefulWidget {
  final Function(String?) function;
  const BasicPageInput({Key? key, required this.function }) : super(key: key);

  @override
  State<BasicPageInput> createState() => _BasicPageInputState();
}

class _BasicPageInputState extends State<BasicPageInput> {
  String? char1;
  String? char2;
  String? char3;
  String result = "";
  String? finalResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: CustomKeyboard(
                onKeyRelease: (s) {
                  if (char1 == null) {
                    if (isValidCho(String.fromCharCode(s))) {
                      char1 = String.fromCharCode(s);
                      char2 = null;
                      char3 = null;
                      result = "$char1";
                    }
                  } else if (char2 == null) {
                    if (isValidJung(String.fromCharCode(s))) {
                      char2 = String.fromCharCode(s);
                      char3 = null;
                      try {
                        var tmp = HangulSyllable(
                          char1 ?? "",
                          char2 ?? "",
                        );
                        result = "$char1 + $char2 = $tmp";
                        finalResult = tmp.toString();
                      } catch (err) {
                        char2 = null;
                        result = "$char1";
                      }
                    }
                  } else if (char3 == null) {
                    if (isValidJong(String.fromCharCode(s))) {
                      char3 = String.fromCharCode(s);
                      try {
                        var tmp = HangulSyllable(
                            char1 ?? "", char2 ?? "", char3);
                        result = "$char1 + $char2 + $char3 = $tmp";
                        finalResult = tmp.toString();
                      } catch (err) {
                        char3 = null;
                        var tmp = HangulSyllable(
                          char1 ?? "",
                          char2 ?? "",
                        );
                        result = "$char1+$char2=$tmp";
                        finalResult = tmp.toString();
                      }
                    }
                  } else {
                    if (isValidCho(String.fromCharCode(s))) {
                      char1 = String.fromCharCode(s);
                      char2 = null;
                      char3 = null;
                      finalResult = null;
                      result = "$char1";
                    } else if (isValidJung(String.fromCharCode(s))) {
                      char2 = String.fromCharCode(s);
                      char3 = null;
                      var tmp = HangulSyllable(
                        char1 ?? "",
                        char2 ?? "",
                      );
                      result = "$char1+$char2=$tmp";
                      finalResult = tmp.toString();
                    } else if (isValidJong(String.fromCharCode(s))) {
                      char3 = String.fromCharCode(s);
                      finalResult = null;
                      var tmp = HangulSyllable(
                        char1 ?? "",
                        char2 ?? "",
                      );
                      result = "$char1+$char2+$char3=$tmp";
                      finalResult = tmp.toString();
                    }
                  }
                  setState(() {});


                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),

                                ),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              result,
                                              textAlign: TextAlign.center,
                                              style:
                                              TextStyle(fontSize: 80, color: Colors.black54),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: (result != "")
                                                ? () {
                                              finalResult = null;
                                              char1 = null;
                                              char2 = null;
                                              char3 = null;
                                              result = "";
                                              setState(() {});

                                            }
                                                : null,
                                            icon: Icon(
                                              Icons.cleaning_services,
                                              color: (result != "")
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 100,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: (finalResult != null)
                                                ? () {

                                              widget.function(finalResult);
                                              finalResult = null;
                                              char1 = null;
                                              char2 = null;
                                              char3 = null;
                                              result = "";
                                              setState(() {});

                                            }
                                                : null,
                                            icon: Icon(
                                              Icons.check_circle_outline,
                                              color: (finalResult != null)
                                                  ? Colors.green
                                                  : Colors.grey,
                                              size: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              )),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
