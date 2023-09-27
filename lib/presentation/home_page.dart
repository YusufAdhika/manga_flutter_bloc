import 'package:flutter/material.dart';
import 'package:read_manga_bloc/presentation/pages/bookmark_manga_page.dart';
import 'package:read_manga_bloc/presentation/pages/info_page.dart';
import 'package:read_manga_bloc/presentation/pages/manga_list_page.dart';
import 'package:read_manga_bloc/presentation/pages/manga_recommended_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.recommend),
      label: 'Suggest',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_rounded),
      label: 'Bookmark',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_outline),
      label: 'About',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
      _bottomNavIndex == 0 ? _scrollListener() : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [
      MangaListPage(
        scrollController: scrollController,
      ),
      const MangaRecommendedPage(),
      const BookmarkPage(),
      const InfoPage(),
    ];
    return Scaffold(
      body: listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white38,
        selectedItemColor: Colors.white,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  void _scrollListener() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
