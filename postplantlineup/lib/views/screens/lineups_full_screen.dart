import 'package:flutter/material.dart';
import '../utils/colors.dart';

class FullScreenImagePage extends StatefulWidget {
  final List<String> urls;
  final String agentName;
  final String mapName;
  final String siteName;

  const FullScreenImagePage({
    super.key,
    required this.urls,
    required this.agentName,
    required this.mapName,
    required this.siteName,
  });

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final appBarText = "${widget.agentName} - ${widget.mapName} - ${widget.siteName}";
    final double appBarFontSize = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarText,
          style: TextStyle(
            color: CustomColors.textColor,
            fontSize: appBarFontSize,
          ),
        ),
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: CustomColors.primaryColor,
      body: PageView.builder(
        itemCount: widget.urls.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 4.0,
            child: Image.network(
              widget.urls[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
