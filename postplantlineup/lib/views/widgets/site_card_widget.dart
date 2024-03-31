import 'package:flutter/material.dart';
import '../../view_models/site_view_model.dart';
import '../screens/lineups.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../utils/colors.dart';

class SiteCardWidget extends StatelessWidget {
  final SiteCardViewModel siteCardViewModel;
  final MapCardViewModel mapCardViewModel;
  final AgentCardViewModel agentCardViewModel;
  const SiteCardWidget({
    super.key,
    required this.siteCardViewModel,
    required this.mapCardViewModel,
    required this.agentCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        siteCardViewModel.selectSite();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LineupPage(
              siteCardViewModel : siteCardViewModel,
              mapCardViewModel: mapCardViewModel,
              agentCardViewModel: agentCardViewModel,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        color: CustomColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.03),
          side: const BorderSide(color: CustomColors.accentColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.025),
                child: Image.asset(
                  siteCardViewModel.site.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Text(
                siteCardViewModel.site.siteName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}