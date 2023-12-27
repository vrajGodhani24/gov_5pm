import 'dart:io';

import 'package:adv_5_government_app/modules/view/hompage/model/all_gov_service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late InAppWebViewController inAppWebViewController;
  PullToRefreshController pullToRefreshController = PullToRefreshController();

  @override
  Widget build(BuildContext context) {
    GovServiceData govServiceData =
        ModalRoute.of(context)!.settings.arguments as GovServiceData;

    return Scaffold(
      appBar: AppBar(
        title: Text(govServiceData.name),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () async {
                if (await inAppWebViewController.canGoBack()) {
                  await inAppWebViewController.goBack();
                }
              },
              child: const Icon(Icons.arrow_back),
            ),
            FloatingActionButton(
              onPressed: () async {
                if (await inAppWebViewController.canGoForward()) {
                  await inAppWebViewController.goForward();
                }
              },
              child: const Icon(Icons.arrow_forward),
            ),
            FloatingActionButton(
              onPressed: () async {
                await inAppWebViewController.reload();
              },
              child: const Icon(Icons.refresh),
            ),
            FloatingActionButton(
              onPressed: () async {
                await inAppWebViewController.loadUrl(
                  urlRequest: URLRequest(
                    url: WebUri(govServiceData.link),
                  ),
                );
              },
              child: const Icon(Icons.home),
            ),
          ],
        ),
      ),
      body: InAppWebView(
        pullToRefreshController: pullToRefreshController,
        initialUrlRequest: URLRequest(
          url: WebUri(govServiceData.link),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          setState(() {
            inAppWebViewController = controller;
          });
        },
        onLoadStop: (controller, uri) async {
          await pullToRefreshController.endRefreshing();
        },
      ),
    );
  }
}
