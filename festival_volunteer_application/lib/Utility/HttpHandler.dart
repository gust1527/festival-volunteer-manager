abstract class HttpHandler {
  /*
  0: Tjansenavn (toiletter...)
  1: Tidspunkt som streng ("18:30")
  2: Placering
   */
  Future<List<String>> get hurtigTjanseInfo;

  /*
  TODO
   */
  Future<dynamic> get langTjanseInfo;



}