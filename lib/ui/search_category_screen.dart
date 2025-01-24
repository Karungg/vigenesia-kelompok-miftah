import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigenesia/constants/constants.dart';
import 'package:vigenesia/ui/search_screen.dart';
import 'package:vigenesia/widgets/bottom_player.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SearchCategoryScreen extends StatefulWidget {
  const SearchCategoryScreen({super.key});

  @override
  State<SearchCategoryScreen> createState() => _SearchCategoryScreenState();
}

class _SearchCategoryScreenState extends State<SearchCategoryScreen> {
  String? scanResault;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Search",
                            style: TextStyle(
                              fontFamily: "AB",
                              fontSize: 25,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _SearchBox(),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 17, bottom: 17),
                      child: Text(
                        "Search Motivation",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 130),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future barcodeScanner() async {
  //   String scanResault;

  //   try {
  //     scanResault = await FlutterBarcodeScanner.scanBarcode(
  //         "#ffFFFF", "Cancel", false, ScanMode.QR);
  //   } on PlatformException {
  //     scanResault = "Failed to get Platform version";
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     this.scanResault = scanResault;
  //   });
  // }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 46,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Image.asset("images/icon_search_black.png"),
                const SizedBox(width: 15),
                const Text(
                  "Search motivation",
                  style: TextStyle(
                    fontFamily: "AB",
                    color: MyColors.darGreyColor,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: (MediaQuery.of(context).size.width / 1.75) - 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/$image"),
              fit: BoxFit.cover,
            ),
            color: Colors.red,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "AB",
              fontSize: 16,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
