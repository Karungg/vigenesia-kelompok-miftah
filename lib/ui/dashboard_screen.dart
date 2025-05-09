import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia/constants/constants.dart';
import 'package:vigenesia/ui/home_screen.dart';
import 'package:vigenesia/ui/library_screen.dart';
import 'package:vigenesia/ui/search_category_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final String? nama;
  const DashBoardScreen({Key? key, this.nama}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: 64,
        width: MediaQuery.of(context).size.width,
        color: MyColors.blackColor.withOpacity(0.95),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontFamily: "AM", fontSize: 13),
            selectedItemColor: const Color(0xffE5E5E5),
            unselectedItemColor: MyColors.lightGrey,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('images/icon_home.png'),
                activeIcon: Image.asset('images/icon_home_active.png'),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/icon_search_bottomnav.png',
                ),
                activeIcon: Image.asset(
                  'images/icon_search_active.png',
                  color: MyColors.whiteColor,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/icon_library.png',
                  color: MyColors.lightGrey,
                ),
                activeIcon: Image.asset(
                  'images/icon_library_active.png',
                  color: MyColors.whiteColor,
                ),
                label: "Your Motivations",
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(nama: widget.nama),
          const SearchCategoryScreen(),
          LibraryScreen(nama: widget.nama),
        ],
      ),
    );
  }
}
