import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/conversations/data/models/conversation_model/conversation_model.dart';
import 'package:chat/features/conversations/presentation/manager/conversations_cubit/conversations_cubit.dart';
import 'package:chat/features/conversations/presentation/manager/conversations_cubit/conversations_states.dart';
import 'package:chat/features/conversations/presentation/views/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ConversationsView extends StatelessWidget {
  const ConversationsView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ConversationsCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'chats'.tr,
          style: AppStyles.style18,
        ),
      ),
      body: BlocBuilder<ConversationsCubit, ConversationsStates>(
        builder: (context, state) {
          List<ConversationModel> conversations = cubit.conversations;
          if(state is GetConversationsErrorState){
            return CustomErrorWidget();
          }
          if(conversations.isEmpty){
            return EmptyListWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              return ConversationItem(
                conversation: conversations[index],
              );
            },
          );
        },
      ),
    );
  }
}

