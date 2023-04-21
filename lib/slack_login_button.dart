import 'package:flutter/material.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Access token callback tpye
typedef TokenCallback = void Function(Token? token);

/// Slack sign in button
class SlackLoginButton extends StatefulWidget {
  final String _clientId;
  final String _clientSecret;
  final List<String> _scope;
  final String? _redirectUrl;
  final String? _state;
  final String? _team;
  final TokenCallback _onFinished;
  final VoidCallback? _onCancelled;

  const SlackLoginButton(
    this._clientId,
    this._clientSecret,
    this._scope,
    this._onFinished, {
    super.key,
    String? redirectUrl,
    String? state,
    String? team,
    VoidCallback? onCancelled,
  })  : _redirectUrl = redirectUrl,
        _state = state,
        _team = team,
        _onCancelled = onCancelled;

  @override
  State<SlackLoginButton> createState() => _SlackLoginButtonState();
}

class _SlackLoginButtonState extends State<SlackLoginButton> {
  late FlutterMacOSWebView webview;

  init() {
    webview = FlutterMacOSWebView(
      onPageStarted: (changedUrl) async {},
      onPageFinished: (changedUrl) async {
        if (changedUrl == null) return;
        if (changedUrl.contains('slack.com')) return;
        Token? token;
        if (changedUrl.contains('https://www.google.com') ||
            changedUrl.contains('localhost')) {
          webview.close();
          final uri = Uri().resolve(changedUrl);
          final code = uri.queryParameters['code'];
          final state = uri.queryParameters['state'];
          if (code == null ||
              (widget._state != null && widget._state != state)) {
          } else {
            final body = {
              'client_id': widget._clientId,
              'client_secret': widget._clientSecret,
              'code': code,
            };
            if (widget._redirectUrl != null) {
              body['redirect_ur i'] = widget._redirectUrl!;
            }
            final response = await http.post(
              Uri.https('slack.com', '/api/oauth.access'),
              body: body,
            );
            token = Token.from(json.decode(response.body));
          }
        }
        widget._onFinished(token);
        // Navigator.of(context).pop(true);
      },
    );
  }

  onOpenPressed(String url, BuildContext context) async {
    await webview.open(
      url: url,
      presentationStyle: PresentationStyle.modal,
      size: const Size(400.0, 400.0),
      userAgent:
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
    );
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                4,
              ),
            ),
            border: Border.all(
              width: 1,
              color: Colors.white54,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/slack_logo.png',
                  width: 44,
                  height: 44,
                ),
                const Text('Sign in with '),
                const Text(
                  'Slack',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Call if tap slack sign in button
  onTap(BuildContext context) async {
    final params = {
      'client_id': widget._clientId,
      'scope': widget._scope.join(','),
    };
    if (widget._redirectUrl != null) {
      params['redirect_uri'] = widget._redirectUrl!;
    }
    if (widget._state != null) {
      params['state'] = widget._state!;
    }
    if (widget._team != null) {
      params['team'] = widget._team!;
    }
    final url = Uri.https('slack.com', '/oauth/authorize', params).toString();
    onOpenPressed(url, context);
  }
}

/// Struct for access token
class Token {
  final String accessToken;
  Token.from(Map json) : accessToken = json['access_token'];
}
