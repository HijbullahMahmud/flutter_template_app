import 'package:ag_pos/core/responsive/paginated_responsive_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('builds items lazily and adapts to three columns', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(1024, 768));

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 100,
          hasMore: false,
          isLoadingMore: false,
          onLoadMore: _noOp,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 100,
              child: Text('Item $index', key: ValueKey<int>(index)),
            );
          },
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 99'), findsNothing);
    expect(
      tester.getTopLeft(find.text('Item 0')).dy,
      tester.getTopLeft(find.text('Item 1')).dy,
    );
    expect(
      tester.getTopLeft(find.text('Item 1')).dy,
      tester.getTopLeft(find.text('Item 2')).dy,
    );
    expect(
      tester.getTopLeft(find.text('Item 3')).dy,
      greaterThan(tester.getTopLeft(find.text('Item 0')).dy),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('requests the next page near the scroll boundary', (
    WidgetTester tester,
  ) async {
    var loadMoreCalls = 0;

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 20,
          hasMore: true,
          isLoadingMore: false,
          onLoadMore: () async {
            loadMoreCalls++;
          },
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(height: 120, child: Text('Item $index'));
          },
        ),
      ),
    );
    await tester.pump();

    expect(loadMoreCalls, 0);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -700));
    await tester.pump();

    expect(loadMoreCalls, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('equalizes item heights within each responsive row', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(1024, 768));
    const heights = <double>[80, 140, 100, 60];

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: heights.length,
          hasMore: false,
          isLoadingMore: false,
          onLoadMore: _noOp,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              key: ValueKey<String>('item-$index'),
              height: heights[index],
              child: Text('Item $index'),
            );
          },
        ),
      ),
    );
    await tester.pump();

    final firstHeight = tester.getSize(find.byKey(const ValueKey('item-0')));
    final secondHeight = tester.getSize(find.byKey(const ValueKey('item-1')));
    final thirdHeight = tester.getSize(find.byKey(const ValueKey('item-2')));
    final nextRowHeight = tester.getSize(find.byKey(const ValueKey('item-3')));

    expect(firstHeight.height, 140);
    expect(secondHeight.height, firstHeight.height);
    expect(thirdHeight.height, firstHeight.height);
    expect(nextRowHeight.height, 60);
    expect(tester.takeException(), isNull);
  });

  testWidgets('loads another page when content does not fill the viewport', (
    WidgetTester tester,
  ) async {
    var loadMoreCalls = 0;

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 2,
          hasMore: true,
          isLoadingMore: false,
          onLoadMore: () async {
            loadMoreCalls++;
          },
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(height: 80, child: Text('Item $index'));
          },
        ),
      ),
    );
    await tester.pump();

    expect(loadMoreCalls, 1);
  });

  testWidgets('shows a pagination error and pauses automatic retry', (
    WidgetTester tester,
  ) async {
    var loadMoreCalls = 0;

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 2,
          hasMore: true,
          isLoadingMore: false,
          loadMoreError: const Text('Could not load more'),
          onLoadMore: () async {
            loadMoreCalls++;
          },
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(height: 80, child: Text('Item $index'));
          },
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Could not load more'), findsOneWidget);
    expect(loadMoreCalls, 0);
  });

  testWidgets('shows empty, loading, and end-of-list states', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 0,
          hasMore: false,
          isLoadingMore: false,
          emptyState: const Text('No items'),
          onLoadMore: _noOp,
          itemBuilder: _emptyItemBuilder,
        ),
      ),
    );
    await tester.pump();
    expect(find.text('No items'), findsOneWidget);

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 1,
          hasMore: true,
          isLoadingMore: true,
          onLoadMore: _noOp,
          itemBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 80, child: Text('Item'));
          },
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      _testApp(
        PaginatedResponsiveGridView(
          itemCount: 1,
          hasMore: false,
          isLoadingMore: false,
          endOfListIndicator: const Text('End'),
          onLoadMore: _noOp,
          itemBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 80, child: Text('Item'));
          },
        ),
      ),
    );
    await tester.pump();
    expect(find.text('End'), findsOneWidget);
  });
}

Future<void> _noOp() async {}

Widget _emptyItemBuilder(BuildContext context, int index) {
  return const SizedBox.shrink();
}

Widget _testApp(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void _configureView(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;

  addTearDown(() {
    tester.view.resetDevicePixelRatio();
    tester.view.resetPhysicalSize();
  });
}
