import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep/common/apis/common.dart';
import 'package:keep/common/entities/loan/step.dart';
import 'package:flutter_my_picker_null_safety/flutter_my_picker.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/entities/home/common.dart';
import '../../../common/entities/home/only_store.dart';
import '../../../common/utils/common.dart';
import '../../../common/utils/gzx_style.dart';
import '../../../common/widgets/bottom_picker/bottom_picker.dart';
import '../../../common/widgets/bottom_picker/resources/arrays.dart';
import '../../../common/widgets/custom_date_range_picker/custom_date_range_picker.dart';
import '../../user_detail/widget/common_dialog.dart';
import '../logic.dart';
import 'multi_select.dart';

class GZXFilterGoodsPage extends StatefulWidget {
  final List<SelectItem> selectItems;

  const GZXFilterGoodsPage({
    Key? key,
    required this.selectItems,
  }) : super(key: key);

  @override
  _GZXFilterGoodsPageState createState() => _GZXFilterGoodsPageState();
}

class _GZXFilterGoodsPageState extends State<GZXFilterGoodsPage> {
  final logic = Get.find<HomeLogic>();
  int minValue = 18;
  int maxValue = 80;
  final List<SelectItem> _valueFrom = [];
  final List<SelectItem> _valueEducation = [];
  final List<SelectItem> _valueIncome = [];
  final List<SelectItem> _valueHouse = [];
  final List<SelectItem> _valueMarriage = [];
  List<String> pickerStoreData = [];
  List<StoreItem> pickerStoreItem = [];
  List<String> pickerUserData = [];
  List<UserItem> pickerUserItem = [];
  DateTime? startDate;
  DateTime? endDate;
  bool _isHideValue1 = true;
  DateTime startBirthDay = DateTime.parse("1995-01-01 00:00:00");
  DateTime endBirthDay = DateTime.parse("2004-01-01 00:00:00");
  String startBirthDayTitle = "";
  String endBirthDayTitle = "请选择";
  String dateRangeTitle ="请选择日期";
  String startBirthDayValue = "";
  String endBirthDayValue = "";
  String store = "";
  String storeName = "选择门店";
  String userName = "选择用户";
  String channelName = "选择渠道";
  String title = "请选择操作步骤";
  List<SelectItem> dataString = <SelectItem>[];
  List<SelectItem>? selectedDataString;

  @override
  void initState() {
    super.initState();
    minValue = 18;
    maxValue = 80;
    _init();
  }

  _init() async {
    for (int i = 1; i < fromLevel.length; i++) {
      SelectItem ff = SelectItem();
      ff.id = i.toString();
      ff.type = 0;
      ff.name = fromLevel[i];
      ff.isSelect = false;
      _valueFrom.add(ff);
    }
    for (int i = 1; i < EduLevel.length; i++) {
      SelectItem ff = SelectItem();
      ff.id = i.toString();
      ff.type = 1;
      ff.name = EduLevel[i];
      ff.isSelect = false;
      _valueEducation.add(ff);
    }
    for (int i = 1; i < IncomeLevel.length; i++) {
      SelectItem ff = SelectItem();
      ff.id = i.toString();
      ff.type = 2;
      ff.name = IncomeLevel[i];
      ff.isSelect = false;
      _valueIncome.add(ff);
    }

    for (int i = 1; i < hasHouseLevel.length; i++) {
      SelectItem ff = SelectItem();
      ff.id = i.toString();
      ff.type = 3;
      ff.name = hasHouseLevel[i];
      ff.isSelect = false;
      _valueHouse.add(ff);
    }
    for (int i = 1; i < marriageLevel.length; i++) {
      SelectItem ff = SelectItem();
      ff.id = i.toString();
      ff.type = 4;
      ff.name = marriageLevel[i];
      ff.isSelect = false;
      _valueMarriage.add(ff);
    }

    var result = await CommonAPI.getOnlyStoreList();
    if (result.code == 200) {
      List<StoreData> da = result.Data;
      for (var value in da) {
        StoreItem ff = StoreItem();
        ff.id = value.id;
        ff.type = 7;
        ff.name = value.name;
        ff.index = 0;
        ff.isSelect = false;
        pickerStoreItem.add(ff);
        pickerStoreData.add(value.name);
      }
    } else {}
    String storeId = "";
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 100) {
        storeId = widget.selectItems[j].id!;
      }
    }
    var results = await CommonAPI.getSuperStep({});
    if (results.code == 200) {
      List<StepDataData> da = results.data!.data!;
      for (var value in da) {
        SelectItem ff = SelectItem();
        ff.id = value.status.toString();
        ff.type = value.num;
        ff.name = value.label + "(" + value.num.toString() + ")";
        ff.isSelect = false;
        dataString.add(ff);
      }
    } else {}
    if(mounted)
    setState(() {});
  }

  Widget _typeGridWidget(List<SelectItem> items, int type) {
    return MultiChipFilters(
      data: items,
      avatarBuilder: (_, index) {
        return Container();
      },
      labelBuilder: (_, selected, name) {
        return name == ""
            ? Container()
            : Text(
                name,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              );
      },
      onChange: _doSelectStart,
      selectedS: widget.selectItems,
      childAspectRatio: 2.0,
    );
  }

  Widget _typeGridWidgetStep(List<SelectItem> items, int type) {
    return MultiChipFilters(
      data: items,
      avatarBuilder: (_, index) {
        return Container();
      },
      labelBuilder: (_, selected, name) {
        return name == ""
            ? Container()
            : Text(
                name,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              );
      },
      onChange: _doSelectStart,
      selectedS: widget.selectItems,
      childAspectRatio: 2.0,
    );
  }

  _doSelectStart(List<SelectItem> s) {
    debugPrint("-----------");
    for (int i = 0; i < s.length; i++) {
      debugPrint(s[i].id! + "/" + s[i].type.toString());
    }
    debugPrint("-----------");
  }

  Widget buildBirthday(String title) {
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 5) {
        startBirthDayTitle = widget.selectItems[j].id!;
        startBirthDayValue = widget.selectItems[j].id!;
      }
      if (widget.selectItems[j].type == 6) {
        endBirthDayTitle = widget.selectItems[j].id!;
        endBirthDayValue = widget.selectItems[j].id!;
      }
    }

    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 10.w, top: 10.h, right: 0.w, bottom: 0.h),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style:
                  TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {
                  MyPicker.showPicker(
                      squeeze: 1.45,
                      magnification: 1.3,
                      offAxisFraction: 0.2,
                      context: context,
                      current: startBirthDay,
                      mode: MyPickerMode.date,
                      onConfirm: (v) {
                        //_change('yyyy-MM-dd HH:mm'),
                        debugPrint(v.toString());
                        setState(() {
                          startBirthDay = v;
                          startBirthDayTitle = startBirthDay.year.toString() +
                              "-" +
                              startBirthDay.month.toString() +
                              "-" +
                              startBirthDay.day.toString();
                          startBirthDayValue = startBirthDayTitle;

                          int j = 0;
                          for (int i = 0; i < widget.selectItems.length; i++) {
                            if (widget.selectItems[i].type == 5) {
                              j = 1;
                              widget.selectItems[i].id = startBirthDayValue;
                              break;
                            }
                          }

                          if (j == 0) {
                            SelectItem s = SelectItem();
                            s.type = 5;
                            s.id = startBirthDayValue;
                            widget.selectItems.add(s);
                          }
                        });
                      });
                },
                child: Text(
                  startBirthDayTitle == "" ? " " : startBirthDayTitle,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: startBirthDayValue == ""
                          ? Colors.black
                          : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: startBirthDayValue == ""
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 50.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {
                  MyPicker.showPicker(
                      squeeze: 1.45,
                      magnification: 1.3,
                      offAxisFraction: 0.2,
                      context: context,
                      current: endBirthDay,
                      mode: MyPickerMode.date,
                      onConfirm: (v) {
                        //_change('yyyy-MM-dd HH:mm'),
                        debugPrint(v.toString());
                        setState(() {
                          endBirthDay = v;
                          endBirthDayTitle = endBirthDay.year.toString() +
                              "-" +
                              endBirthDay.month.toString() +
                              "-" +
                              endBirthDay.day.toString();
                          endBirthDayValue = endBirthDayTitle;
                          int j = 0;
                          for (int i = 0; i < widget.selectItems.length; i++) {
                            if (widget.selectItems[i].type == 6) {
                              j = 1;
                              widget.selectItems[i].id = endBirthDayValue;
                              break;
                            }
                          }

                          if (j == 0) {
                            SelectItem s = SelectItem();
                            s.type = 6;
                            s.id = endBirthDayValue;
                            widget.selectItems.add(s);
                          }
                        });
                      });
                },
                child: Text(
                  endBirthDayTitle == "" ? " " : endBirthDayTitle,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color:
                          endBirthDayValue == "" ? Colors.black : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: endBirthDayValue == ""
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 12.h),
            decoration: BoxDecoration(
//      color: Colors.red,
                border: Border(
                    bottom: BorderSide(
                        width: 2.w, color: GZXColors.mainBackgroundColor))))
      ],
    );
  }
  Widget buildDateRange(String title) {
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 5) {
        startBirthDayTitle = widget.selectItems[j].id!;
        startBirthDayValue = widget.selectItems[j].id!;
      }
      if (widget.selectItems[j].type == 6) {
        endBirthDayTitle = widget.selectItems[j].id!;
        endBirthDayValue = widget.selectItems[j].id!;
      }
    }

    return Column(
      children: [
        Container(
          padding:
          EdgeInsets.only(left: 10.w, top: 10.h, right: 0.w, bottom: 0.h),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style:
              TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 50.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime.utc(2012),
                    maximumDate: DateTime.now().add(const Duration(days: 365)),
                    endDate: endDate,
                    startDate: startDate,
                    onApplyClick: (start, end) {
                      setState(() {
                        endDate = end;
                        startDate = start;

                        endBirthDay = end;
                        endBirthDayTitle = endBirthDay.year.toString() +
                            "-" +
                            endBirthDay.month.toString() +
                            "-" +
                            endBirthDay.day.toString();
                        endBirthDayValue = endBirthDayTitle;
                        startBirthDay = start;
                        startBirthDayTitle = startBirthDay.year.toString() +
                            "-" +
                            startBirthDay.month.toString() +
                            "-" +
                            startBirthDay.day.toString();
                        int j = 0;
                        for (int i = 0; i < widget.selectItems.length; i++) {
                          if (widget.selectItems[i].type == 6) {
                            j = 1;
                            widget.selectItems[i].id = endBirthDayValue;
                            break;
                          }
                        }

                        if (j == 0) {
                          SelectItem s = SelectItem();
                          s.type = 6;
                          s.id = endBirthDayValue;
                          widget.selectItems.add(s);
                        }

                        startBirthDayValue = startBirthDayTitle;
                        dateRangeTitle = startBirthDayTitle+"至"+endBirthDayTitle;

                        int h = 0;
                        for (int i = 0; i < widget.selectItems.length; i++) {
                          if (widget.selectItems[i].type == 5) {
                            h = 1;
                            widget.selectItems[i].id = startBirthDayValue;
                            break;
                          }
                        }

                        if (h == 0) {
                          SelectItem s = SelectItem();
                          s.type = 5;
                          s.id = startBirthDayValue;
                          widget.selectItems.add(s);
                        }

                      });
                    },
                    onCancelClick: () {
                      setState(() {
                        endDate = null;
                        startDate = null;
                      });
                    },
                  );
                },
                child: Text(
                  dateRangeTitle == "" ? " " : dateRangeTitle,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color:
                      endBirthDayValue == "" ? Colors.black : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: endBirthDayValue == ""
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                    EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 12.h),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2.w, color: GZXColors.mainBackgroundColor))))
      ],
    );
  }
  Widget buildStore(String title) {
    int storeId = 0;
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 7) {
        storeId = int.parse(widget.selectItems[j].id!);
        storeName = widget.selectItems[j].name!;
      }
    }
    for (int j = 0; j < pickerStoreItem.length; j++) {
      if (pickerStoreItem[j].id.toString() == storeId.toString()) {
        storeId = j;
      }
    }

    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style:
                  TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {
                  Picker(
                      selecteds: [storeId],
                      itemExtent: 40,
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      cancelText: "取消",
                      confirmText: "确定",
                      selectedTextStyle:
                          TextStyle(fontSize: 40.sp, color: Colors.redAccent),
                      textStyle:
                          TextStyle(fontSize: 25.sp, color: Colors.black),
                      adapter: PickerDataAdapter<String>(
                          pickerdata: pickerStoreData),
                      changeToFirst: true,
                      hideHeader: false,
                      onConfirm: (Picker picker, List value) {
                        debugPrint(value.toString());
                        debugPrint(picker.adapter.text);
                        setState(() {
                          store = pickerStoreItem[value[0]].id.toString();
                          storeName = pickerStoreItem[value[0]].name!;
                          int j = 0;
                          for (int i = 0; i < widget.selectItems.length; i++) {
                            if (widget.selectItems[i].type == 7) {
                              j = 1;
                              widget.selectItems[i].id =
                                  pickerStoreItem[value[0]].id.toString();
                              widget.selectItems[i].name =
                                  pickerStoreItem[value[0]].name;
                              break;
                            }
                          }

                          if (j == 0) {
                            SelectItem s = SelectItem();
                            s.type = 7;
                            s.name = pickerStoreItem[value[0]].name;
                            s.id = pickerStoreItem[value[0]].id.toString();
                            widget.selectItems.add(s);
                          }
                        });
                      }).showModal(context); //_scaffoldKey.currentState);
                },
                child: Text(
                  storeName == "" ? " " : storeName,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: storeName == "选择门店" ? Colors.black : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: storeName == "选择门店"
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildUser(String title) {
    int userId = 0;
    int selectUserId = 0;
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 8) {
        selectUserId = int.parse(widget.selectItems[j].id!);
        userName = widget.selectItems[j].name!;
        break;
      }
    }

    for (int j = 0; j < pickerUserItem.length; j++) {
      if (pickerUserItem[j].id == selectUserId.toString()) {
        break;
      }
      userId++;
    }
    if (selectUserId == 0) {
      userId = 0;
    }
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 10.w, top: 10.h, right: 0.w, bottom: 0.h),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style:
                  TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {

                  BottomPicker.date(
                      height: 500.h,
                      buttonTextStyle: TextStyle(color: Colors.white,fontSize: 32.sp),
                      buttonSingleColor: Colors.green,
                      displayButtonIcon: false,
                      buttonText: "确定",
                      title:  "选择出生年月",
                      titleStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize:  38.sp,
                          color: Colors.black
                      ),
                      onChange: (index) {
                        print(index);
                      },
                      onSubmit: (index) {
                        print(index);
                      },
                      bottomPickerTheme: BottomPickerTheme.plumPlate
                  ).show(context);

                  // Picker(
                  //     squeeze: 1.45,
                  //     magnification: 1.2,
                  //     height: 500.h,
                  //     selecteds: [userId],
                  //     itemExtent: 40,
                  //     selectionOverlay:
                  //         const CupertinoPickerDefaultSelectionOverlay(
                  //       background: Colors.transparent,
                  //     ),
                  //     cancelText: "取消",
                  //     confirmText: "确定",
                  //     selectedTextStyle:
                  //         TextStyle(fontSize: 40.sp, color: Colors.redAccent),
                  //     textStyle:
                  //         TextStyle(fontSize: 25.sp, color: Colors.black),
                  //     adapter:
                  //         PickerDataAdapter<String>(pickerdata: pickerUserData),
                  //     changeToFirst: true,
                  //     hideHeader: false,
                  //     onConfirm: (Picker picker, List value) {
                  //       debugPrint(value.toString());
                  //       debugPrint(picker.adapter.text);
                  //       setState(() {
                  //         store = pickerUserItem[value[0]].id!;
                  //         storeName = pickerUserItem[value[0]].name!;
                  //         int j = 0;
                  //         for (int i = 0; i < widget.selectItems.length; i++) {
                  //           if (widget.selectItems[i].type == 8) {
                  //             j = 1;
                  //             widget.selectItems[i].id =
                  //                 pickerUserItem[value[0]].id;
                  //             widget.selectItems[i].name =
                  //                 pickerUserItem[value[0]].name;
                  //             break;
                  //           }
                  //         }
                  //
                  //         if (j == 0) {
                  //           SelectItem s = SelectItem();
                  //           s.type = 8;
                  //           s.name = pickerUserItem[value[0]].name;
                  //           s.id = pickerUserItem[value[0]].id;
                  //           widget.selectItems.add(s);
                  //         }
                  //       });
                  //     }).showModal(context); //_scaffoldKey.currentState);
                },
                child: Text(
                  userName == "" ? " " : userName,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: userName == "选择用户" ? Colors.black : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: userName == "选择用户"
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget buildChannel(String title) {
    int userId = 0;
    int selectUserId = 0;
    for (int j = 0; j < widget.selectItems.length; j++) {
      if (widget.selectItems[j].type == 8) {
        selectUserId = int.parse(widget.selectItems[j].id!);
        userName = widget.selectItems[j].name!;
        break;
      }
    }

    for (int j = 0; j < pickerUserItem.length; j++) {
      if (pickerUserItem[j].id == selectUserId.toString()) {
        break;
      }
      userId++;
    }
    if (selectUserId == 0) {
      userId = 0;
    }
    return Column(
      children: [
        Container(
          padding:
          EdgeInsets.only(left: 10.w, top: 10.h, right: 0.w, bottom: 0.h),
          alignment: Alignment.centerLeft,
          child: Text(title,
              style:
              TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
              child: ElevatedButton(
                onPressed: () {
                  Picker(
                      squeeze: 1.45,
                      magnification: 1.2,
                      height: 500.h,
                      selecteds: [userId],
                      itemExtent: 40,
                      selectionOverlay:
                      const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      cancelText: "取消",
                      confirmText: "确定",
                      selectedTextStyle:
                      TextStyle(fontSize: 40.sp, color: Colors.redAccent),
                      textStyle:
                      TextStyle(fontSize: 25.sp, color: Colors.black),
                      adapter:
                      PickerDataAdapter<String>(pickerdata: pickerUserData),
                      changeToFirst: true,
                      hideHeader: false,
                      onConfirm: (Picker picker, List value) {
                        debugPrint(value.toString());
                        debugPrint(picker.adapter.text);
                        setState(() {
                          store = pickerUserItem[value[0]].id!;
                          storeName = pickerUserItem[value[0]].name!;
                          int j = 0;
                          for (int i = 0; i < widget.selectItems.length; i++) {
                            if (widget.selectItems[i].type == 8) {
                              j = 1;
                              widget.selectItems[i].id =
                                  pickerUserItem[value[0]].id;
                              widget.selectItems[i].name =
                                  pickerUserItem[value[0]].name;
                              break;
                            }
                          }

                          if (j == 0) {
                            SelectItem s = SelectItem();
                            s.type = 8;
                            s.name = pickerUserItem[value[0]].name;
                            s.id = pickerUserItem[value[0]].id;
                            widget.selectItems.add(s);
                          }
                        });
                      }).showModal(context); //_scaffoldKey.currentState);
                },
                child: Text(
                  channelName == "" ? " " : channelName,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: channelName == "选择渠道" ? Colors.black : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: channelName == "选择渠道"
                        ? Colors.grey.withAlpha(33)
                        : Colors.blue,
                    shadowColor: Colors.black12,
                    shape: const StadiumBorder(),
                    padding:
                    EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h)),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildGroup1(String title, bool isShowExpansionIcon,
      List<SelectItem> items, List<SelectItem> sel) {
    for (int i = 0; i < items.length; i++) {
      for (int j = 0; j < sel.length; j++) {
        if (sel[j].type == items[i].type && sel[j].id == items[i].id) {
          items[i].isSelect = true;
        }
      }
    }
    return Column(children: [
      SizedBox(
        height: 0.h,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Text(title,
                style:
                    TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
          ),
          !isShowExpansionIcon
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _isHideValue1 = !_isHideValue1;
                    });
                  },
                  child: Icon(
                    _isHideValue1
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.grey,
                  ),
                ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      _typeGridWidget(items, 1),
      Container(
          margin: EdgeInsets.only(top: 12.h),
          decoration: BoxDecoration(
//      color: Colors.red,
              border: Border(
                  bottom: BorderSide(
                      width: 2.w, color: GZXColors.mainBackgroundColor))))
    ]);
  }

  Widget _buildGroupStep(String title, bool isShowExpansionIcon,
      List<SelectItem> items, List<SelectItem> sel) {
    for (int i = 0; i < items.length; i++) {
      for (int j = 0; j < sel.length; j++) {
        if (sel[j].type == items[i].type && sel[j].id == items[i].id) {
          items[i].isSelect = true;
        }
      }
    }
    return Column(children: [
      SizedBox(
        height: 0.h,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Text(title,
                style:
                    TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
          ),
          !isShowExpansionIcon
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _isHideValue1 = !_isHideValue1;
                    });
                  },
                  child: Icon(
                    _isHideValue1
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.grey,
                  ),
                ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      _typeGridWidgetStep(items, 1),
      Container(
          margin: EdgeInsets.only(top: 12.h),
          decoration: BoxDecoration(
//      color: Colors.red,
              border: Border(
                  bottom: BorderSide(
                      width: 2.w, color: GZXColors.mainBackgroundColor))))
    ]);
  }

  void _onCountriesSelectionComplete(value) {
    selectedDataString?.addAll(value);
    title = "已选择";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //height: ScreenUtil().screenHeight,
      child: Column(
        children: <Widget>[

          Expanded(
            child: ListView(
                padding: EdgeInsets.all(0.0),
                physics: const BouncingScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 0.w, top: 0.h, right: 0.w, bottom: 10.h),
                    child: Text(
                      '筛选',
                      style: TextStyle(color: Colors.black, fontSize: 36.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // _buildGroup1('来源渠道', false, _valueFrom, widget.selectItems),
                  // _buildGroup1(
                  //     '客户学历', false, _valueEducation, widget.selectItems),
                  // _buildGroup1(
                  //     '客户收入', false, _valueIncome, widget.selectItems),
                  // _buildGroup1(
                  //     '客户房产', false, _valueHouse, widget.selectItems),
                  // _buildGroup1(
                  //     '客户婚姻状况', false, _valueMarriage, widget.selectItems),

                  _buildGroupStep(
                      '操作步骤', false, dataString, widget.selectItems),
                  buildDateRange("放款时间"),
                  buildDateRange("获取时间"),
                  //buildBirthday("生日选择"),
                  buildUser("所属员工"),
                  buildUser("当前员工"),
                  buildChannel("来源渠道"),
                  // dataString.length==0? Container() :Container(
                  //
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Container(
                  //           padding:
                  //           EdgeInsets.only(left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
                  //           alignment: Alignment.centerLeft,
                  //           child: Text("操作步骤",
                  //               style:
                  //               TextStyle(fontSize: 24.sp, color: const Color(0xFF6a6a6a))),
                  //         ),
                  //       ),
                  //       Container(
                  //         width: ScreenUtil().screenWidth-150.w,
                  //         padding: EdgeInsets.only(
                  //             left: 0.w, top: 0.h, right: 40.w, bottom: 0.h),
                  //         child: CustomMultiSelectField<SelectItem>(
                  //           title: title,
                  //           items: dataString,
                  //           enableAllOptionSelect: true,
                  //           onSelectionDone: _onCountriesSelectionComplete,
                  //           itemAsString: (item) {
                  //             return item.name.toString();
                  //           },
                  //           dropDownItemAsString: (item) {
                  //             return item.name.toString()+"("+item.type.toString()+")";
                  //           }
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //buildStore("门店选择")
                  //buildRangerSlider("年龄选择")
                ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 25.w, top: 6.h, right: 25.w, bottom: 16.h),
                height: 88.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        widget.selectItems.removeWhere((e) => e.type! < 100);

                        for (int j = 0; j < _valueFrom.length; j++) {
                          _valueFrom[j].isSelect = false;
                        }
                        for (int j = 0; j < _valueEducation.length; j++) {
                          _valueEducation[j].isSelect = false;
                        }
                        for (int j = 0; j < _valueIncome.length; j++) {
                          _valueIncome[j].isSelect = false;
                        }
                        for (int j = 0; j < _valueHouse.length; j++) {
                          _valueHouse[j].isSelect = false;
                        }
                        for (int j = 0; j < _valueMarriage.length; j++) {
                          _valueMarriage[j].isSelect = false;
                        }
                        widget.selectItems
                            .removeWhere((e) => e.type == 5 || e.type == 6);
                        startBirthDayTitle = "开始日期";
                        endBirthDayTitle = "结束日期";
                        startBirthDayValue = "";
                        endBirthDayValue = "";
                        widget.selectItems.removeWhere((e) => e.type == 7);
                        widget.selectItems.removeWhere((e) => e.type == 8);
                        storeName = "选择门店";
                        userName = "选择用户";
                        showToastBottom(context, "重置成功", true);
                        logic.onRefresh();
                      },
                      child: Container(
//            margin: EdgeInsets.only(left: 6, right: 6),
                        padding: EdgeInsets.only(
                            left: 100.w, top: 6.h, right: 100.w, bottom: 6.h),
                        height: 68.h,
//                  width: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFfea000),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(34.w)),
                        ),
                        child: Text(
                          '重置',
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.sp),
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.onRefresh();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 100.w, top: 6.h, right: 100.w, bottom: 6.h),
                        height: 68.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFfe7201),
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(34.w)),
                        ),
                        child: Text('确定',
                            style: TextStyle(
                                fontSize: 30.sp, color: Colors.white)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
