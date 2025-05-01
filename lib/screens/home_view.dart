// ignore_for_file: unused_import, deprecated_member_use, unused_field, prefer_final_fields, non_constant_identifier_names, avoid_print, annotate_overrides

import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/models/design_part.dart';
import 'package:calculator/screens/add_design_view.dart';
import 'package:calculator/screens/home_common/design_part_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/colors.dart';
import '../helpers/common_widget.dart';
import '../helpers/images.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _stichRatecontroller = TextEditingController(text: "0.40");
  TextEditingController _cpallustichRatecontroller = TextEditingController();
  TextEditingController _cpalluheadRatecontroller = TextEditingController(text : "1.5");
  TextEditingController _pallustichRatecontroller = TextEditingController();
  TextEditingController _palluheadRatecontroller = TextEditingController(text : "7");
  TextEditingController _sktstichRatecontroller = TextEditingController();
  TextEditingController _sktheadRatecontroller = TextEditingController(text : "11");
  TextEditingController _blzstichRatecontroller = TextEditingController();
  TextEditingController _blzheadRatecontroller = TextEditingController(text : "1.5");
  TextEditingController addmoneycontroller = TextEditingController(text: "");
  double? stitchCount;
  double? threadLength;

  num c_pallu = 0.0;
  num pallu = 0.0;
  num skt = 0.0;
  num blz = 0.0;
  num fulltotal = 0.0;
  num addamount = 0.0;
  num newstichrate = 0.0;

  allclear() {
    _stichRatecontroller.clear();
    _cpallustichRatecontroller.clear();
    _cpalluheadRatecontroller.clear();
    _pallustichRatecontroller.clear();
    _palluheadRatecontroller.clear();
    _sktstichRatecontroller.clear();
    _sktheadRatecontroller.clear();
    _blzstichRatecontroller.clear();
    _blzheadRatecontroller.clear();
    addmoneycontroller.clear();
    c_pallu = 0.0;
    pallu = 0.0;
    skt = 0.0;
    blz = 0.0;
    fulltotal = 0.0;
    addamount = 0.0;
    newstichrate = 0.0;
    setState(() {});
  }

  void allcalculate() {
    double safeParse(TextEditingController controller) {
      return double.tryParse(controller.text.isEmpty ? "" : controller.text) ??
          0.0;
    }

    c_pallu = safeParse(_stichRatecontroller) *
        safeParse(_cpallustichRatecontroller) *
        safeParse(_cpalluheadRatecontroller) /
        1000;
    pallu = safeParse(_stichRatecontroller) *
        safeParse(_pallustichRatecontroller) *
        safeParse(_palluheadRatecontroller) /
        1000;
    skt = safeParse(_stichRatecontroller) *
        safeParse(_sktstichRatecontroller) *
        safeParse(_sktheadRatecontroller) /
        1000;
    blz = safeParse(_stichRatecontroller) *
        safeParse(_blzstichRatecontroller) *
        safeParse(_blzheadRatecontroller) /
        1000;
    addamount = safeParse(addmoneycontroller);
    newstichrate = safeParse(_stichRatecontroller);

    fulltotal = (c_pallu + pallu + skt + blz + addamount + newstichrate);

    print("Logger");
    setState(() {});
  }

  @override
  void dispose() {
    _stichRatecontroller.dispose();
    _cpallustichRatecontroller.dispose();
    _cpalluheadRatecontroller.dispose();
    super.dispose();
  }

  final design = Get.find<DesignController>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CommonWidget().poppinsText(
                        text: "Embroidery Calculator",
                        textSize: 18.0,
                        textColor: AppColors.redcolor,
                        textWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      // height: 70,
                      width: Get.width * 0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.whitecolor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.softtextcolor.withOpacity(.2),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget().poppinsText(
                              text: "Stitch Rate:",
                              textSize: 12.0,
                              textWeight: FontWeight.w500),
                          TextFormField(keyboardType: TextInputType.number,
                            controller: _stichRatecontroller,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "00.00",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppColors.softtextcolor.withOpacity(.5))),
                            onChanged: (value) {
                              allcalculate();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  calcBox(),
                  SizedBox(width: Get.width * 0.9,
                  child: Column(
                    children: [
                      DesignPartInputRow(label: "C-Pallu", part: design.cPallu, total: design.cPalluTotal, onChanged: )
                    ],
                  ),),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      // height: 70,
                      width: Get.width * 0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.whitecolor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.softtextcolor.withOpacity(.2),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget().poppinsText(
                              text: "Add on Prices:",
                              textSize: 12.0,
                              textWeight: FontWeight.w500),
                          TextFormField(keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "00.00",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppColors.softtextcolor.withOpacity(.5))),
                            controller: addmoneycontroller,
                            onChanged: (value) {
                              allcalculate();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                 ],
              ),
            ),
             Spacer(),
             Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.softtextcolor.withOpacity(.2),
                            blurRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget().poppinsText(
                          text: "Total  Stitches:",
                          textSize: 12.0,
                          textWeight: FontWeight.w500),
                      CommonWidget().poppinsText(
                          text: fulltotal.toStringAsFixed(2),
                          textWeight: FontWeight.bold,
                          textColor: AppColors.softtextcolor.withOpacity(.5),
                          textSize: 30.0),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await allclear();
                              allcalculate();
                            },
                            child: Container(
                              height: 45,
                              width: Get.width * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 2),
                              ),
                              child: Center(
                                  child: CommonWidget().poppinsText(
                                      text: "CLEAR",
                                      textSize: 14.0,
                                      textWeight: FontWeight.w700)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(AddDesignView());
                            },
                            child: Container(
                              height: 45,
                              width: Get.width * 0.43,
                              decoration: BoxDecoration(
                                color: AppColors.redcolor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: CommonWidget().poppinsText(
                                      text: "SAVE",
                                      textColor: AppColors.whitecolor,
                                      textSize: 14.0,
                                      textWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }

  Widget calcBox() {
    DesignPart designPart = DesignPart(type: DesignPartType.cPallu);
    Design design = Design(cPallu: designPart, pallu: DesignPart(type: DesignPartType.cPallu), stk: DesignPart(type: DesignPartType.stk), blz: DesignPart(type: DesignPartType.blz));
    return Center(
        child: SizedBox(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.12,
                child: CommonWidget().poppinsText(
                    text: "Name", textSize: 14.0, textWeight: FontWeight.w400),
              ),
              SizedBox(
                width: Get.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget().poppinsText(
                        text: "Stitches",
                        textSize: 14.0,
                        textWeight: FontWeight.w400),
                    CommonWidget().poppinsText(
                        text: "Head",
                        textSize: 14.0,
                        textWeight: FontWeight.w400),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.18,
                child: Center(
                  child: CommonWidget().poppinsText(
                      text: "Total",
                      textSize: 14.0,
                      textWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          // C-pallu==============================================================
          DesignPartInputRow(label: "C-Pallu", part: designPart, total: designPart.total(design.addOnPrice), onChanged: () {
            
          },),
// pallu========================================================================
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.15,
                child: CommonWidget().poppinsText(text: "Pallu"),
              ),
              Container(
                height: 50,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: Center(
                        child: TextFormField(keyboardType: TextInputType.number,
                          controller: _pallustichRatecontroller,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "00",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.softtextcolor.withOpacity(.5))),
                          onChanged: (value) {
                            allcalculate();
                          },
                        ),
                      ),
                    ),
                    Container(
                        height: 10, width: 1, color: AppColors.blackcolor),
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: TextFormField(keyboardType: TextInputType.number,
                        controller: _palluheadRatecontroller,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "00",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors.softtextcolor.withOpacity(.5))),
                        onChanged: (value) {
                          allcalculate();
                        },
                      ),
                    )
                  ],
                ),
              ),
              CommonWidget().poppinsText(
                  text: "=", textSize: 14.0, textWeight: FontWeight.w400),
              Container(
                height: 50,
                width: Get.width * 0.18,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Center(
                  child: CommonWidget().poppinsText(
                      text: pallu.toStringAsFixed(2),
                      textSize: 14.0,
                      textWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
// Skt========================================================================
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.15,
                child: CommonWidget().poppinsText(text: "Skt"),
              ),
              Container(
                height: 50,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: Center(
                        child: TextFormField(keyboardType: TextInputType.number,
                          controller: _sktstichRatecontroller,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "00",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.softtextcolor.withOpacity(.5))),
                          onChanged: (value) {
                            allcalculate();
                          },
                        ),
                      ),
                    ),
                    Container(
                        height: 10, width: 1, color: AppColors.blackcolor),
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: TextFormField(keyboardType: TextInputType.number,
                        controller: _sktheadRatecontroller,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "00",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors.softtextcolor.withOpacity(.5))),
                        onChanged: (value) {
                          allcalculate();
                        },
                      ),
                    )
                  ],
                ),
              ),
              CommonWidget().poppinsText(
                  text: "=", textSize: 14.0, textWeight: FontWeight.w400),
              Container(
                height: 50,
                width: Get.width * 0.18,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Center(
                  child: CommonWidget().poppinsText(
                      text: skt.toStringAsFixed(2),
                      textSize: 14.0,
                      textWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
// Blz========================================================================
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.15,
                child: CommonWidget().poppinsText(text: "Blz"),
              ),
              Container(
                height: 50,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: Center(
                        child: TextFormField(keyboardType: TextInputType.number,
                          controller: _blzstichRatecontroller,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "00",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.softtextcolor.withOpacity(.5))),
                          onChanged: (value) {
                            allcalculate();
                          },
                        ),
                      ),
                    ),
                    Container(
                        height: 10, width: 1, color: AppColors.blackcolor),
                    SizedBox(
                      width: Get.width * 0.22,
                      height: 50,
                      child: TextFormField(keyboardType: TextInputType.number,
                        controller: _blzheadRatecontroller,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "00",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors.softtextcolor.withOpacity(.5))),
                        onChanged: (value) {
                          allcalculate();
                        },
                      ),
                    )
                  ],
                ),
              ),
              CommonWidget().poppinsText(
                  text: "=", textSize: 14.0, textWeight: FontWeight.w400),
              Container(
                height: 50,
                width: Get.width * 0.18,
                decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                ),
                child: Center(
                  child: CommonWidget().poppinsText(
                      text: blz.toStringAsFixed(2),
                      textSize: 14.0,
                      textWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
