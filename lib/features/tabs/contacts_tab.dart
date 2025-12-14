import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im/core/mock_data.dart';

class ContactsTab extends ConsumerWidget {
  const ContactsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reusing conversation mock data to simulate contacts
    final conversations = ref.watch(conversationsProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Contacts',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.person_add,
            color: Color(0xFF1A1D26),
          ),
          onPressed: () {},
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildActionItem(
                    CupertinoIcons.person_2_fill,
                    'New Friends',
                    const Color(0xFFFF9500),
                  ),
                  const Divider(height: 1, indent: 60),
                  _buildActionItem(
                    CupertinoIcons.person_3_fill,
                    'Group Chats',
                    const Color(0xFF34C759),
                  ),
                ],
              ),
            ),
            // Section A
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                color: const Color(0xFFF5F5F5),
                child: Text(
                  'A',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
              ),
            ),
            // Just reusing the list for demo purposes, filtering usually happens here
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = conversations[index].participants.first;
                  return Container(
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            user.avatarUrl,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  CupertinoIcons.person_circle,
                                  size: 44,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          user.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: const Color(0xFF1A1D26),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1, // Limit for section A mock
              ),
            ),
            // Section C
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                color: const Color(0xFFF5F5F5),
                child: Text(
                  'C',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                // Skip first one
                if (index + 1 >= conversations.length) {
                  return const SizedBox.shrink();
                }
                final user = conversations[index + 1].participants.first;
                return Container(
                  color: CupertinoColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          user.avatarUrl,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                CupertinoIcons.person_circle,
                                size: 44,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        user.name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: const Color(0xFF1A1D26),
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: conversations.length - 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, Color color) {
    return Container(
      color: CupertinoColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: const Color(0xFF1A1D26),
            ),
          ),
        ],
      ),
    );
  }
}
