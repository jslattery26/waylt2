import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

final slackRepositoryProvider = Provider.autoDispose<SlackRepository>((ref) {
  return SlackRepository(ref);
});

// final fetchUserFutureProvider =
//     FutureProvider<Tuple2<String, String>?>((ref) async {
//   final repo = ref.read(slackRepositoryProvider);
//   return repo.fetchUserData();
// });

class SlackRepository {
  final Ref ref;

  SlackRepository(this.ref);

  Future<Tuple2<String, String>?> fetchUserData(String accessToken) async {
    final res = await http.get(
      Uri.https('slack.com', '/api/users.profile.get'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (res.statusCode != 200) {}
    final data = json.decode(res.body);
    final name = data['profile']['real_name'];
    final image = data['profile']['image_72'];
    return Tuple2(name, image);
  }

  Future<void> postStatus(String message, String accessToken) async {
    Map profile = {
      'status_text': message,
      'status_emoji': ':musical_note:',
      'status_expiration': 0,
    };
    final j = json.encode(profile);
    final urlEncoded = Uri.encodeComponent(j);
    await http.post(
      Uri.https(
        'slack.com',
        '/api/users.profile.set?profile=$urlEncoded&pretty=1',
      ),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }
}
