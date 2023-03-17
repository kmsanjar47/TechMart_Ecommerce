import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final double scaleFactor;
  final bool? isFloating;
  final BorderRadius? borderRadius;
  final double? elevation;
  final List<Widget> items;
  final Function()? onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? strokeColor;
  final Curve? bubbleCurve;
  final Curve? scaleCurve;

  const CustomNavigationBar(
      {Key? key,
      required this.items,
      this.onTap,
      this.currentIndex = 0,
      this.scaleFactor = 0.2,
      this.elevation = 8.0,
      this.borderRadius,
      this.backgroundColor = Colors.white,
      this.strokeColor = Colors.blueAccent,
      this.bubbleCurve = Curves.linear,
      this.scaleCurve = Curves.linear,
      this.isFloating = false})
      : assert(scaleFactor <= 0.5, 'Scale factor must smaller than 0.5'),
        assert(scaleFactor > 0, 'Scale factor must bigger than 0'),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with TickerProviderStateMixin {
  List<double>? _radiusList;
  List<double>? _sizes;
  AnimationController? _controller;
  AnimationController? _scaleController;

  double _bubbleRadius = 0.0;
  double? _maxRadius;

  @override
  void initState() {
    super.initState();
    _bubbleRadius = 0.0;
    _radiusList = List<double>.generate(widget.items.length, (index) {
      return _bubbleRadius;
    });

    _sizes = List<double>.generate(widget.items.length, (index) {
      return 0.0;
    });
    _maxRadius = 50;
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _startAnimation(widget.currentIndex);
      _startScale(widget.currentIndex);
    }
  }

  void _startAnimation(int index) {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    CurvedAnimation _curvedAnimation = CurvedAnimation(
      parent: _controller!,
      curve: widget.bubbleCurve!,
    );
    Tween<double>(begin: 0.0, end: 1.0).animate(_curvedAnimation)
      .addListener(() {
        setState(() {
          _radiusList![index] = _maxRadius! * _curvedAnimation.value;
        });
      });
    _controller!.forward();
  }

  void _startScale(int index) {
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController!.reverse();
        }
      });
    CurvedAnimation _scaleAnimation = CurvedAnimation(
      parent: _scaleController!,
      curve: widget.scaleCurve!,
      reverseCurve: widget.scaleCurve!.flipped,
    );

    Tween<double>(begin: 0.0, end: 1.0).animate(_scaleAnimation)
      .addListener(() {
        setState(() {
          _sizes![index] = _scaleAnimation.value * widget.scaleFactor;
        });
      });
    _scaleController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    return Padding(
      padding: widget.isFloating!
          ? EdgeInsets.only(
              left: 16, right: 16, top: 0, bottom: additionalBottomPadding)
          : EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.all(20),
        // height: 75,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: widget.borderRadius,
        ),
        padding: widget.isFloating!
            ? EdgeInsets.zero
            : EdgeInsets.only(bottom: additionalBottomPadding),
        //height: 56, //+ (widget.isFloating ? 0.0 : additionalBottomPadding),
        // width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (var i = 0; i < widget.items.length; i++)
              _CustomNavigationBarTile(
                scale: _sizes![i],
                child: widget.items[i],
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomNavigationBarTile extends StatelessWidget {
  final Widget? child;
  final double? scale;

  const _CustomNavigationBarTile({
    Key? key,
    this.child,
    this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0 + scale!,
      child: child,
    );
  }
}
