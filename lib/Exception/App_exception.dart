abstract class AppException implements Exception{
  final _message;
  AppException(this._message);
  String ToString(){
    return 'Error : $_message';
  }
}

class FetchDataException extends AppException{
  FetchDataException(super._message);
}

class InternalServerException extends AppException{
  InternalServerException(super._message);
}

class BadRequestException extends AppException{
  BadRequestException(super._message);
}

class GetwayTimeouteException extends AppException{
  GetwayTimeouteException(super._message);
}

class NotFoundException extends AppException{
  NotFoundException(super._message);
}