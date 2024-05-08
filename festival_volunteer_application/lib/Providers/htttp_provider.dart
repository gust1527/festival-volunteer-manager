import 'package:http/http.dart' as http;

class HttpProvider {
  final endPointURL = 'https://script.googleusercontent.com/macros/echo?user_content_key=hlVBqNPpPx0MxKkbW0PKtHTAQFn5bjMIumX-mxwmb0_05ypwYR1QnURaZTBHh85xW-0fTWLPrJVzgvkn4eD1yUYOipvXp06fOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuBLhyHCd5hHa3jF3GpAn-KMjIQlbzpkn6qJryGXdTK9HlUaqdRT-HbfDYtnDqJgusxI5Ca6vkriACD0xmLIiG-RxHKAqNPy2AeIJo0Uq0TMc24NmVzn9yUi8WZaV2WZtACs0sBFx6O4FtHCwfjZ054YHdd-IpljIb3A7BfHxl5ttA&lib=MrnXArr__SfnWuPc553NUZ09MHZpnmUmU';

  Future<http.Response> get(String email) async {
    try {
      final response = await http.get(Uri.parse('$endPointURL&email=$email'));
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }
}