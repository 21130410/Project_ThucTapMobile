
import 'package:ban_mobile/Widgets/Custom_Shaps/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class CurvedEdgesWidget extends StatelessWidget {
  const CurvedEdgesWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {

    return ClipPath(
        clipper: CustomCurvedEges(),
        child: child
    );
  }
}