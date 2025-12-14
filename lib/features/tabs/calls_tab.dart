import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im/core/mock_data.dart';

class CallsTab extends ConsumerWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reusing conversation mock data for calls list simulation
    final conversations = ref.watch(conversationsProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Calls',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.phone, color: Color(0xFF1A1D26)),
              onPressed: () {},
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.videocam,
                color: Color(0xFF1A1D26),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: CupertinoSearchTextField(
                  placeholder: 'Search calls',
                  style: GoogleFonts.inter(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final conversation = conversations[index];
                final otherUser = conversation.participants.first;
                final isVideo = index % 2 == 0; // Mock

                return Container(
                  color: CupertinoColors.systemBackground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          otherUser.avatarUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                CupertinoIcons.person_circle,
                                size: 50,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              otherUser.name,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color(0xFF1A1D26),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  isVideo
                                      ? CupertinoIcons.videocam
                                      : CupertinoIcons.phone,
                                  size: 14,
                                  color: const Color(0xFF8E8E93),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isVideo
                                      ? 'Video • 10:42 AM'
                                      : 'Voice • Yesterday',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF8E8E93),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Icon(
                          isVideo
                              ? CupertinoIcons.videocam
                              : CupertinoIcons.phone,
                          color: const Color(0xFF6B48FF),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: conversations.length),
            ),
          ],
        ),
      ),
    );
  }
}
