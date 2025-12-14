import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Discover',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildItem(
                    CupertinoIcons.compass,
                    'Moments',
                    const Color(0xFF6B48FF),
                  ),
                  const SizedBox(height: 20),
                  _buildItem(
                    CupertinoIcons.videocam_circle,
                    'Channels',
                    const Color(0xFFFF9500),
                  ),
                  const Divider(height: 1, indent: 60),
                  _buildItem(
                    CupertinoIcons.search,
                    'Search',
                    const Color(0xFFFF3B30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, Color color) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 17,
                color: const Color(0xFF1A1D26),
              ),
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_forward,
            color: Color(0xFFC7C7CC),
            size: 20,
          ),
        ],
      ),
    );
  }
}
