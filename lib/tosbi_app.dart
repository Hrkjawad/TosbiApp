import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tosbi/languages.dart';
import 'package:tosbi/tosbi_contoller.dart';

class Tosbi extends StatefulWidget {
  const Tosbi({super.key});

  @override
  State<Tosbi> createState() => _ChatListState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController name = TextEditingController();

final TosbiController _tosbiController = Get.put(TosbiController());

class _ChatListState extends State<Tosbi> {
  @override
  Widget build(BuildContext context) {
    double scaleHeight(double size) {
      final screenHeight = MediaQuery.of(context).size.height;
      const double baselineHeight = 915;
      return size * (screenHeight / baselineHeight);
    }

    double scaleWidth(double size) {
      final screenWidth = MediaQuery.of(context).size.width;
      const double baselineWidth = 412;
      return size * (screenWidth / baselineWidth);
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.list_alt_rounded,
              size: scaleWidth(30),
              color: Colors.white,
            ),
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
                _tosbiController.setDrawerState(false);
              } else {
                scaffoldKey.currentState!.openDrawer();
                _tosbiController.setDrawerState(true);
              }
            },
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Obx(
            () => Text(
              _tosbiController.isDrawerOpen.value
                  ? "AppBar_DrawerTitle".tr
                  : "AppBar_Title".tr,
              style: TextStyle(
                fontSize: scaleWidth(30),
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (scaffoldKey.currentState!.isEndDrawerOpen) {
                    scaffoldKey.currentState!.closeEndDrawer();
                  } else {
                    scaffoldKey.currentState!.openEndDrawer();
                  }
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: scaleWidth(30),
                  color: Colors.white,
                ))
          ],
        ),
        body: Scaffold(
          key: scaffoldKey,
          onDrawerChanged: (isOpen) {
            _tosbiController.isDrawerOpen.value = false;
          },
          drawer: customisedDrawer(context),
          endDrawer: Drawer(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: scaleWidth(30), left: scaleWidth(10)),
                  child: ListTile(
                    trailing: Obx(
                      () => Switch(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return Icon(
                              Icons.dark_mode,
                              color: Colors.black,
                              size: scaleWidth(24),
                            );
                          }
                          return Icon(
                            Icons.sunny,
                            color: Colors.orange,
                            size: scaleWidth(24),
                          );
                        }),
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: Colors.grey,
                        value: _tosbiController.currentTheme.value ==
                            ThemeMode.dark,
                        onChanged: (value) {
                          _tosbiController.switchTheme();
                          Get.changeThemeMode(
                              _tosbiController.currentTheme.value);
                        },
                        activeColor: Colors.white,
                      ),
                    ),
                    title: Obx(
                      () => Text(
                        _tosbiController.currentTheme.value == ThemeMode.light
                            ? 'Light_Mode'.tr
                            : 'Dark_Mode'.tr,
                        style: TextStyle(
                          fontSize: scaleWidth(24),
                          fontWeight: FontWeight.w700,
                          color: _tosbiController.currentTheme.value ==
                                  ThemeMode.light
                              ? Colors.teal
                              : Colors.tealAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scaleHeight(20),
                ),
                Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(scaleWidth(20)),
                    fillColor: Colors.teal,
                    onPressed: (int index) {
                      if (_tosbiController.language.value ==
                          const Locale("bn", "BD")) {
                        index == 0;
                      } else {
                        index == 1;
                      }
                    },
                    isSelected: [
                      _tosbiController.language.value ==
                          const Locale("bn", "BD"),
                      _tosbiController.language.value ==
                          const Locale("en", "US")
                    ],
                    children: [
                      TextButton(
                          onPressed: () {
                            if (_tosbiController.language.value ==
                                const Locale("en", "US")) {
                              _tosbiController.switchLanguage();
                              Get.updateLocale(_tosbiController.language.value);
                            }
                          },
                          child: Text(
                            "বাং",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: scaleWidth(22),
                                color: _tosbiController.language.value ==
                                        const Locale("bn", "BD")
                                    ? Colors.white
                                    : Colors.teal),
                          )),
                      TextButton(
                          onPressed: () {
                            if (_tosbiController.language.value ==
                                const Locale("bn", "BD")) {
                              _tosbiController.switchLanguage();
                              Get.updateLocale(_tosbiController.language.value);
                            }
                          },
                          child: Text(
                            "Eng",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: scaleWidth(22),
                                color: _tosbiController.language.value ==
                                        const Locale("en", "US")
                                    ? Colors.white
                                    : Colors.teal),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: scaleHeight(20),
                ),
                Obx(
                  () => Card(
                    color:
                        _tosbiController.currentTheme.value == ThemeMode.light
                            ? Colors.teal
                            : Colors.white,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Allah's99Name".tr,
                      style: TextStyle(
                        fontSize: scaleWidth(24),
                        fontWeight: FontWeight.w800,
                        color: _tosbiController.currentTheme.value ==
                                ThemeMode.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scaleHeight(10),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 99,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Obx(
                            () => ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          textAlign: TextAlign.center,
                                          _tosbiController.language ==
                                                  const Locale("bn", "BD")
                                              ? allah99Names[index]['bangla']
                                                  .toString()
                                              : allah99Names[index]['english']
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: scaleWidth(24),
                                              fontWeight: FontWeight.w500,
                                              color: _tosbiController
                                                          .currentTheme.value ==
                                                      ThemeMode.light
                                                  ? Colors.teal
                                                  : Colors.tealAccent),
                                        ),
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          "TosbiOfAllahName".tr,
                                          style: TextStyle(
                                            fontSize: scaleWidth(20),
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              _tosbiController.language ==
                                                      const Locale("bn", "BD")
                                                  ? _tosbiController
                                                      .setDisplayTosbiName(
                                                          allah99Names[index]
                                                                  ['bangla']
                                                              .toString())
                                                  : _tosbiController
                                                      .setDisplayTosbiName(
                                                          allah99Names[index]
                                                                  ['english']
                                                              .toString());
                                              _tosbiController
                                                  .removeCountData();
                                              scaffoldKey.currentState!
                                                  .closeEndDrawer();
                                              Get.back();
                                            },
                                            icon: Icon(
                                              Icons.done_outline_rounded,
                                              size: scaleWidth(40),
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(
                                            width: scaleWidth(125),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                size: scaleWidth(40),
                                                color: Colors.red,
                                              ))
                                        ],
                                      );
                                    });
                              },
                              title: Text(
                                _tosbiController.language ==
                                        const Locale("bn", "BD")
                                    ? allah99Names[index]['bangla']!
                                    : allah99Names[index]['english']!,
                                style: TextStyle(
                                    fontSize: scaleWidth(22),
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                _tosbiController.language ==
                                        const Locale("bn", "BD")
                                    ? allah99NamesMeaning[index]['bangla']!
                                    : allah99NamesMeaning[index]['english']!,
                                style: TextStyle(
                                    fontSize: scaleWidth(20),
                                    color:
                                        _tosbiController.currentTheme.value ==
                                                ThemeMode.light
                                            ? Colors.teal
                                            : Colors.tealAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Text(
                                (index + 1).toString(),
                                style: TextStyle(fontSize: scaleWidth(16)),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.teal,
                            thickness: 2,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleWidth(50)),
            ),
            backgroundColor: Colors.redAccent,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        textAlign: TextAlign.center,
                        "Reset_Text".tr,
                        style: TextStyle(
                          fontSize: scaleWidth(22),
                        ),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                _tosbiController.removeCountData();
                                _tosbiController.displayName.value = "";
                                name.clear();
                                Get.back();
                              },
                              icon: Icon(
                                Icons.done_outline_rounded,
                                size: scaleWidth(40),
                                color: Colors.green,
                              )),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: scaleWidth(40),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Divider(
                          thickness: 2,
                          color: Colors.teal,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                _tosbiController.tosbiCountDecrease();
                              },
                              child: Text(
                                "Decrease_Count".tr,
                                style: TextStyle(
                                    fontSize: scaleWidth(18),
                                    color: Colors.red),
                              )),
                        ),
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.restart_alt_rounded,
              size: scaleWidth(35),
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: scaleHeight(50),
                ),
                Obx(
                  () => Text(
                    _tosbiController.displayName.value == ""
                        ? ""
                        : _tosbiController.displayName.value,
                    //   _tosbiController.saveTosbi.map((index) => index.split(' : ')[1]).join('').toString(),
                    style: TextStyle(
                        fontSize: scaleWidth(30),
                        color: _tosbiController.currentTheme == ThemeMode.light
                            ? Colors.teal
                            : Colors.tealAccent,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: scaleHeight(10),
                ),
                Center(
                  child: Obx(
                    () => Text(
                      _tosbiController.language.value ==
                              const Locale("en", "US")
                          ? _tosbiController.count.toString()
                          : _tosbiController.banglaCount.toString(),
                      style: TextStyle(
                          fontSize: scaleWidth(100),
                          fontWeight: FontWeight.w800,
                          color: _tosbiController.currentTheme.value ==
                                  ThemeMode.dark
                              ? Colors.white
                              : Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: scaleHeight(30),
                ),
                Obx(
                  () => Ink(
                    width: scaleWidth(330),
                    height: scaleHeight(330),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scaleWidth(115)),
                      color:
                          _tosbiController.currentTheme.value == ThemeMode.dark
                              ? Colors.white70
                              : Colors.teal,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        _tosbiController.tosbiCount();
                      },
                      icon: Image.asset(
                        "assets/tosbi_logo.webp",
                        scale: scaleWidth(3),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scaleHeight(50),
                ),
                SizedBox(
                  height: scaleHeight(50),
                  width: scaleWidth(150),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color: Colors.teal, width: scaleWidth(2))),
                    onPressed: () {
                      var name1 = _tosbiController.displayName.value;
                      bool isUpdated = false;
                      if (_tosbiController.displayName.value.isNotEmpty) {
                        //name.text = _tosbiController.displayName.toString();
                        for (int i = 0;
                            i < _tosbiController.saveTosbi.length;
                            i++) {
                          var item = _tosbiController.saveTosbi[i]
                              .toString()
                              .split(" : ");
                          if (name1 == item[0]) {
                            var count1 = _tosbiController.language.value ==
                                    const Locale("en", "US")
                                ? _tosbiController.count.toString()
                                : _tosbiController.banglaCount.toString();
                            _tosbiController.saveTosbi[i] = "$name1 : $count1";
                            _tosbiController.listStoreData();
                            Get.snackbar("", "",
                                titleText: Text(
                                  "$name1 : $count1",
                                  style: TextStyle(
                                      fontSize: scaleWidth(20),
                                      color: Colors.white),
                                ),
                                messageText: Text(
                                  "Saved".tr,
                                  style: TextStyle(
                                      fontSize: scaleWidth(20),
                                      color: Colors.white),
                                ),
                                backgroundColor: Colors.teal,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 2));
                            isUpdated = true;
                            break;
                          }
                        }
                        if (!isUpdated) {
                          var count1 = _tosbiController.language.value ==
                                  const Locale("en", "US")
                              ? _tosbiController.count.toString()
                              : _tosbiController.banglaCount.toString();
                          _tosbiController.addToTosbiList("$name1 : $count1");
                          Get.snackbar("", "",
                              titleText: Text(
                                "$name1 : $count1",
                                style: TextStyle(
                                    fontSize: scaleWidth(20),
                                    color: Colors.white),
                              ),
                              messageText: Text(
                                "Saved".tr,
                                style: TextStyle(
                                    fontSize: scaleWidth(20),
                                    color: Colors.white),
                              ),
                              backgroundColor: Colors.teal,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "TextField_Title".tr,
                                  style: TextStyle(
                                    fontSize: scaleWidth(26),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Form(
                                  key: formKey,
                                  child: SizedBox(
                                    height: scaleHeight(220),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          style: TextStyle(
                                              fontSize: scaleWidth(22),
                                              color: Colors.black),
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "TextField_Error_Text".tr;
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: name,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scaleWidth(20)),
                                                borderSide: const BorderSide(
                                                    color: Colors.teal)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scaleWidth(20)),
                                                borderSide: const BorderSide(
                                                    color: Colors.teal)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scaleWidth(20)),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                )),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scaleWidth(20)),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            errorStyle: TextStyle(
                                                fontSize: scaleWidth(16)),
                                            hintText: "HintText".tr,
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                name1 = name.text;
                                                var count1 = _tosbiController
                                                            .language.value ==
                                                        const Locale("en", "US")
                                                    ? _tosbiController.count
                                                        .toString()
                                                    : _tosbiController
                                                        .banglaCount
                                                        .toString();
                                                _tosbiController.addToTosbiList(
                                                    "$name1 : $count1");
                                                _tosbiController
                                                    .setDisplayTosbiName(name1);
                                                name.clear();
                                                Get.back();
                                                Get.snackbar("", "",
                                                    titleText: Text(
                                                      "$name1 : $count1",
                                                      style: TextStyle(
                                                          fontSize:
                                                              scaleWidth(20),
                                                          color: Colors.white),
                                                    ),
                                                    messageText: Text(
                                                      "Saved".tr,
                                                      style: TextStyle(
                                                          fontSize:
                                                              scaleWidth(20),
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        Colors.teal,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    duration:
                                                        Duration(seconds: 2));
                                              }
                                            },
                                            icon: Icon(
                                              Icons.offline_pin_rounded,
                                              size: scaleWidth(50),
                                              color: Colors.teal,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    },
                    child: Text(
                      "Button_Text".tr,
                      style: TextStyle(
                          fontSize: scaleWidth(28),
                          color: Colors.teal,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Drawer customisedDrawer(BuildContext context) {
    double scaleWidth(double size) {
      final screenWidth = MediaQuery.of(context).size.width;
      const double baselineWidth = 412;
      return size * (screenWidth / baselineWidth);
    }

    return Drawer(
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _tosbiController.saveTosbi.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(scaleWidth(12)),
                              child: ListTile(
                                title: Text(
                                  textAlign: TextAlign.center,
                                  _tosbiController.saveTosbi[index],
                                  style: TextStyle(
                                      fontSize: scaleWidth(22),
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                title: Text(
                                                  textAlign: TextAlign.center,
                                                  "Delete_Tosbi_Text".tr,
                                                  style: TextStyle(
                                                      fontSize: scaleWidth(22),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red),
                                                ),
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          //_tosbiController.removeList(index);
                                                          _tosbiController
                                                              .saveTosbi
                                                              .removeAt(index);
                                                          _tosbiController
                                                              .listStoreData();
                                                          Get.back();
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .done_outline_rounded,
                                                          size: scaleWidth(40),
                                                          color: Colors.green,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          size: scaleWidth(40),
                                                          color: Colors.red,
                                                        ))
                                                  ],
                                                ));
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      size: scaleWidth(30),
                                      color: Colors.red,
                                    )),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                text: "Switch_Text".tr,
                                                style: TextStyle(
                                                    fontSize: scaleWidth(24),
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red),
                                                children: [
                                                  TextSpan(
                                                    text: "Switch_Warning".tr,
                                                    style: TextStyle(
                                                        fontSize:
                                                            scaleWidth(22),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: _tosbiController
                                                                    .currentTheme
                                                                    .value ==
                                                                ThemeMode.dark
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ]),
                                          ),
                                          actions: [
                                            IconButton(
                                              onPressed: () {
                                                _tosbiController
                                                    .gotoListdata(index);
                                                scaffoldKey.currentState!
                                                    .closeDrawer();
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.done_outline_rounded,
                                                size: scaleWidth(40),
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(
                                              width: scaleWidth(125),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  size: scaleWidth(40),
                                                  color: Colors.red,
                                                ))
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.teal,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Fixed at bottom
            _tosbiController.saveTosbi.length > 3
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _tosbiController.currentTheme == ThemeMode.light
                                ? Colors.teal
                                : Colors.white,
                        side: BorderSide(
                            color: Colors.teal, width: scaleWidth(2))),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text(
                                  textAlign: TextAlign.center,
                                  "Delete_Tosbi_Text2".tr,
                                  style: TextStyle(
                                      fontSize: scaleWidth(22),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _tosbiController.saveTosbi.clear();
                                          _tosbiController.listStoreData();
                                          _tosbiController.removeCountData();
                                          _tosbiController
                                              .setDisplayTosbiName("");
                                          scaffoldKey.currentState!
                                              .closeDrawer();
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.done_outline_rounded,
                                          size: scaleWidth(40),
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          size: scaleWidth(40),
                                          color: Colors.red,
                                        ))
                                  ],
                                ));
                          });
                    },
                    child: Text(
                      "DeleteAll".tr,
                      style: TextStyle(
                          fontSize: scaleWidth(20),
                          fontWeight: FontWeight.w600,
                          color:
                              _tosbiController.currentTheme == ThemeMode.light
                                  ? Colors.white
                                  : Colors.teal),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
