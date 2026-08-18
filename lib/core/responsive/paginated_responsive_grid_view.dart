import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';

typedef LoadNextPage = Future<void> Function();

/// A lazy responsive grid that requests another page near the scroll boundary.
///
/// This widget owns presentation concerns only. A feature's BLoC
/// remains responsible for API requests, page numbers, deduplication, failures,
/// and updating [itemCount], [hasMore], and [isLoadingMore].
class PaginatedResponsiveGridView extends StatefulWidget {
  const PaginatedResponsiveGridView({
    required this.itemCount,
    required this.itemBuilder,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.minimumItemWidth = 280,
    this.maximumColumns = 3,
    this.spacing = 16,
    this.runSpacing,
    this.loadMoreTriggerExtent = 400,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.physics,
    this.sliversBefore = const <Widget>[],
    this.emptyState,
    this.loadingIndicator,
    this.loadMoreError,
    this.endOfListIndicator,
    super.key,
  }) : assert(itemCount >= 0),
       assert(minimumItemWidth > 0),
       assert(maximumColumns > 0),
       assert(spacing >= 0),
       assert(loadMoreTriggerExtent >= 0);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool hasMore;
  final bool isLoadingMore;
  final LoadNextPage onLoadMore;
  final double minimumItemWidth;
  final int maximumColumns;
  final double spacing;
  final double? runSpacing;
  final double loadMoreTriggerExtent;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  /// Optional slivers rendered before the grid, such as a page introduction.
  final List<Widget> sliversBefore;

  /// Shown when there are no items and another page is not being loaded.
  final Widget? emptyState;

  /// Defaults to a centered circular progress indicator.
  final Widget? loadingIndicator;

  /// A feature-owned error/retry widget. When present, automatic retry pauses.
  final Widget? loadMoreError;

  /// Optional footer shown after the final page.
  final Widget? endOfListIndicator;

  @override
  State<PaginatedResponsiveGridView> createState() =>
      _PaginatedResponsiveGridViewState();
}

class _PaginatedResponsiveGridViewState
    extends State<PaginatedResponsiveGridView> {
  late ScrollController _scrollController;
  late bool _ownsScrollController;
  bool _requestInFlight = false;

  bool get _isLoading => widget.isLoadingMore || _requestInFlight;

  @override
  void initState() {
    super.initState();
    _attachScrollController(widget.controller);
    _scheduleLoadCheck();
  }

  @override
  void didUpdateWidget(PaginatedResponsiveGridView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      _detachScrollController();
      _attachScrollController(widget.controller);
    }

    if (oldWidget.itemCount != widget.itemCount ||
        oldWidget.hasMore != widget.hasMore ||
        oldWidget.isLoadingMore != widget.isLoadingMore ||
        oldWidget.loadMoreError != widget.loadMoreError) {
      _scheduleLoadCheck();
    }
  }

  @override
  void dispose() {
    _detachScrollController();
    super.dispose();
  }

  void _attachScrollController(ScrollController? controller) {
    _ownsScrollController = controller == null;
    _scrollController = controller ?? ScrollController();
    _scrollController.addListener(_checkLoadMore);
  }

  void _detachScrollController() {
    _scrollController.removeListener(_checkLoadMore);
    if (_ownsScrollController) {
      _scrollController.dispose();
    }
  }

  void _scheduleLoadCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkLoadMore();
      }
    });
  }

  void _checkLoadMore() {
    if (!_scrollController.hasClients ||
        !_scrollController.position.hasContentDimensions ||
        widget.itemCount == 0 ||
        !widget.hasMore ||
        _isLoading ||
        widget.loadMoreError != null ||
        _scrollController.position.extentAfter > widget.loadMoreTriggerExtent) {
      return;
    }

    _requestNextPage();
  }

  Future<void> _requestNextPage() async {
    if (_requestInFlight) {
      return;
    }

    final previousItemCount = widget.itemCount;
    setState(() => _requestInFlight = true);

    try {
      await widget.onLoadMore();
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'responsive pagination',
          context: ErrorDescription('while requesting the next page'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _requestInFlight = false);
        if (widget.itemCount > previousItemCount) {
          _scheduleLoadCheck();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showEmptyState =
        widget.itemCount == 0 && !_isLoading && widget.loadMoreError == null;
    final loadMoreError = widget.loadMoreError;
    final endOfListIndicator = widget.endOfListIndicator;

    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: <Widget>[
        ...widget.sliversBefore,
        if (showEmptyState)
          SliverFillRemaining(
            hasScrollBody: false,
            child: widget.emptyState ?? const SizedBox.shrink(),
          )
        else if (widget.itemCount > 0)
          SliverPadding(
            padding: widget.padding,
            sliver: ResponsiveSliverGrid(
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder,
              minimumItemWidth: widget.minimumItemWidth,
              maximumColumns: widget.maximumColumns,
              spacing: widget.spacing,
              runSpacing: widget.runSpacing,
            ),
          ),
        if (_isLoading)
          SliverToBoxAdapter(
            child:
                widget.loadingIndicator ??
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: AppLoadingView(),
                ),
          )
        else if (loadMoreError != null)
          SliverToBoxAdapter(child: loadMoreError)
        else if (!widget.hasMore &&
            widget.itemCount > 0 &&
            endOfListIndicator != null)
          SliverToBoxAdapter(child: endOfListIndicator),
      ],
    );
  }
}
