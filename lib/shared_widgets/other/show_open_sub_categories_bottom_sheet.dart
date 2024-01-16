import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/media_query_values.dart';
import '../../features/category_products/presentation/blocs/cubit/category_products_cubit.dart';
import 'package:size_helper/size_helper.dart';

import '../../core/data/models/home_categ_model.dart';
import '../../core/utils/navigator_helper.dart';
import '../../di/injector.dart';
import '../../features/category_products/presentation/pages/category_products_page.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import '../stateless/custom_cached_network_image.dart';
import '../stateless/custom_loading.dart';
import '../stateless/empty_page_message.dart';
import '../stateless/title_text.dart';

void showOpenSubCategoriesBottomSheet(
  BuildContext context, {
  required int categoryId,
  required String categoryName,
}) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: AppColors.BARRIER_COLOR,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SubCategoriesBottomSheet(
            categoryId,
            categoryName,
          );
        });

class SubCategoriesBottomSheet extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  const SubCategoriesBottomSheet(this.categoryId, this.categoryName,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var size = context.sizeHelper(
      tabletNormal: context.width * 0.40,
      tabletLarge: context.width * 0.40,
      desktopSmall: context.width * 0.48,
      mobileLarge: context.width * 0.40,
    );

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsets.only(top: context.height * 0.25),
      child: BlocProvider(
        create: (_) =>
            Injector().categoryProductsCubit..getSubCategoriesData(categoryId),
        child: Column(
          children: [
            _buildCloseButton(context),
            _buildNameAndViewAllButton(context),
            const SizedBox(height: 8.0),
            BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
              builder: (context, state) {
                if (state.isInitial || state.isLoading)
                  return const Expanded(
                    child:
                        CustomLoading(loadingStyle: LoadingStyle.ShimmerList),
                  );
                if (state.subCategories?.data != null &&
                    state.subCategories!.data!.isNotEmpty) {
                  List<CategoryModel> subCatList = state.subCategories!.data!;
                  return Expanded(
                    child: GridView.builder(
                        itemCount: subCatList.length,
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: context.sizeHelper(
                            tabletNormal: 0.65,
                            tabletLarge: 0.70,
                            desktopSmall: 0.85,
                            mobileLarge: 0.70,
                          ),
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          CategoryModel subCat = subCatList[i];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              _goToProductsPage(
                                  context, subCat.id!, subCat.name!);
                            },
                            child: Column(
                              children: [
                                CustomCachedNetworkImage(
                                    imageMode: ImageMode.Pad,
                                    scaleMode: ScaleMode.Both,
                                    urlWidth: 400,
                                    urlHeight: 400,
                                    fit: BoxFit.cover,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    height: size,
                                    width: size + 20,
                                    imageUrl:
                                        subCat.pictureModel?.imageUrl ?? ''),
                                const SizedBox(height: 8.0),
                                TitleText.medium(text: subCat.name ?? '')
                              ],
                            ),
                          );
                        }),
                  );
                } else
                  return const EmptyPageMessage(
                    title: 'no_sub_categories_available',
                    heightRatio: 0.3,
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildNameAndViewAllButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: TitleText(text: categoryName, maxLines: 2),
          ),
        ),
        DefaultButton(
          label: "view_all_products".tr(),
          isExpanded: true,
          labelStyle: Theme.of(context).textTheme.displayLarge!,
          onPressed: () => _goToProductsPage(
            context,
            categoryId,
            categoryName,
          ),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  Padding _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset("lib/res/assets/close.svg"))
        ],
      ),
    );
  }

  void _goToProductsPage(
      BuildContext context, int categoryId, String categoryName) {
    NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
      return CategoryProductsPage(
        categoryName: categoryName,
        categoryId: categoryId,
      );
    }));
  }
}
