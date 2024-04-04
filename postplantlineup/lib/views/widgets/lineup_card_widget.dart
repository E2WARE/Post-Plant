import 'package:flutter/material.dart';
import '../utils/colors.dart';

class LineupCardWidget extends StatelessWidget {
  final String fieldName;
  final List<String> urls;
  final Function(List<String>) onTap;

  const LineupCardWidget({
    super.key,
    required this.fieldName,
    required this.urls,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onTap(urls),
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
                borderRadius: BorderRadius.circular(size.width * 0.03),
                child: Image.network(
                  urls[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Text(
                fieldName,
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