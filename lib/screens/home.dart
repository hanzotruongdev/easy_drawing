import 'package:ar_drawing/components/popup.dart';
import 'package:ar_drawing/config/assets_path.dart';
import 'package:ar_drawing/screens/cat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  SizedBox(width: 96.w),
                  SvgPicture.asset(AppSvgPath.logo, width: 823.w, height: 230.w),
                  GestureDetector(
                    onTap: () => AppPopups.showPopupHelp(context),
                    child: SvgPicture.asset(AppSvgPath.btnHelp, width: 96.w, height: 96.w),
                  ),
                ],
              ),
            ),
            Image.asset(AppImagePath.btnUpload, width: double.infinity),
            SizedBox(height: 96.w),
            Expanded(child: _buildListCat())
          ],
        ),
      ),
    );
  }

  _buildListCat() {
    final List<String> keys = appSamplePath.keys.toList();
    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (context, index) => _buildCat(keys[index]),
    );
  }

  _buildCat(name) {
    final listItem = appSamplePath[name];
    return Container(
      key: Key(name),
      width: 1146.w,
      height: 687.w,
      margin: EdgeInsets.only(bottom: 48.w),
      child: Stack(
        children: [
          // bg
          Positioned.fill(child: Image.asset(AppImagePath.bgCat)),
          Positioned(
            top: 40.w,
            left: 48.w,
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 72.sp),
            ),
          ),
          // list items
          Positioned(
            bottom: 48.w,
            left: 0,
            right: 0,
            height: 486.w,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              itemCount: listItem!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) {
                return _buildCatItem(listItem[i]);
              },
            ),
          ),
          // view button
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatScreen(name: name)),
                );
              },
              child: Container(
                width: 249.w,
                height: 99.w,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0),
                  borderRadius: BorderRadius.circular(49.w),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCatItem(DrawAsset da) {
    return InkWell(
      key: Key(da.name + da.path),
      onTap: () => AppPopups.showPopupItemDetail(context, da),
      child: SizedBox(
        width: 390.w,
        height: 474.w,
        child: Stack(
          children: [
            // bg
            Positioned.fill(child: Image.asset(AppImagePath.bgCatItem)),
            // image
            Positioned(
              top: 16.w,
              left: 16.w,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(48.w)),
                child: Image.asset(
                  da.path,
                  height: 360.w,
                  width: 360.w,
                ),
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
