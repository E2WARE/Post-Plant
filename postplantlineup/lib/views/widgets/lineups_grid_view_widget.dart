import 'package:flutter/material.dart';
import '../../models/lineups_model.dart';
import '../widgets/lineup_card_widget.dart';

class LineupGridViewWidget extends StatelessWidget {
  final List<Lineup> lineups;

  const LineupGridViewWidget({
    super.key,
    required this.lineups,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: lineups.length,
      itemBuilder: (context, index) {
        final lineup = lineups[index];
        return LineupCardWidget(
          imageUrls: const [],
          lineup: lineup,
        );
      },
    );
  }
}
