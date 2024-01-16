
import '../../../core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/style/app_colors.dart';

enum LoadingStyle {
  Default,
  Home,
  ShimmerList,
  ShimmerGrid,
  Pagination,
  None,
}

class CustomPaymentLoading extends StatelessWidget {
  const CustomPaymentLoading({
    Key? key,
    LoadingStyle loadingStyle = LoadingStyle.Default,
    bool useColumn = false,
    Color? color,
  })  : _loadingStyle = loadingStyle,
        _useColumn = useColumn,
        _color = color,
        super(key: key);

  final LoadingStyle _loadingStyle;
  final bool _useColumn;
  final Color? _color;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    switch (_loadingStyle) {
      case LoadingStyle.Default:
        child = _buildDefaultLoading();
        break;
      case LoadingStyle.ShimmerList:
        child = _buildShimmerListLoading();
        break;
      case LoadingStyle.ShimmerGrid:
        child = _buildShimmerGridLoading();
        break;
      case LoadingStyle.Pagination:
        child = _buildPaginationLoading();
        break;
      case LoadingStyle.Home:
        child = _buildHomeLoading(context);
        break;
      case LoadingStyle.None:
        child = const SizedBox();
        break;
      default:
        throw Exception('Unknown loading style');
    }
    return Padding(
      padding: _loadingStyle == LoadingStyle.Pagination
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(16.0),
      child: child,
    );
  }

  Widget _buildDefaultLoading() =>
      Center(child: CircularProgressIndicator(color: _color));

  Widget _buildPaginationLoading() => const Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 12.5,
          height: 12.5,
          child: FittedBox(child: CircularProgressIndicator()),
        ),
      );

  Widget _buildShimmerListLoading() => Shimmer.fromColors(
        baseColor: AppColors.PRIMARY_COLOR_LIGHT,
        highlightColor: AppColors.GREY_LIGHT_COLOR,
        enabled: true,
        child: _useColumn
            ? Column(
                children:
                    List.generate(15, (index) => const _ListItemShimmer()),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, __) => const _ListItemShimmer(),
                itemCount: 15,
              ),
      );

  Widget _buildShimmerGridLoading() => Shimmer.fromColors(
        baseColor: AppColors.PRIMARY_COLOR_LIGHT,
        highlightColor: AppColors.GREY_LIGHT_COLOR,
        enabled: true,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              ],
            ),
          ),
          itemCount: 9,
        ),
      );

  Widget? _buildHomeLoading(BuildContext context) => Shimmer.fromColors(
        baseColor: AppColors.PRIMARY_COLOR_LIGHT,
        highlightColor: AppColors.GREY_LIGHT_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 48.0),
                height: 16.0,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: List.generate(
                    6,
                    (index) => Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white,
                          ),
                        )),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: context.width,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              ...List.generate(
                  3,
                  (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8.0,
                            width: 100.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                              Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      )).toList()
            ],
          ),
        ),
      );
}

class _ListItemShimmer extends StatelessWidget {
  const _ListItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: context.width,
            height: 160.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
