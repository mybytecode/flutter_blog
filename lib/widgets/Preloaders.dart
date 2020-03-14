library pk_skeleton;

import 'package:flutter/material.dart';

Decoration myBoxDec(animation, {isCircle = false}) {
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xfff6f7f9),
        Color(0xffe9ebee),
        Color(0xfff6f7f9),
        // Color(0xfff6f7f9),
      ],
      stops: [
        // animation.value * 0.1,
        animation.value - 1,
        animation.value,
        animation.value + 1,
        // animation.value + 5,
        // 1.0,
      ],
    ),
  );
}

class CardSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;

  CardSkeleton({this.isCircularImage = true, this.isBottomLinesActive = true});

  @override
  _CardSkeletonState createState() => _CardSkeletonState();
}

class _CardSkeletonState extends State<CardSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: width * 0.3,
                      width: width * 0.13,
                      decoration:
                          myBoxDec(animation, isCircle: widget.isCircularImage),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: width * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height * 0.008,
                            width: width * 0.3,
                            decoration: myBoxDec(animation),
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.2,
                            decoration: myBoxDec(animation),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                widget.isBottomLinesActive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.7,
                            decoration: myBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.8,
                            decoration: myBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.5,
                            decoration: myBoxDec(animation),
                          ),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

Decoration myDarkBoxDec(animation, {isCircle = false}) {
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.grey[700],
        Colors.grey[600],
        Colors.grey[700],
        // Color(0xfff6f7f9),
      ],
      stops: [
        // animation.value * 0.1,
        animation.value - 1,
        animation.value,
        animation.value + 1,
        // animation.value + 5,
        // 1.0,
      ],
    ),
  );
}

class DarkCardSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;

  DarkCardSkeleton(
      {this.isCircularImage = true, this.isBottomLinesActive = true});

  @override
  _DarkCardSkeletonState createState() => _DarkCardSkeletonState();
}

class _DarkCardSkeletonState extends State<DarkCardSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.grey[800],
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: width * 0.3,
                      width: width * 0.13,
                      decoration: myDarkBoxDec(animation,
                          isCircle: widget.isCircularImage),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: width * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height * 0.008,
                            width: width * 0.3,
                            decoration: myDarkBoxDec(animation),
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.2,
                            decoration: myDarkBoxDec(animation),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                widget.isBottomLinesActive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.7,
                            decoration: myDarkBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.8,
                            decoration: myDarkBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.5,
                            decoration: myDarkBoxDec(animation),
                          ),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardListSkeleton extends StatelessWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;
  final int length;

  CardListSkeleton({
    this.isCircularImage = true,
    this.length = 10,
    this.isBottomLinesActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return CardSkeleton(
          isCircularImage: isCircularImage,
          isBottomLinesActive: isBottomLinesActive,
        );
      },
    );
  }
}

class DarkCardListSkeleton extends StatelessWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;
  final int length;

  DarkCardListSkeleton({
    this.isCircularImage = true,
    this.length = 10,
    this.isBottomLinesActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return DarkCardSkeleton(
          isCircularImage: isCircularImage,
          isBottomLinesActive: isBottomLinesActive,
        );
      },
    );
  }
}

class PKCardProfileSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;

  PKCardProfileSkeleton(
      {this.isCircularImage = true, this.isBottomLinesActive = true});

  @override
  _PKCardProfileSkeletonState createState() => _PKCardProfileSkeletonState();
}

class _PKCardProfileSkeletonState extends State<PKCardProfileSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  decoration:
                      myBoxDec(animation, isCircle: widget.isCircularImage),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.13,
                            width: width * 0.13,
                            decoration: myBoxDec(animation,
                                isCircle: widget.isCircularImage),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: width * 0.13,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: height * 0.008,
                                  width: width * 0.3,
                                  decoration: myBoxDec(animation),
                                ),
                                Container(
                                  height: height * 0.007,
                                  width: width * 0.2,
                                  decoration: myBoxDec(animation),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                widget.isBottomLinesActive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.7,
                            decoration: myBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.8,
                            decoration: myBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.5,
                            decoration: myBoxDec(animation),
                          ),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

class PKDarkCardProfileSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;

  PKDarkCardProfileSkeleton(
      {this.isCircularImage = true, this.isBottomLinesActive = true});

  @override
  _PKDarkCardProfileSkeletonState createState() =>
      _PKDarkCardProfileSkeletonState();
}

class _PKDarkCardProfileSkeletonState extends State<PKDarkCardProfileSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.grey[800],
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  decoration:
                      myDarkBoxDec(animation, isCircle: widget.isCircularImage),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.13,
                            width: width * 0.13,
                            decoration: myDarkBoxDec(animation,
                                isCircle: widget.isCircularImage),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: width * 0.13,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: height * 0.008,
                                  width: width * 0.3,
                                  decoration: myDarkBoxDec(animation),
                                ),
                                Container(
                                  height: height * 0.007,
                                  width: width * 0.2,
                                  decoration: myDarkBoxDec(animation),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                widget.isBottomLinesActive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.7,
                            decoration: myDarkBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.8,
                            decoration: myDarkBoxDec(animation),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.5,
                            decoration: myDarkBoxDec(animation),
                          ),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardPageSkeleton extends StatefulWidget {
  final int totalLines;

  CardPageSkeleton({this.totalLines = 5});

  @override
  _CardPageSkeletonState createState() => _CardPageSkeletonState();
}

class _CardPageSkeletonState extends State<CardPageSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    widget.totalLines,
                    (i) => Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.007,
                              width: width * 0.7,
                              decoration: myBoxDec(animation),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.8,
                              decoration: myBoxDec(animation),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.5,
                              decoration: myBoxDec(animation),
                            ),
                          ],
                        )).toList(),
              )),
        );
      },
    );
  }
}

class DarkCardPageSkeleton extends StatefulWidget {
  final int totalLines;

  DarkCardPageSkeleton({this.totalLines = 5});

  @override
  _DarkCardPageSkeletonState createState() => _DarkCardPageSkeletonState();
}

class _DarkCardPageSkeletonState extends State<DarkCardPageSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              color: Colors.grey[800],
              //padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    widget.totalLines,
                    (i) => Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.007,
                              width: width ,
                              decoration: myDarkBoxDec(animation),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.8,
                              decoration: myDarkBoxDec(animation),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: height * 0.007,
                              width: width * 0.5,
                              decoration: myDarkBoxDec(animation),
                            ),
                          ],
                        )).toList(),
              )),
        );
      },
    );
  }
}
