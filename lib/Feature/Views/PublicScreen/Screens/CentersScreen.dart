import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../Core/ColorsManager.dart';
import '../../../../Network/dioHelper.dart';
import '../../../GlobalWidgets/CardData_C.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: DioHelper.getMethod(
              apiName: "StopPoint/GetAll", headers: {}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic snapshotData = jsonDecode(snapshot.data.toString());
              if (snapshotData["status"]) {
                List<dynamic> data = snapshotData["data"];
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: ColorsManager.primaryColor,
                      ),
                    );
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.2,
                              decoration: BoxDecoration(
                                color: ColorsManager.primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.5,
                                              child: Text(
                                                "${data[index]["name"]} position",
                                                softWrap: true,
                                                maxLines: 2,
                                                style: GoogleFonts.cairo(
                                                    fontSize:
                                                    24,
                                                    fontWeight: FontWeight
                                                        .w700,
                                                    color: ColorsManager.whiteColor),
                                              ),
                                            ),

                                            Text(
                                              "${data[index]["address"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.cairo(
                                                  fontSize:
                                                  16,
                                                  fontWeight: FontWeight
                                                      .w700,
                                                  color: ColorsManager.whiteColor),
                                            ),
                                          ],
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(5),
                                              backgroundColor:
                                              ColorsManager.grayColor_2),
                                          child: Icon(
                                            Icons.close,
                                            color: ColorsManager.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: ColorsManager.whiteColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40)),
                                      ),
                                      child: Expanded(
                                        child: FutureBuilder(
                                          future: DioHelper.getMethod(
                                              apiName:
                                              "StopPoint/Get/${data[index]["id"]}",
                                              headers: {}),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              dynamic snapshotData =
                                              jsonDecode(snapshot.data
                                                  .toString());
                                              if (snapshotData["status"]) {
                                                List<dynamic> data =
                                                snapshotData["data"]
                                                ["lineSP"];
                                                if (data.isNotEmpty) {
                                                  return ListView.builder(
                                                    itemCount: data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Color color = data[
                                                      index]
                                                      [
                                                      "isAccess"] ==
                                                          true
                                                          ? ColorsManager
                                                          .grayColor_2
                                                          : ColorsManager
                                                          .primaryColor;
                                                      Color colorAvatar = data[
                                                      index]
                                                      [
                                                      "isAccess"] ==
                                                          true
                                                          ? ColorsManager
                                                          .grayColor_2
                                                          : ColorsManager
                                                          .orangeColor;

                                                      Color colorTrue = data[
                                                      index]
                                                      [
                                                      "isAccess"] ==
                                                          true
                                                          ? ColorsManager
                                                          .grayColor_2
                                                          : Colors.green;

                                                      return Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            4),
                                                        height: 100,
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                              colorAvatar,
                                                              child: Icon(
                                                                Icons
                                                                    .directions_bus,
                                                                color: ColorsManager
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  "${data[index]["stopPointName"]}",
                                                                  style: GoogleFonts.cairo(
                                                                      fontSize:
                                                                      18,
                                                                      fontWeight: FontWeight
                                                                          .w700,
                                                                      color:
                                                                      color),
                                                                ),
                                                                Text(
                                                                  "${data[index]["timeAccess"]}",
                                                                  style: GoogleFonts.cairo(
                                                                      fontSize:
                                                                      20,
                                                                      fontWeight: FontWeight
                                                                          .w700,
                                                                      color:
                                                                      color),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 20),
                                                              child: Icon(Icons.check,size: 22,color: colorTrue),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                else {
                                                  return const Center(
                                                      child:
                                                      Text("No Data - Empty"));
                                                }
                                              } else {
                                                return const Center(child: Text("Status - false"));
                                              }
                                            } else if (snapshot
                                                .connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                LoadingAnimationWidget
                                                    .staggeredDotsWave(
                                                  color: ColorsManager
                                                      .primaryColor,
                                                  size: 50,
                                                ),
                                              );
                                            } else {
                                              return Text("Somw ERRPR");
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.grayColor,
                        ),
                        child: Row(
                          children: [
                            Image.asset("Assets/images/markerButton.jpg",width: 100,height: 100,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: Text(
                                    "${data[index]["name"]}",
                                    softWrap: true,
                                    maxLines: 3,
                                    style: GoogleFonts.cairo(
                                      color: ColorsManager.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),

                                  ),
                                ),
                                Text(
                                  "${data[index]["address"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cairo(
                                    color: ColorsManager.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text("NO Buses");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorsManager.primaryColor,
                  size: 50,
                ),
              );
            } else {
              return const Text("SOME ERROR!");
            }
          },
        ),
      ),
    );
  }
}
