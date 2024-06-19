import 'Tjans.dart';

abstract class HttpHandler {
  Future<List<Tjans>> hurtigTjanseInfo(String email);

  /*
  TODO
   */
  Future<void> updateTjansWithLangBeskrivelse(String email);



}