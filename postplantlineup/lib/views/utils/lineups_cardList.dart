import 'package:flutter/material.dart';
import 'package:postplantlineup/views/utils/colors.dart';

List<Widget> buildCards(Map<String, dynamic> data, Function(List<String>) onTap) {
  var sortedData = Map.fromEntries(data.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  List<Widget> cardList = [];
  sortedData.forEach((fieldName, value) {
    cardList.add(
      GestureDetector(
        onTap: () => onTap(value.split(' , ')),
        child: Card(
          elevation: 4,
          color: CustomColors.accentColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  value.split(' , ')[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fieldName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: CustomColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
  return cardList;
}
