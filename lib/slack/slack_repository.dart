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
    final image = data['profile']['image_192'];
    return Tuple2(name, image);
  }
}
