import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../article_view.dart';
import '../models/article_model.dart';
import '../models/slider_model.dart';
import '../services/news.dart';
import '../services/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount:
              widget.news == "Breaking" ? sliders.length : articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              Image: widget.news == "Breaking"
                  ? sliders[index].urlToImage ?? TImages.placeHolder
                  : articles[index].urlToImage ?? TImages.placeHolder,
              title: widget.news == "Breaking"
                  ? sliders[index].title ?? "No Title Available"
                  : articles[index].title ?? "No Title Available",
              desc: widget.news == "Breaking"
                  ? sliders[index].description ?? "No Description Available"
                  : articles[index].description ?? "No Description Available",
              url: widget.news == "Breaking"
                  ? sliders[index].url ?? "No url Found"
                  : articles[index].url ?? "No url Found",
              isDarkMode: darkMode,
            );
          },
        ),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String Image, desc, title, url;
  final bool isDarkMode;

  AllNewsSection({
    required this.Image,
    required this.desc,
    required this.title,
    required this.url,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ArticleView(blogUrl: url)),
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: THelperFunctions.screenWidth(),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              maxLines: 3,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
