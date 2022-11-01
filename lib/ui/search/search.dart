import 'package:analysist/widgets/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/search/SearchUser.dart';
import 'package:analysist/ui/search/seach_controller.dart';
import 'package:analysist/ui/search/search_user_card.dart';

import '../../core/styles_manager.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (controller) {
      controller.searchUser.sort((a, b) => a.position.compareTo(b.position));
      return Container(
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(0)),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Card(
              elevation: 1,
              shadowColor: Colors.grey.shade300,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 38,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: controller.textEditingController,
                    onChanged: controller.onChanged,
                    style: getRegularStyle(color: Colors.black, fontSize: 13),
                    decoration: InputDecoration(
                        border: getBorder(),
                        enabledBorder: getBorder(),
                        focusedBorder: getBorder(),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle:
                            getRegularStyle(color: Colors.grey, fontSize: 13),
                        hintText: "${translate("Search User")}...",
                        fillColor: Colors.grey.withOpacity(0.25)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: controller.textEditingController.text.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/search.png',
                          width: size.width / 1.4,
                        ),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.search_circle,
                                color: ColorManager.primary,
                                size: 20,
                              ),
                              SizedBox(
                                width: getHorizontalSize(8),
                              ),
                              Text(
                                translate(
                                  'Search Peoples',
                                ),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.download_circle,
                                size: 20,
                                color: ColorManager.primary,
                              ),
                              SizedBox(
                                width: getHorizontalSize(8),
                              ),
                              Text(
                                translate(
                                  'Download Big HD Profile Photos',
                                ),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.at_circle,
                                color: ColorManager.primary,
                                size: 20,
                              ),
                              SizedBox(
                                width: getHorizontalSize(8),
                              ),
                              Text(
                                translate(
                                  'Download Stories',
                                ),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translate(
                                  'and more of them...',
                                ),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : controller.searching
                      ? Container()
                      : controller.searchUser.isEmpty
                          ? Center(
                              child: LottiePage(
                                  width: double.infinity,
                                  heigth: double.infinity,
                                  lottie: 'no-data'),
                            )
                          : ListView.builder(
                              itemCount: controller.searchUser.length,
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(8)),
                              itemBuilder: (context, index) {
                                SearchUser searchUser =
                                    controller.searchUser[index];
                                return SearchUserCard(user: searchUser);
                              }),
            )
          ],
        ),
      );
    });
  }

  InputBorder getBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(40));
  }
}
