import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool _isInChat = false;
  String _currentChatWith = "";
  String _currentChatImage = "";

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      appBar: _buildAppBar(),
      body: _isInChat ? _buildChatScreen() : _buildMessagesList(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (_isInChat) {
      return AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF003D1A)),
          onPressed: () => setState(() => _isInChat = false),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(_currentChatImage),
              onBackgroundImageError: (_, _) {},
              child: _currentChatImage.isEmpty
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentChatWith,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF003D1A),
                  ),
                ),
                const Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF006D38),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Color(0xFF003D1A)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF003D1A)),
            onPressed: () {},
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Row(
        children: [
          Icon(Icons.eco, color: Color(0xFF003D1A)),
          SizedBox(width: 8),
          Text(
            "Messages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF003D1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE1E3DD)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search conversations...",
                hintStyle: TextStyle(color: Color(0xFF707970)),
                prefixIcon: Icon(Icons.search, color: Color(0xFF707970)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),

        // Chat List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildChatListItem(
                name: "Marcus Thorne",
                role: "Lead Technician",
                message: "I am 5 minutes away from your location.",
                time: "2m ago",
                unread: 1,
                imageUrl:
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDnhjs4eedidLmamRpW_I6QnhAiZ298TE3VAPUCGsG2EBKvx9HDIuAtj4iN-86laykTvKvkCGQ3RiSDB72iOkVc4cNIwr28_6zjqzlFDBwPaqskueImQPChosZt3qC_RFS-6H0crkTfU81I2utb_3ydMaSFInBiYDutzqzJDgs6wf1407sFXRZuEdlt-5pC3Y8_-eYXSTw78MlKmSx-iaLvocKb9mrQMb8x9ZeOWJF9bJKVv43yHr0DJMUG3-dnChOZPf3i1icox_i3",
                onTap: () => setState(() {
                  _isInChat = true;
                  _currentChatWith = "Marcus Thorne";
                  _currentChatImage =
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDnhjs4eedidLmamRpW_I6QnhAiZ298TE3VAPUCGsG2EBKvx9HDIuAtj4iN-86laykTvKvkCGQ3RiSDB72iOkVc4cNIwr28_6zjqzlFDBwPaqskueImQPChosZt3qC_RFS-6H0crkTfU81I2utb_3ydMaSFInBiYDutzqzJDgs6wf1407sFXRZuEdlt-5pC3Y8_-eYXSTw78MlKmSx-iaLvocKb9mrQMb8x9ZeOWJF9bJKVv43yHr0DJMUG3-dnChOZPf3i1icox_i3";
                }),
              ),
              _buildChatListItem(
                name: "Sarah Jenkins",
                role: "Field Expert",
                message: "The soil analysis report is ready for review.",
                time: "1h ago",
                unread: 0,
                imageUrl: "https://picsum.photos/id/64/200/200",
                onTap: () => setState(() {
                  _isInChat = true;
                  _currentChatWith = "Sarah Jenkins";
                  _currentChatImage = "https://picsum.photos/id/64/200/200";
                }),
              ),
              _buildChatListItem(
                name: "Eco-Dispatch System",
                role: "Automated Assistant",
                message: "Your service SR-2026-001 has been scheduled.",
                time: "Yesterday",
                unread: 0,
                imageUrl: "https://picsum.photos/id/1015/200/200",
                onTap: () => setState(() {
                  _isInChat = true;
                  _currentChatWith = "Eco-Dispatch System";
                  _currentChatImage = "https://picsum.photos/id/1015/200/200";
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatListItem({
    required String name,
    required String role,
    required String message,
    required String time,
    required int unread,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8EBE6)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (_, _) {},
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF003D1A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF707970),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF707970),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: unread > 0
                          ? const Color(0xFF191D19)
                          : const Color(0xFF707970),
                      fontWeight:
                          unread > 0 ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (unread > 0) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF006D38),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChatScreen() {
    return Column(
      children: [
        // Messages
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Service request accepted • Oct 24, 2023",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF707970),
                    ),
                  ),
                ),
              ),
              _buildMessageBubble(
                isMe: false,
                message:
                    "Good morning! I'm your assigned technician for today's desludging.",
                time: "09:15 AM",
              ),
              _buildMessageBubble(
                isMe: true,
                message:
                    "Hi Marcus, thank you. Will you need access to the back alley?",
                time: "09:17 AM",
              ),
              _buildMessageBubble(
                isMe: false,
                message: "Yes, that would be helpful. I'm 5 minutes away.",
                time: "09:22 AM",
              ),
            ],
          ),
        ),

        // Input Bar
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: Color(0xFF006D38)),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Color(0xFF707970)),
                      filled: true,
                      fillColor: const Color(0xFFF2F5EE),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF003D1A),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () {
                      // TODO: send message
                      _messageController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble({
    required bool isMe,
    required String message,
    required String time,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF12562B) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMe ? 18 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : const Color(0xFF191D19),
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 11,
                color: isMe ? Colors.white70 : const Color(0xFF707970),
              ),
            ),
          ],
        ),
      ),
    );
  }
}