import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im/core/mock_data.dart';

class MeTab extends ConsumerWidget {
  const MeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      child: CustomScrollView(
        slivers: [
          // No Navigation Bar for Me Tab as per design
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: CupertinoColors.white,
                  padding: const EdgeInsets.only(
                    top: 84,
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: user != null
                            ? Image.network(
                                user.avatarUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      CupertinoIcons.person_circle,
                                      size: 70,
                                    ),
                              )
                            : const Icon(
                                CupertinoIcons.person_circle,
                                size: 70,
                              ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Profile',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1A1D26),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: gemini_user_123',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF8E8E93),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.qrcode,
                        color: Color(0xFF8E8E93),
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        CupertinoIcons.chevron_forward,
                        color: Color(0xFFC7C7CC),
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  CupertinoIcons.gear_solid,
                  'Services',
                  const Color(0xFF007AFF),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  CupertinoIcons.smiley,
                  'Sticker Gallery',
                  const Color(0xFFFF9500),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  CupertinoIcons.settings,
                  'Settings',
                  const Color(0xFF007AFF),
                  onTap: () {
                    ref.read(authProvider.notifier).logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: CupertinoColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
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
      ),
    );
  }
}
