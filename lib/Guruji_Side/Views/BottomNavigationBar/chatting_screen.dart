import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/custom_appbar.dart';

const Color appGreen = Color(0xFF075E54);
const Color chatBackground = Color(0xFFECE5DD);
const Color sentBubble = Color(0xFFD9FDD3);

class YajmanChat {
  final String name;
  final String lastMessage;
  final String time;
  final String initials;
  final int unreadCount;
  final bool isOnline;
  final List<ChatMessage> messages;

  const YajmanChat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.initials,
    required this.unreadCount,
    required this.isOnline,
    required this.messages,
  });
}

class ChatMessage {
  final String text;
  final String time;
  final bool isSentByGuruji;

  const ChatMessage({
    required this.text,
    required this.time,
    required this.isSentByGuruji,
  });
}

// Demo conversations
const List<YajmanChat> demoChats = [
  YajmanChat(
    name: 'Rahul Sharma',
    lastMessage: 'Guruji, what time will the puja start?',
    time: '10:45 AM',
    initials: 'RS',
    unreadCount: 2,
    isOnline: true,
    messages: [
      ChatMessage(
        text: 'Namaste Guruji 🙏',
        time: '10:30 AM',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Namaste Rahul! How can I help you?',
        time: '10:32 AM',
        isSentByGuruji: true,
      ),
      ChatMessage(
        text: 'I want to arrange a Satyanarayan puja.',
        time: '10:40 AM',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Guruji, what time will the puja start?',
        time: '10:45 AM',
        isSentByGuruji: false,
      ),
    ],
  ),
  YajmanChat(
    name: 'Priya Patil',
    lastMessage: 'Thank you, Guruji 🙏',
    time: '10:20 AM',
    initials: 'PP',
    unreadCount: 0,
    isOnline: true,
    messages: [
      ChatMessage(
        text: 'Namaste Guruji, I need to book a Ganesh puja.',
        time: '10:10 AM',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Namaste Priya. Please tell me your preferred date.',
        time: '10:15 AM',
        isSentByGuruji: true,
      ),
      ChatMessage(
        text: 'Thank you, Guruji 🙏',
        time: '10:20 AM',
        isSentByGuruji: false,
      ),
    ],
  ),
  YajmanChat(
    name: 'Amit Deshmukh',
    lastMessage: 'I have confirmed the booking.',
    time: 'Yesterday',
    initials: 'AD',
    unreadCount: 1,
    isOnline: false,
    messages: [
      ChatMessage(
        text: 'Guruji, are you available this Sunday?',
        time: 'Yesterday',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Yes Amit, I am available on Sunday.',
        time: 'Yesterday',
        isSentByGuruji: true,
      ),
      ChatMessage(
        text: 'I have confirmed the booking.',
        time: 'Yesterday',
        isSentByGuruji: false,
      ),
    ],
  ),
  YajmanChat(
    name: 'Sneha Kulkarni',
    lastMessage: 'Please send the puja samagri list.',
    time: 'Yesterday',
    initials: 'SK',
    unreadCount: 0,
    isOnline: false,
    messages: [
      ChatMessage(
        text: 'Namaste Guruji.',
        time: 'Yesterday',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Namaste Sneha, how may I help you?',
        time: 'Yesterday',
        isSentByGuruji: true,
      ),
      ChatMessage(
        text: 'Please send the puja samagri list.',
        time: 'Yesterday',
        isSentByGuruji: false,
      ),
    ],
  ),
  YajmanChat(
    name: 'Rohan Joshi',
    lastMessage: 'Okay Guruji, see you tomorrow.',
    time: 'Monday',
    initials: 'RJ',
    unreadCount: 0,
    isOnline: false,
    messages: [
      ChatMessage(
        text: 'Can we schedule the puja for tomorrow?',
        time: 'Monday',
        isSentByGuruji: false,
      ),
      ChatMessage(
        text: 'Yes Rohan, tomorrow works for me.',
        time: 'Monday',
        isSentByGuruji: true,
      ),
      ChatMessage(
        text: 'Okay Guruji, see you tomorrow.',
        time: 'Monday',
        isSentByGuruji: false,
      ),
    ],
  ),
];

// Main chat list screen
class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Chats',
        subtitle: 'Connect with your Yajman',
        showLeading: false,
        showBackButton: false,
        showLogo: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar demo
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Yajman...',
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                prefixIcon: const Icon(Icons.search, color: appGreen),
                filled: true,
                fillColor: const Color.fromARGB(101, 240, 148, 105),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Chat list heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Recent Conversations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.chat_bubble_outline, color: appGreen, size: 20),
              ],
            ),
          ),

          // List of Yajman conversations
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: demoChats.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, indent: 82, endIndent: 16),
              itemBuilder: (context, index) {
                final chat = demoChats[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  leading: _ChatAvatar(
                    initials: chat.initials,
                    isOnline: chat.isOnline,
                    radius: 27,
                  ),
                  title: Text(
                    chat.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: chat.unreadCount > 0
                            ? Colors.black87
                            : Colors.grey.shade600,
                        fontWeight: chat.unreadCount > 0
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat.time,
                        style: TextStyle(
                          fontSize: 11,
                          color: chat.unreadCount > 0
                              ? appGreen
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 7),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: appGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${chat.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IndividualChatScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Individual Yajman chat screen
class IndividualChatScreen extends StatelessWidget {
  final YajmanChat chat;

  const IndividualChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: chat.name,
        subtitle: chat.isOnline ? 'Online' : 'Offline',
        showLogo: false,
        showLeading: true,
        showBackButton: true,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: chatBackground,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                const Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFE1F3FB),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      child: Text(
                        'TODAY',
                        style: TextStyle(
                          color: Color(0xFF54656F),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                ...chat.messages.map(
                  (message) => _MessageBubble(message: message),
                ),
              ],
            ),
          ),

          // Static message composer for UI demonstration
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: const Color(0xFFF0F2F5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const TextField(
                        minLines: 1,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          prefixIcon: Icon(Icons.emoji_emotions_outlined),
                          suffixIcon: Icon(Icons.attach_file),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: appGreen,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Message bubble
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSentByGuruji;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(11, 9, 9, 6),
        decoration: BoxDecoration(
          color: isSent ? sentBubble : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isSent ? 12 : 2),
            bottomRight: Radius.circular(isSent ? 2 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF111B21),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF667781),
                  ),
                ),
                if (isSent) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.done_all,
                    size: 15,
                    color: Color(0xFF34B7F1),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Avatar with online indicator
class _ChatAvatar extends StatelessWidget {
  final String initials;
  final bool isOnline;
  final double radius;

  const _ChatAvatar({
    required this.initials,
    required this.isOnline,
    this.radius = 27,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: const Color(0xFFF3D98A),
          child: Text(
            initials,
            style: const TextStyle(
              color: Color(0xFF4A2418),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
