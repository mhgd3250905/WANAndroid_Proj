import 'package:douban_movies/WanAndroid/Progress/painter_factory.dart';
import 'package:flutter/material.dart';

class ProgressManager extends StatefulWidget {
  @override
  _ProgressManagerState createState() =>
      new _ProgressManagerState().._factory = WavePainterFactory();
}

class _ProgressManagerState extends State<ProgressManager>
    with TickerProviderStateMixin {
  AnimationController xController;
  AnimationController yController;
  Animation<double> xAnimation;
  Animation<double> yAnimation;
  List<double> _progressList = [];
  double curProgress = 0;
  BasePainterFactory _factory;

  set painter(BasePainterFactory factory) {
    _factory = factory;
  }

  setProgress(double progress) {
    _progressList.add(progress);
    onProgressChange();
  }

  onProgressChange() {
    if (_progressList.length > 0) {
      if (yController != null && yController.isAnimating) {
        return;
      }
      double nextProgress = _progressList[0];
      _progressList.removeAt(0);
      final double begin = curProgress;
      yController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
      yAnimation =
          new Tween(begin: begin, end: nextProgress).animate(yController);
      yAnimation.addListener(_onProgressChange);
      yAnimation.addStatusListener(_onProgressStatusChange);
      yController.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    xAnimation = new Tween(begin: 0.0, end: 1.0).animate(xController);
    xAnimation.addListener(_change);
    yController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    yAnimation = new Tween(begin: 0.0, end: 1.0).animate(yController);
    yAnimation.addListener(_onProgressChange);
    yAnimation.addStatusListener(_onProgressStatusChange);

    doDelay(xController, 0);

    Future.delayed(Duration(milliseconds: 1000), () {
      setProgress(0.8);
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      setProgress(0.2);
    });
    Future.delayed(Duration(milliseconds: 3000), () {
      setProgress(1.0);
    });
    Future.delayed(Duration(milliseconds: 4000), () {
      setProgress(0.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      Container(
        width: 200.0,
        height: 200.0,
        child: new CustomPaint(
          painter: _factory.getPainter()
            ..XAnimation = xAnimation
            ..YAnimation = yAnimation,
          size: new Size(200.0, 200.0),
        ),
      ),
    );
  }

  void _change() {
    setState(() {});
  }

  void _onProgressChange() {
    setState(() {
      curProgress = yAnimation.value;
    });
  }

  void _onProgressStatusChange(status) {
    if (status == AnimationStatus.completed) {
      onProgressChange();
    }
  }

  void doDelay(AnimationController controller, int delay) async {
    Future.delayed(Duration(milliseconds: delay), () {
      controller..repeat();
    });
  }

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    xAnimation.removeListener(_change);
    yAnimation.removeListener(_onProgressChange);
    yAnimation.removeStatusListener(_onProgressStatusChange);
    super.dispose();
  }
}
