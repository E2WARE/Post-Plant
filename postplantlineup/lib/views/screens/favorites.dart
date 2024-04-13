import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import '../../data/favorites_lineup_service.dart';
import '../../models/lineups_model.dart';
import '../utils/banner_ad_widget.dart';
import '../widgets/lineup_card_widget.dart';

class FavoriteLineupsPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const FavoriteLineupsPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteLineupsPageState createState() => _FavoriteLineupsPageState();
}

class _FavoriteLineupsPageState extends State<FavoriteLineupsPage> {
  late List<Lineup> _favoriteLineups = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteLineups();
  }

  Future<void> _loadFavoriteLineups() async {
    List<Map<String, dynamic>> favoriteLineups = await FavoriteLineupService.getFavoriteLineups();
    List<Lineup> lineups = favoriteLineups.map((fav) => Lineup.fromJson(fav)).toList();
    setState(() {
      _favoriteLineups = lineups;
    });
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: _favoriteLineups.isEmpty
                ? Center(
              child: Text(
                'No favorite lineups found.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width > 600 ? 24.0 : 16.0,
                ),
              ),
            )
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _favoriteLineups.length,
              itemBuilder: (context, index) {
                final lineup = _favoriteLineups[index];
                return LineupCardWidget(
                  lineup: lineup,
                  imageUrls: const [],
                );
              },
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
