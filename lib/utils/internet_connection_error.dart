import 'dart:io';

String checkInternetConnectionError(e) {
  if(e is SocketException) {
    return "Check your internet connection";
  }
  return e;
}