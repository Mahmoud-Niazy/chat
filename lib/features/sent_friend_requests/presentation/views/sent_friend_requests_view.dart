import 'package:chat/core/widgets/custom_app_bar.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/core/widgets/empty_list_widget.dart';
import 'package:chat/features/sent_friend_requests/data/models/sent_friend_request_model/sent_friend_request_model.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_cubit.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_states.dart';
import 'package:chat/features/sent_friend_requests/presentation/views/widgets/sent_friend_request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SentFriendRequestsView extends StatelessWidget {
  const SentFriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SentFriendRequestsCubit>();
    return Scaffold(
      appBar: CustomAppBar(title: 'sent_friend_requests'.tr),
      body: BlocBuilder<SentFriendRequestsCubit, SentFriendRequestsStates>(
        builder: (context, state) {
          if (state is GetSentFriendRequestsLoadingState) {
            return const CustomCircularProgressIndicator();
          }
          if(state is SentFriendRequestsErrorState){
            return CustomErrorWidget();
          }
          List<SentFriendRequestModel> requests = cubit.sentFriendRequests;
          if (requests.isEmpty) {
            return const EmptyListWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              return SentRequestItem(request: requests[index]);
            },
          );
        },
      ),
    );
  }
}


