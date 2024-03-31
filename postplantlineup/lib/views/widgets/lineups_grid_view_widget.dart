import 'package:flutter/material.dart';

class LineupGridWidget extends StatelessWidget {
  final List<Widget> children;

  const LineupGridWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: size.width * 0.02,
      mainAxisSpacing: size.width * 0.02,
      childAspectRatio: 1.6 / 2,
      children: children,
    );
  }
}
