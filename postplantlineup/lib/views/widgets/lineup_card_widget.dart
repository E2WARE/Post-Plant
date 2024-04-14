import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/lineups_full_screen.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import '../../data/favorites_lineup_service.dart';
import '../../models/lineups_model.dart';

class LineupCardWidget extends StatefulWidget {
  final Lineup lineup;
  final List<String> imageUrls;

  const LineupCardWidget({
    super.key,
    required this.lineup,
    required this.imageUrls,
  });

  @override
  _LineupCardWidgetState createState() => _LineupCardWidgetState();
}

class _LineupCardWidgetState extends State<LineupCardWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  void _checkFavorite() async {
    bool isFavorite = await FavoriteLineupService.isLineupFavorite(widget.lineup);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  void _toggleFavorite() async {
    await FavoriteLineupService.toggleFavoriteLineup(widget.lineup);
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        _navigateToFullScreenPage();
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
            Stack(
              children: [
                SizedBox(
                  height: size.width * 0.3,
                  child: ClipRRect(
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
                ),
                Positioned(
                  top: size.width * 0.02,
                  right: size.width * 0.02,
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                      color: _isFavorite ? CustomColors.accentColor : CustomColors.accentColor,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.width * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Text(
                widget.lineup.lineupName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.044,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFullScreenPage() {
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
  }

}
