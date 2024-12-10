import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int value, _) {
          return BottomNavigationBar(
            onTap: (index) {
              indexChangeNotifier.value = index;
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: value,
            elevation: 0,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            backgroundColor: backgroundColor,
            selectedIconTheme: const IconThemeData(
              color: selectedItemColor,
            ),
            unselectedIconTheme: const IconThemeData(
              color: unselectedItemColor,
            ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.collections,
                  ),
                  label: 'New & Hot'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.emoji_emotions,
                  ),
                  label: 'Fast Laugh'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.download,
                  ),
                  label: 'Downloads'),
            ],
          );
        });
  }
}
