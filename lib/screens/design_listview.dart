import 'dart:io';

import 'package:calculator/controllers/design_mapper.dart';
import 'package:calculator/controllers/storage_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:calculator/helpers/images.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/models/design_entity.dart';
import 'package:calculator/resources/dialogs/show_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DesignListview extends StatelessWidget {
  const DesignListview({super.key});

  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<StorageController>();
    final designList = storageController.designList;
    print('===>2');
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget().poppinsText(
                    text: "Designs",
                    textSize: 18.0,
                    textColor: AppColors.redcolor,
                    textWeight: FontWeight.w700,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset("${AppImage.icon}Search.png"),
                  ),
                ],
              ),
            ),
            Obx(() => Expanded(
                  child: designList.isEmpty
                      ? const Center(child: Text("No Design Found"))
                      : ListView.builder(
                          itemCount: designList.length,
                          itemBuilder: (context, index) {
                            final designId = designList[index].id;
                            final DesignEntity? designEntity = storageController
                                .getDesignWithRelations(designId);

                            if (designEntity == null) {
                              return const SizedBox(
                                child: Text("No Design Found 😢"),
                              );
                            }
                            print("ooooooooooo");
                            print(designEntity.imagePaths.length);
                            Design design = entityToDesign(designEntity);
                            print(design.imagePaths.length);

                            return Slidable(
                              key: Key(designId.toString()),
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.25,
                                children: [
                                  SlidableAction(
                                    onPressed: (_) =>
                                        showDeleteDialog(context, designId),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () => Get.toNamed('/design_preview',
                                    arguments: design),
                                child: _designItem(design),
                              ),
                            );
                          },
                        ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _designItem(Design design) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.softtextcolor.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: Get.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // 👈 Rounded corners
              child: (design.imagePaths.isNotEmpty &&
                      File(design.imagePaths[0].path).existsSync())
                  ? Image.file(
                      File(design.imagePaths[0].path),
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://i.pinimg.com/474x/ee/77/7f/ee777fdb78ad9d524d67f8f589d818e3.jpg",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            children: [
              SizedBox(
                width: Get.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget().poppinsText(
                      text: design.designName.isNotEmpty
                          ? design.designName
                          : "Rimzim",
                      textSize: 18.0,
                      textWeight: FontWeight.w700,
                    ),
                    CommonWidget().poppinsText(
                      text: design.grandTotal.toStringAsFixed(2),
                      textSize: 15.0,
                      textWeight: FontWeight.w700,
                    ),
                    CommonWidget().poppinsText(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Lacus rutrum egestas posuere pellentesque amet lacinia. Ut massa nibh sit aliquet ut nunc leo.",
                      textSize: 12.0,
                      textMaxline: 2,
                      textOverFlow: TextOverflow.ellipsis,
                      textWeight: FontWeight.w700,
                      textColor: AppColors.softtextcolor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
