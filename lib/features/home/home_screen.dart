import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im/features/tabs/calls_tab.dart';
import 'package:im/features/tabs/chats_tab.dart';
import 'package:im/features/tabs/contacts_tab.dart';
import 'package:im/features/tabs/discover_tab.dart';
import 'package:im/features/tabs/me_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 68,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.phone),
                const SizedBox(height: 2),
                Builder(
                  builder: (context) {
                    return Text(
                      'Calls',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: IconTheme.of(context).color,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(CupertinoIcons.chat_bubble_2_fill),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Icon(
                        CupertinoIcons.circle_filled,
                        color: CupertinoColors.systemRed,
                        size: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Builder(
                  builder: (context) {
                    return Text(
                      'Chats',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: IconTheme.of(context).color,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.person_2_fill),
                const SizedBox(height: 2),
                Builder(
                  builder: (context) {
                    return Text(
                      'Contacts',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: IconTheme.of(context).color,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.compass),
                const SizedBox(height: 2),
                Builder(
                  builder: (context) {
                    return Text(
                      'Discover',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: IconTheme.of(context).color,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.person),
                const SizedBox(height: 2),
                Builder(
                  builder: (context) {
                    return Text(
                      'Me',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: IconTheme.of(context).color,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const CallsTab();
          case 1:
            return const ChatsTab();
          case 2:
            return const ContactsTab();
          case 3:
            return const DiscoverTab();
          case 4:
            return const MeTab();
          default:
            return const ChatsTab();
        }
      },
      // To set default index, we need a controller.
      controller: CupertinoTabController(initialIndex: 1),
    );
  }
}
