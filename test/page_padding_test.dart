import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/core/utils/page_padding.dart';

void main() {
  testWidgets('adds the system navigation bar height below the last item', (tester) async {
    late EdgeInsets padding;
    await tester.pumpWidget(
      MediaQuery(
        // A 3-button Android navigation bar, as on the reported phone.
        data: const MediaQueryData(padding: EdgeInsets.only(bottom: 48)),
        child: Builder(
          builder: (context) {
            padding = pagePadding(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(padding, const EdgeInsets.fromLTRB(16, 16, 16, 64));
  });

  testWidgets('is a plain gutter when there is no system bar', (tester) async {
    late EdgeInsets padding;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: Builder(
          builder: (context) {
            padding = pagePadding(context, all: 24);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(padding, const EdgeInsets.all(24));
  });
}
