import 'dart:math' as math;
import 'package:flutter/material.dart';

class WavesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WavesScreenState();
}

class WavesScreenState extends State<WavesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          })
          ..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LayoutBuilder(builder: (context, constraints) {
          return CustomPaint(
            size: constraints.biggest,
            painter: WavesPainter(controller: _controller),
          );
        }),
      ),
    );
  }
}

class WavesPainter extends CustomPainter {
  final AnimationController controller;

  WavesPainter({this.controller}) : super(repaint: controller);

  Tween<Offset> topDownTween =
      Tween<Offset>(begin: Offset(0, -100), end: Offset(0, 100));

  Tween<Offset> leftRightTween =
      Tween<Offset>(begin: Offset(-100, 0), end: Offset(100, 0));

  Tween<double> scaleUpTween = Tween<double>(begin: 1.0, end: 1.5);
  Tween<double> scaleUpUpTween = Tween<double>(begin: 1.0, end: 3.0);

  Tween<double> angleTween = Tween<double>(begin: 0.0, end: 0.0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.indigo[900]
      ..style = PaintingStyle.fill;

    final grid = WaveGrid(
      lanes: 15,
      hubs: <Hub>[
        Hub(
          origin: Offset(0, 100),
          length: 700.0,
          margin: 20,
        ),
        Hub(
          //control point!
          origin:
              Offset(200.0, -100.0) + leftRightTween.animate(controller).value,
          length: 200.0,
          margin: 2,
          angle: 0.0 + angleTween.animate(controller).value,
        ),
        Hub(
          origin: Offset(400.0, 100) + topDownTween.animate(controller).value,
          length: 2500.0,
          margin: 20,
        )
      ],
    );

    List<Path> lanes = grid.createWaveCoordinates().map((List<Offset> offsets) {
      final path = Path();
      final origin = offsets[0];

      path.moveTo(origin.dx, origin.dy);

      // path.conicTo(
      //     offsets[1].dx, offsets[1].dy, offsets[2].dx, offsets[2].dy, 1);

      path.quadraticBezierTo(
          offsets[1].dx, offsets[1].dy, offsets[2].dx, offsets[2].dy);

      // path.cubicTo(offsets[1].dx - 5, offsets[1].dy, offsets[1].dx + 5,
      //     offsets[1].dy, offsets[2].dx, offsets[2].dy);

      path.lineTo(offsets[3].dx, offsets[3].dy);

      // path.conicTo(
      //     offsets[4].dx, offsets[4].dy, offsets[5].dx, offsets[5].dy, 1);

      path.quadraticBezierTo(
          offsets[4].dx, offsets[4].dy, offsets[5].dx, offsets[5].dy);

      // path.cubicTo(offsets[4].dx - 5, offsets[4].dy, offsets[4].dx + 5,
      //     offsets[4].dy, offsets[5].dx, offsets[5].dy);

      path.lineTo(origin.dx, origin.dy);
      path.close();

      return path;
    }).toList();

    lanes.forEach((path) => canvas.drawPath(path, paint));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WaveGrid {
  final int lanes;
  final List<Hub> hubs;

  WaveGrid({this.lanes, this.hubs});

  List<List<Offset>> createWaveCoordinates() {
    final List<List<HubNode>> hubsList = hubs.map((hub) {
      return hub.calculateHubNodes(lanes);
    }).toList();

    final List<List<HubNode>> lanesList = List.generate(lanes, (index) {
      return hubsList.map((nodeList) {
        return nodeList[index];
      }).toList();
    });

    return lanesList.map((hubNodes) {
      final first = <Offset>[];
      final second = <Offset>[];
      hubNodes.forEach((hubNode) {
        first.add(hubNode.first);
        second.add(hubNode.second);
      });
      return [...first, ...second.reversed];
    }).toList();
  }
}

class Hub {
  final AxisDirection direction;
  final double angle;
  final double length;
  final Offset origin;
  final MainAxisAlignment alignment;
  final double margin;

  Hub(
      {this.direction = AxisDirection.down,
      this.angle = 0.0,
      this.length,
      this.origin = Offset.zero,
      this.alignment = MainAxisAlignment.spaceBetween,
      this.margin = 5.0});

  List<HubNode> calculateHubNodes(int lanes) {
    final marginTotal = margin * (lanes - 1);
    final nodeLength = (length - marginTotal) / lanes;
    return List.generate(lanes, (index) {
      double distanceOne = (index * margin) + (index * nodeLength);
      double distanceTwo = distanceOne + nodeLength;
      Offset first = Offset(origin.dx, origin.dy + distanceOne);
      Offset second = Offset(origin.dx, origin.dy + distanceTwo);

      if (angle != 0.0) {
        final radius = distanceOne;
        //calculate vector from origin
        final dx = radius * math.cos(angle);
        final dy = radius * math.sin(angle);
        first = Offset(origin.dx + dy, origin.dy + dx); //flipped it

        final radius2 = distanceTwo;
        final dx2 = radius2 * math.cos(angle);
        final dy2 = radius2 * math.sin(angle);
        second = Offset(origin.dx + dy2, origin.dy + dx2);
      }

      return HubNode(first, second);
    });
  }
}

class HubNode {
  final Offset first;
  final Offset second;

  HubNode(this.first, this.second);
}
