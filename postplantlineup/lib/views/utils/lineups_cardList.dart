import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:postplantlineup/views/utils/colors.dart';

class CardData {
  final String fieldName;
  final String? description;
  CardData(this.fieldName, this.description);
}
List<Widget> buildCards(Map<String, dynamic> data, Function(List<String>, Map<String, String?>) onTap) {
  var sortedData = Map.fromEntries(data.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  List<Widget> cardList = [];
  List<CardData> descriptions = [];

  sortedData.forEach((fieldName, value) {
    if (value is String) {
      if (value.startsWith("http")) {
        Widget cardChild = CachedNetworkImage(
          imageUrl: value,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

        cardList.add(
          GestureDetector(
            onTap: () => onTap(value.split(' , '), _getDescriptionMap(descriptions)),
            child: Card(
              elevation: 4,
              color: CustomColors.accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: cardChild,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      fieldName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: CustomColors.textColor,
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
      } else {
        String descriptionFieldName = "$fieldName Description";
        descriptions.add(CardData(fieldName, value)); // Açıklamaları listeye ekle
      }
    }
  });

  for (var desc in descriptions) {
    print("Description: ${desc.description}");
  }

  return cardList;
}

Map<String, String?> _getDescriptionMap(List<CardData> descriptions) {
  Map<String, String?> descriptionMap = {};
  for (var desc in descriptions) {
    descriptionMap[desc.fieldName] = desc.description;
  }
  return descriptionMap;
}
