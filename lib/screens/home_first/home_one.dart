import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbrief/app.dart';
import 'package:inbrief/screens/home_first/article_view.dart';
import 'package:inbrief/screens/home_first/models/article_model.dart';
import 'package:inbrief/screens/home_first/models/category_model.dart';
import 'package:inbrief/screens/home_first/models/slider_model.dart';
import 'package:inbrief/screens/home_first/pages/all_news.dart';
import 'package:inbrief/screens/home_first/pages/category_news.dart';
import 'package:inbrief/screens/home_first/services/data.dart';
import 'package:inbrief/screens/home_first/services/news.dart';
import 'package:inbrief/screens/home_first/services/slider_data.dart';
import 'package:inbrief/utils/constants/image_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';

class HomeOne extends StatefulWidget {
  const HomeOne({super.key});

  @override
  State<HomeOne> createState() => _HomeOneState();
}

class _HomeOneState extends State<HomeOne> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;

  }

  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
          title:Text(TTexts.homeAppbarTitle,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      image: categories[index].image,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breaking News',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20.0,
                        fontWeight: FontWeight.bold,),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => AllNews(news: "Breaking")),
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (context, index, realIndex) {
                  String? res = sliders[index].urlToImage;
                  String? res1 = sliders[index].title;
                  return buildImage(res! ?? TImages.placeHolder, index, res1!);
                },
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Center(child: buildIndicator()),
              SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending News',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20.0,
                        fontWeight: FontWeight.bold,),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => AllNews(news: "Trending")),
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlockTile(
                        url: articles[index].url ?? "",
                        imageUrl: articles[index].urlToImage ??
                            TImages.placeHolder,
                        title:
                        articles[index].title ?? "No Title Available",
                        desc: articles[index].description ??
                            "No Description Available",
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            height: 250,
            fit: BoxFit.cover,
            width: THelperFunctions.screenWidth(),
            httpHeaders: {
              'User-Agent': 'Mozilla/5.0', // Some servers block Flutter's default user agent
              'Accept': 'image/*',
            },
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Image.asset(
              TImages.placeHolder, // Use placeholder image if loading fails
              height: 250,
              width: THelperFunctions.screenWidth(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
          margin: EdgeInsets.only(top: 110.0),
          width: THelperFunctions.screenWidth(),
          decoration: BoxDecoration(
              color:  Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Text(
            name ?? "No Title Available",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

        )
      ]));
  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect:
    SlideEffect(dotWidth: 8, dotHeight: 8, activeDotColor: Colors.blue),
  );
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, this.image, this.categoryName});
  final image, categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(()=> CategoryNews(name: categoryName)),
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:
              Image.asset(image, width: 120, height: 60, fit: BoxFit.cover),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.black38),
              child: Center(
                  child: Text(categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}

class BlockTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  const BlockTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ArticleView(blogUrl: url)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    httpHeaders: {
                      'User-Agent': 'Mozilla/5.0',
                      'Accept': 'image/*',
                    },
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      TImages.placeHolder,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
