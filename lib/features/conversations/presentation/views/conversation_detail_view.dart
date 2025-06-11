import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/conversations/data/models/message_model/message_model.dart';
import 'package:chat/features/conversations/presentation/manager/conversations_cubit/conversations_cubit.dart';
import 'package:chat/features/conversations/presentation/manager/conversations_cubit/conversations_states.dart';
import 'package:chat/features/conversations/presentation/views/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ConversationDetailView extends StatelessWidget {
  final String receiverName;
  final String receiverImage;


  const ConversationDetailView({
    super.key,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<ConversationsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(receiverImage),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receiverName,
                    style: AppStyles.style16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'online'.tr,
                    style: AppStyles.style12.copyWith(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.video_call, color: Colors.black87),
              onPressed: () {
                // TODO: Implement video call
              },
            ),
            IconButton(
              icon: const Icon(Icons.call, color: Colors.black87),
              onPressed: () {
                // TODO: Implement voice call
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ConversationsCubit, ConversationsStates>(
                builder: (context, state) {
                  var cubit = context.read<ConversationsCubit>();
                  List<MessageModel> messages = cubit.messages;
                  if(state is GetMessagesErrorState){
                    return CustomErrorWidget();
                  }
                  if(messages.isEmpty){
                    return EmptyListWidget();
                  }
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe =
                          message.from ==
                          CacheHelper.userId;

                      return MessageItem(isMe: isMe, message: message);
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        // TODO: Implement attachment
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'type_message'.tr,
                            hintStyle: AppStyles.style14.copyWith(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                          style: AppStyles.style14,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // TODO: Implement send message
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
