import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../models/main_model.dart';
import '../../view_models/main_view_model.dart';
import 'main_card_widget.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  final GridViewViewModel viewModel = GridViewViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadCards();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: CustomColors.primaryColor,
      child: StreamBuilder<List<CardModel>>(
        stream: viewModel.cardsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.count(
              crossAxisCount: size.width > 600 ? 4 : 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: (snapshot.data ?? []).map((card) {
                return CardWidget(card: card);
              }).toList(),
          );
          }
        },
      ),
    );
  }
}
