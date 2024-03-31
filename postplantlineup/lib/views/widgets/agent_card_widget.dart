import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../view_models/agents_view_model.dart';
import '../screens/maps.dart';

class AgentCardWidget extends StatelessWidget {
  final AgentCardViewModel viewModel;
  const AgentCardWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        viewModel.selectAgent();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapsPage(agentCardViewModel: viewModel),
          ),
        );
      },
      child: Card(
        elevation: 4,
        color: CustomColors.primaryColor,
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
                  viewModel.agent.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Text(
                viewModel.agent.name,
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