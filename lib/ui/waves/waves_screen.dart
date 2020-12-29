import 'package:flutter/material.dart';

class WavesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LayoutBuilder(builder: (context, constraints) {
          return CustomPaint(
            size: constraints.biggest,
            painter: WavesPainter(),
          );
        }),
      ),
    );
  }
}

class WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.indigo[900]
      ..style = PaintingStyle.fill;

    final grid = WaveGrid(
      lanes: 12,
      hubs: <Hub>[
        Hub(
          origin: Offset.zero,
          length: 800.0,
        ),
        Hub(
          //control point!
          origin: Offset(200.0, 0),
          length: 200.0,
        ),
        Hub(
          origin: Offset(400.0, 0),
          length: 800.0,
        )
      ],
    );

    List<Path> lanes = grid.createWaveCoordinates().map((List<Offset> offsets) {
      final path = Path()..moveTo(offsets[0].dx, offsets[0].dy);

      for (var i = 0; i < offsets.length; i++) {
        final next = (i == offsets.length - 1) ? 0 : i + 1;

        path.quadraticBezierTo(
            offsets[i].dx, offsets[i].dy, offsets[next].dx, offsets[next].dy);
      }
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
  final Radius angle;
  final double length;
  final Offset origin;
  final MainAxisAlignment alignment;
  final double margin;

  Hub(
      {this.direction = AxisDirection.down,
      this.angle = Radius.zero,
      this.length,
      this.origin = Offset.zero,
      this.alignment = MainAxisAlignment.spaceBetween,
      this.margin = 5.0});

  List<HubNode> calculateHubNodes(int lanes) {
    // 0, 0 , 200 , 0
    // 200, 0 , 200, 200,
    // 200, 200, 800, 200,
    // 800, 200, 0, 0
    final marginTotal = margin * (lanes - 1);
    final nodeLength = (length - marginTotal) / lanes;
    return List.generate(lanes, (index) {
      double distanceOne = (index * margin) + (index * nodeLength);
      double distanceTwo = distanceOne + nodeLength;
      Offset first = Offset(origin.dx, origin.dy + distanceOne);
      Offset second = Offset(origin.dx, origin.dy + distanceTwo);
      return HubNode(first, second);
    });
  }
}

class HubNode {
  final Offset first;
  final Offset second;

  HubNode(this.first, this.second);
}

// void paint(Canvas canvas, Size size) {
//   final paint = Paint()
//     ..color = Colors.indigo[900]
//     ..style = PaintingStyle.fill;

//   final node0 = Offset(0, size.height / 2 - 10);
//   final node1 = Offset(size.width, size.height / 2 - 10);

//   final top0 = Offset(size.width / 3, size.height / 3 + 8);
//   final top1 = Offset(size.width / 3, size.height / 3 + 11);

//   final node2 = Offset(size.width, size.height / 2 + 10);
//   final node3 = Offset(0, size.height / 2 + 10);

//   final path = Path()
//     ..moveTo(node0.dx, node0.dy)
//     ..quadraticBezierTo(top0.dx, top0.dy, node1.dx, node1.dy)
//     ..lineTo(node2.dx, node2.dy)
//     ..quadraticBezierTo(top1.dx, top1.dy, node3.dx, node3.dy)
//     ..lineTo(node0.dx, node0.dy)
//     ..close();

//   canvas.drawPath(path, paint);

//   final node0b = Offset(0, size.height / 2 + 20);
//   final node1b = Offset(size.width, size.height / 2 + 20);

//   final top0b = Offset(size.width / 3 + 10, size.height / 3 + 12);
//   final top1b = Offset(size.width / 3 + 10, size.height / 3 + 15);

//   final node2b = Offset(size.width, size.height / 2 + 40);
//   final node3b = Offset(0, size.height / 2 + 40);

//   final pathb = Path()
//     ..moveTo(node0b.dx, node0b.dy)
//     ..quadraticBezierTo(top0b.dx, top0b.dy, node1b.dx, node1b.dy)
//     ..lineTo(node2b.dx, node2b.dy)
//     ..quadraticBezierTo(top1b.dx, top1b.dy, node3b.dx, node3b.dy)
//     ..lineTo(node0b.dx, node0b.dy)
//     ..close();

//   canvas.drawPath(pathb, paint);
