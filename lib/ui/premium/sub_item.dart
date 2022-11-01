import 'package:analysist/core/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/premium/premium_controller.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class SubItem extends StatelessWidget {
  Package package;
  Package? choosenPackage;
  SubItem({Key? key, required this.package, required this.choosenPackage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getWeeklyPrice() {
      if (package.packageType == PackageType.annual) {
        return package.product.currencyCode +
            " " +
            (package.product.price / 52).toStringAsFixed(2);
      }
      if (package.packageType == PackageType.monthly) {
        return package.product.currencyCode +
            " " +
            (package.product.price / 4).toStringAsFixed(2);
      } else {
        return (package.product.price).toStringAsFixed(2);
      }
    }

    String getDiscount() {
      Package weekly = Get.find<PremiumController>()
          .packages
          .where((element) => element.packageType == PackageType.weekly)
          .first;
      if (package.packageType == PackageType.monthly) {
        return "%" +
            ((((package.product.price / 4) - weekly.product.price) /
                        weekly.product.price) *
                    -100)
                .toStringAsFixed(0);
      } else if (package.packageType == PackageType.annual) {
        return "%" +
            ((((package.product.price / 52) - weekly.product.price) /
                        weekly.product.price) *
                    -100)
                .toStringAsFixed(0);
      } else {
        return '';
      }
    }

    double heigth = 70;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(2)),
        child: Stack(
          children: [
            Center(
              child: InkWell(
                  onTap: () {
                    Get.find<PremiumController>().choosePackage(package);
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.only(top: getHorizontalSize(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: getVerticalSize(10),
                              vertical: getVerticalSize(5)),
                          decoration: BoxDecoration(
                              gradient: choosenPackage != null &&
                                      choosenPackage == package
                                  ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          Color(0xff4d83d7),
                                          Color(0xff973abf)
                                        ])
                                  : null,
                              border: choosenPackage != null &&
                                      choosenPackage == package
                                  ? null
                                  : Border.all(
                                      color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.secondary),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: double.infinity,
                                height: getVerticalSize(100),
                                margin: EdgeInsets.only(
                                  top: getHorizontalSize(0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: getVerticalSize(5),
                                    vertical: getVerticalSize(5)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorManager.secondary),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      package.packageType == PackageType.annual
                                          ? '1 ' +
                                              translate("year").toUpperCase()
                                          : package.packageType ==
                                                  PackageType.weekly
                                              ? '1 ' +
                                                  translate("week")
                                                      .toUpperCase()
                                              : '1 ' +
                                                  translate("month")
                                                      .toUpperCase(),
                                      maxLines: 1,
                                      style: getBoldStyle(
                                          color: ColorManager.primary,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(5),
                                    ),
                                    Text(
                                      package.product.priceString,
                                      style: getRegularStyle(
                                          color: ColorManager.primary,
                                          fontSize: 13),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(5),
                                    ),
                                    package.packageType == PackageType.weekly
                                        ? SizedBox(
                                            height: getVerticalSize(18),
                                          )
                                        : Text(
                                            getDiscount() +
                                                " " +
                                                translate("Discount"),
                                            style: getBoldStyle(
                                                color: Color(0xff4d83d7),
                                                fontSize: 13),
                                          ),
                                  ],
                                ),
                              ),
                              choosenPackage != null &&
                                      choosenPackage == package
                                  ? SizedBox(
                                      height: getVerticalSize(15),
                                    )
                                  : Divider(
                                      thickness: 1,
                                    ),
                              Text(
                                getWeeklyPrice(),
                                style: getBoldStyle(
                                    color: choosenPackage != null &&
                                            choosenPackage == package
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: getVerticalSize(3),
                              ),
                              Text(
                                translate("weekly").toUpperCase(),
                                style: getRegularStyle(
                                    color: choosenPackage != null &&
                                            choosenPackage == package
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                height: getVerticalSize(8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            choosenPackage != null &&
                    choosenPackage == package &&
                    choosenPackage!.packageType != PackageType.weekly
                ? Center(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(0 / 360),
                      child: Container(
                        width: 80,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff4d83d7), Color(0xff973abf)]),
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            package.packageType == PackageType.annual
                                ? 'BEST'
                                : "POPULAR",
                            style: getBoldStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
