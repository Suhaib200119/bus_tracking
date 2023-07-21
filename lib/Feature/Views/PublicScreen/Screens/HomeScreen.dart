import 'dart:convert';

import 'package:bus_tracing/Network/dioHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Core/ColorsManager.dart';
import '../../../GlobalWidgets/CardData_C.dart';
import '../../../Providers/GlobalProvider.dart';

class HomeScreen extends StatelessWidget {
  PageController _pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    var globalProvider = Provider.of<GlobalProvider>(context);
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                margin: EdgeInsets.all(8),
                height: 350,
                color: ColorsManager.grayColor,
                child: FutureBuilder(
                  future: DioHelper.getMethod(
                      apiName: "Home/GetActiveLine", headers: {}),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic snapshotData =
                          jsonDecode(snapshot.data.toString());
                      if (snapshotData["status"]) {
                        List<dynamic> data = snapshotData["data"];
                        return PageView.builder(
                          allowImplicitScrolling: true,
                          controller: _pageController,
                          padEnds: false,
                          itemCount: data.length,
                          onPageChanged: (index) {
                            globalProvider.changeCurrentPageViewIndex(index);
                          },
                          itemBuilder: (context, index) {
                            return CardData_C(
                                busName: data[index]["bus"]["name"],
                                busNumber: data[index]["bus"]["number"],
                                busCompany: data[index]["bus"]["company"]
                                    ["name"],
                                busImage: "Assets/images/bus.png",
                                index: index);
                          },
                        );
                      } else {
                        return Text("NO Buses");
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: ColorsManager.primaryColor,
                          size: 50,
                        ),
                      );
                    } else {
                      return Text("SOME ERROR!");
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: globalProvider.countSmoothPageIndicator,
              effect: ScrollingDotsEffect(
                activeStrokeWidth: 2.5,
                activeDotScale: 1.2,
                maxVisibleDots: 5,
                spacing: 4,
                radius: 8,
                dotHeight: 8,
                dotWidth: 8,
                dotColor: ColorsManager.primaryColor,
                activeDotColor: ColorsManager.orangeColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      globalProvider.changeBottomNavigationBar(0);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Assets/images/markerButton.jpg",
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      globalProvider.changeBottomNavigationBar(2);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "Assets/images/map.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
