import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../models/main_model.dart';
import '../screens/agents.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgentsPage()),
        );
      },
      child: Card(
        color: CustomColors.accentColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CustomColors.accentColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  card.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CustomColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

