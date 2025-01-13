
import 'package:flutter/material.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });
final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: Colors.greenAccent,
        padding: const EdgeInsets.only(bottom: 0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(top: -150, right: -250, child: CircularContainer(backgroundColor: Colors.white38.withOpacity(0.1))),
              Positioned(top: 100, right: -300, child: CircularContainer(backgroundColor: Colors.white38.withOpacity(0.1))),
              child,
            ],
          ),
        ),
      ),
    );
  }
}


