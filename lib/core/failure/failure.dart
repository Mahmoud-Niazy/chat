import 'package:dio/dio.dart';

class Failure {
  final String error;
  Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure(super.error);

  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('end timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
      // default:
      //   return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 422 || statusCode ==  500) {
      if(response['msg'] is List){
        return ServerFailure(response['msg']);
      }
      return ServerFailure(response['msg']);
    } else if (statusCode == 404) {
      return ServerFailure(response['msg']);
    }
    // else if (statusCode == 500) {
    //   return ServerFailure('Internal Server error, Please try later');
    // }
    else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }


}

class LocationServiceFailure extends Failure {
  LocationServiceFailure(super.error);
}

class FirebaseFailure extends Failure{
  FirebaseFailure(super.error);
}


