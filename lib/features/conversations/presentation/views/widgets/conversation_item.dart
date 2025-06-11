import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/features/conversations/data/models/conversation_model/conversation_model.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;

  const ConversationItem({
    super.key,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    Participant receiver = conversation.participants.firstWhere(
            (p)=> p.id != CacheHelper.userId
    );
    bool isLastMessageSeen = conversation.lastMessage?.seen == true;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: Navigate to conversation detail
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(receiver.userProfileImage),
                    ),
                    if (isLastMessageSeen)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          // child: Text(
                          //   unreadCount.toString(),
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            receiver.name,
                            style: AppStyles.style17,
                          ),
                          Text(
                            conversation.updatedAt,
                            style:  AppStyles.style13,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        conversation.lastMessage?.text ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  AppStyles.style15.copyWith(
                          fontSize: 14,
                          color:
                          isLastMessageSeen
                              ? Colors.black87
                              :
                          Colors.grey[600],
                          fontWeight:
                          isLastMessageSeen
                              ? FontWeight.w500
                              :
                          FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
