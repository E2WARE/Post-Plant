import 'package:flutter/material.dart';
import 'package:postplantlineup/views/widgets/site_card_widget.dart';
import '../utils/colors.dart';
import '../../models/sites_model.dart';
import '../../view_models/map_view_model.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/site_view_model.dart';

class SitesGridViewWidget extends StatelessWidget {
  final List<SiteModel> sites;
  final Function(String) onSiteSelected;
  final AgentCardViewModel agentCardViewModel;
  final MapCardViewModel mapCardViewModel;

  const SitesGridViewWidget({super.key,
    required this.sites,
    required this.onSiteSelected,
    required this.agentCardViewModel,
    required this.mapCardViewModel,
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
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 4 / 2,
        children: sites.map((map) {
          return SiteCardWidget(
            siteCardViewModel: SiteCardViewModel(
              site: map,
              onSiteSelected: onSiteSelected,
            ),
            agentCardViewModel: agentCardViewModel,
            mapCardViewModel: mapCardViewModel,
          );
        }).toList(),
      ),
    );
  }
}
