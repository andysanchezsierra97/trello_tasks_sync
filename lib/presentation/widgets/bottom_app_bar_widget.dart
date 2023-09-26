import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomAppBarWidget({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black54,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_list),
          label: 'Normal Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_list),
          label: 'Trello Tasks',
        ),
      ],
    );
  }
}
