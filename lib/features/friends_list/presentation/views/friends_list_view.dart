import 'package:chat/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/features/friends_list/data/models/friend_model/friend_model.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_cubit.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class FriendsListView extends StatelessWidget {
  const FriendsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: 'friends'.tr),
      body:
      BlocConsumer<FriendsListCubit, FriendsListStates>(
        listener: (context, state) {
          if (state is GetFriendsListErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is DeleteFriendErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is BlockFriendErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is GetFriendsListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          final friends = context.read<FriendsListCubit>().allFriends;

          if (friends.isEmpty) {
            return const Center(
              child: Text('No friends yet', style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return FriendCard(friend: friends[index]);
            },
          );
        },
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  final FriendModel friend;

  const FriendCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  friend.userProfileImage != null
                      ? CachedNetworkImageProvider(friend.userProfileImage!)
                      : null,
              child:
                  friend.userProfileImage == null
                      ? const Icon(Icons.person, size: 30)
                      : null,
            ),
            const SizedBox(width: 16),

            // Name
            Expanded(
              child: Text(
                friend.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Remove Friend Button
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Remove Friend'),
                            content: const Text(
                              'Are you sure you want to remove this friend?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<FriendsListCubit>().deleteFriend(
                                    friend.id!,
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  icon: const Icon(Icons.person_remove, color: Colors.red),
                  tooltip: 'Remove Friend',
                ),

                // Block Friend Button
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Block Friend'),
                            content: const Text(
                              'Are you sure you want to block this friend?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<FriendsListCubit>().blockFriend(
                                    friend.id!,
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Block',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  icon: const Icon(Icons.block, color: Colors.orange),
                  tooltip: 'Block Friend',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
