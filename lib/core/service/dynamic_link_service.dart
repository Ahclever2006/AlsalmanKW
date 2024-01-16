import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../features/product_details/presentation/pages/product_details_page.dart';
import '../../main.dart';

abstract class DynamicLinkService {
  Future<void> initDynamicLink(bool isLoggedIn);
  Future<String> createProductLink({
    required int id,
    required String name,
    required String seName,
    required String description,
    String? imageUrl,
  });
}

class DynamicLinkServiceImpl implements DynamicLinkService {
  @override
  Future<void> initDynamicLink(bool isLoggedIn) async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data, true, isLoggedIn);

    FirebaseDynamicLinks.instance.onLink.listen(
      (data) => _handleDeepLink(data, false, isLoggedIn),
      onError: (_) => log('Error dynamic links'),
    );
  }

  Future<void> _handleDeepLink(
    PendingDynamicLinkData? data, [
    bool isInit = false,
    bool isLoggedIn = false,
  ]) async {
    final deepLink = data?.link;
    if (deepLink == null) return;

    if (isInit) await Future.delayed(const Duration(seconds: 1));

    final nextPage = _selectNextPage(deepLink.pathSegments);

    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  Widget _selectNextPage(List<String> pathSegments) {
    String lastSeg = pathSegments.last;
    if (pathSegments.contains('Product')) {
      return ProductDetailsPage(
        productId: int.parse(lastSeg),
      );
    } else
      throw Exception('Unknown deep link');
  }

  @override
  Future<String> createProductLink({
    required int id,
    required String name,
    required String seName,
    required String description,
    String? imageUrl,
  }) async {
    final picture = imageUrl;
    final url = Uri.parse('https://square-upgrade.k-pack.online/Product/$id');
    final fallbackUrl =
        Uri.parse('https://square-upgrade.k-pack.online/$seName');
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://alsalmankw.page.link',
      link: url,
      androidParameters: AndroidParameters(
        fallbackUrl: fallbackUrl,
        packageName: 'com.baramjk.alsalman',
      ),
      iosParameters: IOSParameters(
        fallbackUrl: fallbackUrl,
        appStoreId: '6448727597',
        bundleId: 'com.baramjk.alsalman',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: name,
        // description: description,
        imageUrl: picture == null ? null : Uri.parse(picture),
      ),
    );
    final dynamicLinks = FirebaseDynamicLinks.instance;
    final dynamicUri = await dynamicLinks.buildLink(parameters);
    log(dynamicUri.toString());
    return dynamicUri.toString();
  }
}
