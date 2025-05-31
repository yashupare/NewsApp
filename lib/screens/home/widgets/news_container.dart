import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbrief/utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import 'detailed_view.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsHeading;
  final String newsDescription;
  final String newsContent;
  final String newsUrl;

  NewsContainer({
    super.key,
    required this.imgUrl,
    required this.newsDescription,
    required this.newsHeading,
    required this.newsUrl,
    required this.newsContent,
  });

  // Function to remove "[+XXXX chars]" from news content
  String cleanNewsContent(String content) {
    return content.replaceAll(RegExp(r'\[\+\d+\s+chars\]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              image: imgUrl,
              placeholder: TImages.placeHolder,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  TImages.placeHolder, // Display placeholder image when the network image fails
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsHeading.length > 90 ? "${newsHeading.substring(0, 90)}..." : newsHeading,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 10),
                    Text(newsDescription, style: TextStyle(height: 1.2)),
                    SizedBox(height: 10),
                    Text(
                      cleanNewsContent(
                        newsContent.length > 250 ? "${newsContent.substring(0, 250)}..." : newsContent,
                      ),
                      style: TextStyle(height: 1.2),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => DetailViewScreen(newsUrl: newsUrl)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Read More"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
