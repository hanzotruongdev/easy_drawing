import 'package:ar_drawing/components/popup.dart';
import 'package:ar_drawing/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatScreen extends StatefulWidget {
  final String name;
  const CatScreen({super.key, required this.name});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262F38),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.symmetric(horizontal: 67.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff384152),
              Colors.black,
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImagePath.btnBack,
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 96.sp,
                    ),
                  ),
                  SizedBox(width: 120.w),
                ],
              ),
            ),
            SizedBox(height: 84.w),
            Expanded(child: _buildCat()),
          ],
        ),
      ),
    );
  }

  _buildCat() {
    final listItem = appSamplePath[widget.name];
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          crossAxisSpacing: 10.w,
          childAspectRatio: 555 / 615,
        ),
        itemCount: listItem!.length,
        itemBuilder: (c, i) => _buildCatItem(listItem[i]));
  }

  _buildCatItem(DrawAsset da) {
    return InkWell(
      onTap: () => AppPopups.showPopupItemDetail(context, da),
      child: SizedBox(
        width: 555.w,
        height: 615.w,
        child: Stack(
          children: [
            // bg
            Positioned.fill(child: Image.asset(AppImagePath.bgCatItemLarge)),
            // image
            Positioned(
              top: 27.w,
              left: 40.w,
              child: Image.asset(
                da.path,
                height: 501.w,
                width: 501.w,
                fit: BoxFit.cover,
              ),
            ),
            //star
            Positioned(
              left: 0,
              right: 0,
              bottom: 30.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.filled(da.star, 1).map((e) {
                    return Image.asset(
                      AppImagePath.iconStarActive,
                      width: 48.w,
                      height: 48.w,
                    );
                  }).toList(),
                  ...List.filled(5 - da.star, 1).map((e) {
                    return Image.asset(
                      AppImagePath.iconStarInactive,
                      width: 48.w,
                      height: 48.w,
                    );
                  }).toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
