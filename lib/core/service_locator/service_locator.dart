import 'package:chat/features/add_friend/domain/repos/add_friend_repo.dart';
import 'package:chat/features/add_friend/domain/usecases/find_user_use_case.dart';
import 'package:chat/features/add_friend/domain/usecases/send_friend_request_use_case.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_cubit.dart';
import 'package:chat/features/auth/domain/repos/auth_repo.dart';
import 'package:chat/features/friends_list/domain/repos/friends_list_repo.dart';
import 'package:chat/features/friends_list/domain/usecases/block_friend_use_case.dart';
import 'package:chat/features/friends_list/domain/usecases/delete_friend_use_cas.dart';
import 'package:chat/features/friends_list/domain/usecases/get_all_friends_use_case.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_cubit.dart';
import 'package:chat/features/profile/domain/repos/profile_repo.dart';
import 'package:chat/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/add_friend/data/repos/add_friend_repo_imp.dart';
import '../../features/auth/data/repos/user_repo_imp.dart';
import '../../features/auth/domain/usecases/reset_password_use_case.dart';
import '../../features/auth/domain/usecases/send_reset_password_code_use_case.dart';
import '../../features/auth/domain/usecases/sign_in_use_case.dart';
import '../../features/auth/domain/usecases/sign_up_use_case.dart';
import '../../features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import '../../features/friends_list/data/repos/friends_list_repo_imp.dart';
import '../../features/layout/presentation/manager/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../../features/profile/data/repos/profile_repo_imp.dart';
import '../api/api_services.dart';
import '../scocket_io_services/socket_services.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {

    ///API SERVICE
    serviceLocator.registerLazySingleton<ApiServices>(
          () => ApiServices(),
    );


    /// SOCKET IO
    serviceLocator.registerLazySingleton<SocketService>(
          () => SocketService(),
    );

    /// REPOS
    serviceLocator.registerLazySingleton<AuthRepo>(
          () => AuthRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ProfileRepo>(
          () => ProfileRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddFriendRepo>(
          () => AddFriendRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<FriendsListRepo>(
          () => FriendsListRepoImp(serviceLocator()),
    );


    /// USE CASES
    serviceLocator.registerLazySingleton<SignInUseCase>(
          ()=> SignInUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SignUpUseCase>(
          ()=> SignUpUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SendResetPasswordCodeUseCase>(
          ()=> SendResetPasswordCodeUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ResetPasswordUseCase>(
          ()=> ResetPasswordUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetUserDataUseCase>(
          ()=> GetUserDataUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SendFriendRequestUseCase>(
          ()=> SendFriendRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<FindUserUseCase>(
          ()=> FindUserUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<BlockFriendUseCase>(
          ()=> BlockFriendUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<DeleteFriendUseCase>(
          ()=> DeleteFriendUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllFriendsUseCase>(
          ()=> GetAllFriendsUseCase(serviceLocator()),
    );


    /// CUBITS
    serviceLocator.registerFactory<AuthCubit>(
          ()=> AuthCubit(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<BottomNavigationBarCubit>(
          ()=> BottomNavigationBarCubit(),
    );
    serviceLocator.registerFactory<ProfileCubit>(
          ()=> ProfileCubit(serviceLocator()),
    );
    serviceLocator.registerFactory<AddFriendCubit>(
          ()=> AddFriendCubit(serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<FriendsListCubit>(
          ()=> FriendsListCubit(serviceLocator(),serviceLocator(),serviceLocator()),
    );
  }
}
