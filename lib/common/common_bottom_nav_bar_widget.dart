import 'package:flutter/material.dart';

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.black12,
          icon: Icon(
            Icons.abc,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
          ),
          label: 'M.E.P.',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.local_post_office_outlined,
            color: Colors.black,
          ),
          label: 'Archief',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people_outline,
            color: Colors.black,
          ),
          label: 'Teams',
        ),
      ],
    );
  }
}
