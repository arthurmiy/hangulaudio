
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'keyboardkey.dart';

class KeyboardKeys extends StatefulWidget {
  final Function onKeyRelease;
  final Widget child;

  KeyboardKeys({required this.onKeyRelease, required this.child});

  @override
  _KeyboardKeysState createState() => _KeyboardKeysState();
}

class _KeyboardKeysState extends State<KeyboardKeys> {
  GlobalKey board = GlobalKey();
  GlobalKey fitt = GlobalKey();

  int currentKey = 0;
  bool pressed = false;

  final key = GlobalKey();

  double remainingy = 0;
  double remainingx = 0;

  double positionX = 0;
  double positionY = 0;
  double height1 = 0;
  double width1 = 0;
  String carac = '';

  _calculateRemaining() {
//    RenderBox positionRed = board.currentContext.findRenderObject();
//
//    positionRed.globalToLocal(Offset.zero);
//
//    setState(() {
//      remainingy = -positionRed.globalToLocal(Offset.zero).dy;
//      remainingx = positionRed.size.width;
//    });
//
//    print(remainingy);

    Future.delayed(const Duration(milliseconds: 300), () {
      RenderBox positionRed = board.currentContext?.findRenderObject() as RenderBox;

        positionRed.globalToLocal(Offset.zero);

        setState(() {
          remainingy = (-positionRed.globalToLocal(Offset.zero).dy)/2;
          remainingx = positionRed.size.width;
        });


      print(remainingy);
    });
  }

  _detectTapedItem(PointerEvent event) {
    pressed = false;
    //Widget que engloba todas as teclas
    final RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      //test every element in the three
      for (final hit in result.path) {
        final target = hit.target;

        /// temporary variable so that the [is] allows access of [index]
        if (target is _Foo) {
          //enters if the key container is detected
          FormatData boardData =
              _getPositions(board.currentContext?.findRenderObject() as RenderBox);
          FormatData fittData =
              _getPositions(fitt.currentContext?.findRenderObject() as RenderBox);
          FormatData a = _getPositions(target.child as RenderBox);
          double tmp = boardData.w / fittData.w;

          setState(() {
            positionX = (a.x - fittData.x) * tmp;
            positionY = (a.y - fittData.y) * tmp - a.h;
            height1 = a.h;
            width1 = a.w;
            carac = String.fromCharCode(target.index??0);
            pressed = true;
            currentKey = target.index??0;
          });
        }
      }
    }
  }

  FormatData _getPositions(RenderBox renderBoxRed) {
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    final sizeRed = renderBoxRed.size;
    double positionX = positionRed.dx;
    double positionY = positionRed.dy;
    double height1 = sizeRed.height;
    double width1 = sizeRed.width;
    return FormatData(positionX, positionY, width1, height1);
  }

  void _unpressButton() {
    if (pressed) {
      setState(() {
        pressed = false;
      });
      //print(String.fromCharCode(currentKey));
      if (widget.onKeyRelease != null) widget.onKeyRelease(currentKey);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateRemaining());
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      key: fitt,
      fit: BoxFit.fitWidth,
      child: Listener(
        onPointerDown: _detectTapedItem,
        onPointerMove: _detectTapedItem,
        onPointerUp: (a) {
          _unpressButton();
        },
        onPointerCancel: (a) {
          setState(() {
            pressed = false;
          });
        },
        child: Stack(
          key: board,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Column(
                key: key,

                children: <Widget>[
                  SizedBox(
                    height: remainingy,
                    width: remainingx,
                    child: Container(
                      child: widget.child,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(color: Colors.white),

                    child: Row(
                      children: <Widget>[
                        temp('ㄱ',color: Colors.indigoAccent),
                        temp('ㄲ',color: Colors.indigoAccent),
                        temp('ㄴ',color: Colors.indigoAccent),
                        temp('ㄷ',color: Colors.indigoAccent),
                        temp('ㄸ',color: Colors.black),
                        temp('ㄹ',color: Colors.indigoAccent),
                        temp('ㅁ',color: Colors.indigoAccent),
                        temp('ㅂ',color: Colors.indigoAccent),
                        temp('ㅃ',color: Colors.black),
                        temp('ㅅ',color: Colors.indigoAccent),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        temp('ㅆ',color: Colors.black),
                        temp('ㅇ',color: Colors.indigoAccent),
                        temp('ㅈ',color: Colors.indigoAccent),
                        temp('ㅉ',color: Colors.black),
                        temp('ㅊ',color: Colors.indigoAccent),
                        temp('ㅋ',color: Colors.indigoAccent),
                        temp('ㅌ',color: Colors.indigoAccent),
                        temp('ㅍ',color: Colors.indigoAccent),
                        temp('ㅎ',color: Colors.indigoAccent),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        temp('ㅏ', color: Colors.blue),
                        temp('ㅐ', color: Colors.blue),
                        temp('ㅑ', color: Colors.blue),
                        temp('ㅒ', color: Colors.blue),
                        temp('ㅓ', color: Colors.blue),
                        temp('ㅔ', color: Colors.blue),
                        temp('ㅕ', color: Colors.blue),
                        temp('ㅖ', color: Colors.blue),
                        temp('ㅗ', color: Colors.blue),
                        temp('ㅘ', color: Colors.blue),
                        temp('ㅙ', color: Colors.blue),

                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: <Widget>[

                        temp('ㅚ', color: Colors.blue),
                        temp('ㅛ', color: Colors.blue),
                        temp('ㅜ', color: Colors.blue),
                        temp('ㅝ', color: Colors.blue),
                        temp('ㅞ', color: Colors.blue),
                        temp('ㅟ', color: Colors.blue),
                        temp('ㅠ', color: Colors.blue),
                        temp('ㅡ', color: Colors.blue),
                        temp('ㅢ', color: Colors.blue),
                        temp('ㅣ', color: Colors.blue),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        temp('ㄳ', color:Colors.deepPurple),
                        temp('ㄵ', color:Colors.deepPurple),
                        temp('ㄶ', color:Colors.deepPurple),
                        temp('ㄺ', color:Colors.deepPurple),
                        temp('ㄻ', color:Colors.deepPurple),
                        temp('ㄼ', color:Colors.deepPurple),
                        temp('ㄽ', color:Colors.deepPurple),
                        temp('ㄾ', color:Colors.deepPurple),
                        temp('ㄿ', color:Colors.deepPurple),
                        temp('ㅀ', color:Colors.deepPurple),
                        temp('ㅄ', color:Colors.deepPurple),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              left: positionX,
              top: positionY,
              child: (pressed)
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).backgroundColor,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      height: height1,
                      width: width1,
                      child: FittedBox(
                          child: Text(
                        carac,
                        textAlign: TextAlign.center,
                      )),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget temp(String char, {Color? color}) {
    return Foo(
      index: char.codeUnitAt(0),
      key: Key(char),
      child: KeyboardKeyCustom(char, positionedTap: (){},textColor: color),
    );
  }
}

class Foo extends SingleChildRenderObjectWidget {
  final int index;

  Foo({required Widget child, required this.index, required Key key}) : super(child: child, key: key);

  @override
  _Foo createRenderObject(BuildContext context) {
    return _Foo()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _Foo renderObject) {
    renderObject..index = index;
  }
}

class _Foo extends RenderProxyBox {
  int? index;
}


class FormatData {
  double x;
  double y;
  double w;
  double h;
  FormatData(this.x, this.y, this.w, this.h);
}
