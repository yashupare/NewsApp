import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbrief/screens/home_first/article_view.dart';
import 'package:inbrief/screens/home_first/models/show_categories.dart';
import 'package:inbrief/screens/home_first/services/show_category_news.dart';
import 'package:inbrief/utils/helpers/helper_functions.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({required this.name, Key? key}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    try {
      setState(() {
        _loading = true;
        _errorMessage = null;
      });

      final showCategoryNews = ShowCategoryNews();
      await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());

      if (mounted) {
        setState(() {
          categories = showCategoryNews.categories;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Failed to load news. Please try again.";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadNews,
          ),
        ],
      ),
      body: _errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadNews,
              child: Text("Retry"),
            ),
          ],
        ),
      )
          : _loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadNews,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: categories.isEmpty
              ? Center(
            child: Text(
              "No articles found",
              style: theme.textTheme.bodyLarge,
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ShowCategory(
                image: categories[index].urlToImage ?? "",
                title: categories[index].title ?? "No Title Available",
                desc: categories[index].description ?? "No Description Available",
                url: categories[index].url ?? "",
                isDarkMode: isDarkMode,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  final bool isDarkMode;

  const ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ArticleView(blogUrl: url)),
      child: Container(
        margin: EdgeInsets.only(bottom: TSizes.spaceBtwSections),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  TImages.placeHolder,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}