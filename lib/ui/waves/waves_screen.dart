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

    final node0 = Offset(0, size.height / 2 - 10);
    final node1 = Offset(size.width, size.height / 2 - 10);

    final top0 = Offset(size.width / 3, size.height / 3 + 8);
    final top1 = Offset(size.width / 3, size.height / 3 + 11);

    final node2 = Offset(size.width, size.height / 2 + 10);
    final node3 = Offset(0, size.height / 2 + 10);

    final path = Path()
      ..moveTo(node0.dx, node0.dy)
      ..quadraticBezierTo(top0.dx, top0.dy, node1.dx, node1.dy)
      ..lineTo(node2.dx, node2.dy)
      ..quadraticBezierTo(top1.dx, top1.dy, node3.dx, node3.dy)
      ..lineTo(node0.dx, node0.dy)
      ..close();

    canvas.drawPath(path, paint);

    final node0b = Offset(0, size.height / 2 + 20);
    final node1b = Offset(size.width, size.height / 2 + 20);

    final top0b = Offset(size.width / 3 + 10, size.height / 3 + 12);
    final top1b = Offset(size.width / 3 + 10, size.height / 3 + 15);

    final node2b = Offset(size.width, size.height / 2 + 40);
    final node3b = Offset(0, size.height / 2 + 40);

    final pathb = Path()
      ..moveTo(node0b.dx, node0b.dy)
      ..quadraticBezierTo(top0b.dx, top0b.dy, node1b.dx, node1b.dy)
      ..lineTo(node2b.dx, node2b.dy)
      ..quadraticBezierTo(top1b.dx, top1b.dy, node3b.dx, node3b.dy)
      ..lineTo(node0b.dx, node0b.dy)
      ..close();

    canvas.drawPath(pathb, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
