import 'package:flutter/material.dart';
import 'package:inbrief/model/newsArt.dart';
import 'package:inbrief/screens/home/widgets/news_container.dart';
import '../../controller/fetch_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<NewsArt> newsList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchInitialNews();
  }

  Future<void> fetchInitialNews() async {
    newsList.add(await FetchNews.fetchNews());
    newsList.add(await FetchNews.fetchNews());

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchNextNews() async {
    NewsArt nextNews = await FetchNews.fetchNews();
    setState(() {
      newsList.add(nextNews);
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          if (value == newsList.length - 1) {
            fetchNextNews();
          }
        },
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return isLoading && index == newsList.length - 1
              ? Center(child: CircularProgressIndicator())
              : NewsContainer(
            imgUrl: newsList[index].imgUrl,
            newsDescription: newsList[index].newsDescription,
            newsHeading: newsList[index].newsHeading,
            newsUrl: newsList[index].newsUrl,
            newsContent: newsList[index].newsContent,
          );
        },
      ),
    );
  }
}
