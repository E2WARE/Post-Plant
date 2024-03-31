import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../models/maps_model.dart';
import '../../view_models/map_view_model.dart';
import '../../view_models/agents_view_model.dart';
import '../widgets/map_card_widget.dart';

class MapsGridViewWidget extends StatelessWidget {
  final List<MapModel> maps;
  final Function(String) onMapSelected;
  final AgentCardViewModel agentCardViewModel;

  const MapsGridViewWidget({super.key,
    required this.maps,
    required this.onMapSelected,
    required this.agentCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primaryColor,
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: GridView.count(
        crossAxisCount: size.width > 600 ? 4 : 2,
        crossAxisSpacing: size.width * 0.02,
        mainAxisSpacing: size.width * 0.02,
        childAspectRatio: 1.5 / 1.9,
        children: maps.map((map) {
          return MapCardWidget(
            mapCardViewModel: MapCardViewModel(
              map: map,
              onMapSelected: onMapSelected,
            ),
            agentCardViewModel: agentCardViewModel,
          );
        }).toList(),
      ),
    );
  }
}
