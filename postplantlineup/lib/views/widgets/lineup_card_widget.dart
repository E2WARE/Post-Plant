import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/lineups_full_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import '../../models/lineups_model.dart';

class LineupCardWidget extends StatefulWidget {
  final Lineup lineup;
  final List<String> imageUrls;
  final VoidCallback onTap;

  const LineupCardWidget({
    Key? key,
    required this.lineup,
    required this.imageUrls,
    required this.onTap,
  }) : super(key: key);

  @override
  _LineupCardWidgetState createState() => _LineupCardWidgetState();
}

class _LineupCardWidgetState extends State<LineupCardWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favoriteStatus = prefs.getBool('favorite_${widget.lineup.lineupName}') ?? false;
    bool favoriteStatusUrl = prefs.getBool('favorite_${widget.lineup.lineupImageUrl}') ?? false;
    bool favoriteStatusDesc = prefs.getBool('favorite_${widget.lineup.lineupDescription}') ?? false;
    print('Favorite status of ${widget.lineup.lineupName}: $favoriteStatus');
    setState(() {
      _isFavorite = favoriteStatus && favoriteStatusUrl && favoriteStatusDesc;
    });
  }

  void _toggleFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = !_isFavorite;
      prefs.setBool('favorite_${widget.lineup.lineupName}', _isFavorite);
      prefs.setBool('favorite_${widget.lineup.lineupImageUrl}', _isFavorite);
      prefs.setBool('favorite_${widget.lineup.lineupDescription}', _isFavorite);
      print('Favorite status of ${widget.lineup.lineupName} updated to: $_isFavorite');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        List<String> imageUrls = widget.lineup.lineupImageUrl.split(" , ");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImagePage(
              imageUrls: imageUrls,
              description: widget.lineup.lineupDescription,
            ),
          ),
        );
      },
      child: SizedBox(
        height: size.width * 0.5,
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
              SizedBox(
                height: size.width * 0.3,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(size.width * 0.03),
                      child: Image.network(
                        widget.lineup.lineupImageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColors.textColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: size.width * 0.02,
                      right: size.width * 0.02,
                      child: GestureDetector(
                        onTap: () {
                          _toggleFavorite();
                        },
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? CustomColors.primaryColor : CustomColors.textColor,
                          size: size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Text(
                  widget.lineup.lineupName,
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
      ),
    );
  }
}
