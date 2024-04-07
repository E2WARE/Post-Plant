import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:postplantlineup/views/utils/colors.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<String> imageUrls;
  final String description;

  const FullScreenImagePage({
    super.key,
    required this.imageUrls,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lineups Details',
          style: TextStyle(color: CustomColors.textColor),
        ),
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: CustomColors.primaryColor,
              child: Center(
                child: SizedBox(
                  child: Image.network(
                    imageUrls.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return PhotoView(
                      imageProvider: NetworkImage(imageUrls[index]),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      initialScale: PhotoViewComputedScale.contained,
                      loadingBuilder: (context, event) => const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.textColor), // Set custom color for loading icon
                        ),
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: CustomColors.primaryColor, // Set the background color here
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                    color: CustomColors.textColor, // Set the text color to white
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
