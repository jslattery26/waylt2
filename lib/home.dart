import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waylt3/extensions/context_extensions.dart';
import 'package:waylt3/slack/slack_repository.dart';
import 'package:waylt3/slack/slack_service.dart';
import 'package:waylt3/slack_login_button.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const clientId = '340624728833.3331468548978';
    const clientSecret = 'eaf91bf199f69dc825b74272c1f12506';
    final scope = ['users.profile:write', 'users.profile:read', 'team:read'];
    final vm = ref.watch(slackUserModelProvider.notifier);
    final state = ref.watch(slackUserModelProvider);
    final repo = ref.watch(slackRepositoryProvider);

    //!temp
    // if (state.accessToken.isNotEmpty) vm.setAccessToken('');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.accessToken.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: state.image,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      state.name,
                      style: context.textTheme.displaySmall,
                    ),
                  ),
                ],
              )
            else
              Center(
                child: SlackLoginButton(
                  clientId,
                  clientSecret,
                  scope,
                  (token) async {
                    if (token != null) {
                      vm.setAccessToken(token.accessToken);
                    }
                  },
                  redirectUrl: 'https://google.com',
                ),
              ),
            ElevatedButton(onPressed: vm.resetAll, child: const Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
