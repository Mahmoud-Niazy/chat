import 'package:chat/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/user_repo_imp.dart';
import '../../features/auth/domain/use_cases/reset_password_use_case.dart';
import '../../features/auth/domain/use_cases/send_reset_password_code_use_case.dart';
import '../../features/auth/domain/use_cases/sign_in_use_case.dart';
import '../../features/auth/domain/use_cases/sign_up_use_case.dart';
import '../../features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
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


    /// CUBITS
    serviceLocator.registerFactory<AuthCubit>(
          ()=> AuthCubit(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()),
    );


  }
}
