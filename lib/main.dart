import 'package:flutter/material.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/data/provider/api.dart';

void main() {
  runApp(TAPTAP());
}

class TAPTAP extends StatelessWidget {
  TAPTAP({Key? key}) : super(key: key);

  ApiProvider api = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("SSS"),
            const Text(
              "사용자 확인!",
              style: AppTextTheme.REGULAR,
            ),
            ElevatedButton(
                onPressed: api.authorizeToken, child: const Text("API 테스트")),
          ],
        ),
      ),
    );
  }
}
