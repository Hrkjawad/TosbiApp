import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tosbi/languages.dart';

class TosbiController extends GetxController {
  RxString displayName = "".obs;
  RxList<String> saveTosbi = <String>[].obs;
  RxInt count = 0.obs;
  final memory = GetStorage();

  @override
  void onInit(){
    super.onInit();
    seeCountData();
    seeListData();
    setLanguage();
    setTheme();
    displayTosbiName();
  }

  void setDisplayTosbiName(String name){
    memory.write("displayTosbiName", displayName.value = name.toString());
  }
  void displayTosbiName(){
    final displayDisplayName = memory.read<String>("displayTosbiName");
    if(displayDisplayName != null){
      displayName.value = displayDisplayName;
    }
  }


  String numberFontChange(String number) {
    return number.split('').map((e) => Languages().engToBangla[e] ?? e).join();
  }
  String get banglaCount => numberFontChange(count.value.toString());

  void tosbiCount() async {
    count++;
    countStoreData();
  }
  void tosbiCountDecrease() async {
    if(count > 0){
      count--;
      countStoreData();
    }
  }
  void countStoreData(){
    memory.write("count", count.value);
  }
  void seeCountData() {
    final storedCount = memory.read("count");
    if (storedCount != null) {
      count.value = storedCount;
    }
  }
  void removeCountData() {
    count.value = 0;
    countStoreData();
  }
  void removeList(index){
    int listCount = int.parse(saveTosbi[index].split(':')[1]), currentCount =  count.value;
    String currentDisplayTosbiName = displayName.value, listTosbiName = saveTosbi[index].split(":")[0].toString();
    if( listTosbiName == currentDisplayTosbiName  || listCount == currentCount ){
      displayName.value = "";
      setDisplayTosbiName("");
      removeCountData();
      removeFromTosbiList(index);
      Get.back();
    }
    removeFromTosbiList(index);
    Get.back();
  }
  void gotoListdata(index){
   // displayName.value =  saveTosbi[index].split(" : ")[0];
    count.value =  int.parse(saveTosbi[index].split(' : ')[1]);
    setDisplayTosbiName(saveTosbi[index].split(" : ")[0]);
    countStoreData();
  }

  Rx<ThemeMode> currentTheme = ThemeMode.light.obs;
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    memory.write("theme", currentTheme.value.toString().split('.').last);
  }
  void setTheme() {
    final storedTheme = memory.read<String>("theme");
    if (storedTheme != null) {
      switch (storedTheme) {
        case "light":
          currentTheme.value = ThemeMode.light;
          break;
        case "dark":
          currentTheme.value = ThemeMode.dark;
          break;
      }
    }
  }


  Rx<Locale> language = const Locale("bn", "BD").obs;
  void switchLanguage() {
    language.value = language.value == const Locale("bn", "BD")
        ? const Locale("en", "US")
        : const Locale("bn", "BD");
    memory.write("language", language.value.toLanguageTag());
  }
  void setLanguage() {
    final storedLanguage = memory.read<String>("language");
    if (storedLanguage != null) {
      final parts = storedLanguage.split('-');
      language.value = Locale(parts[0], parts.length > 1 ? parts[1] : '');
    }
  }

  RxBool isDrawerOpen = false.obs;
  void setDrawerState(bool isOpen) {
    isDrawerOpen.value = isOpen;
  }



  void addToTosbiList(String item) {
    saveTosbi.add(item);
    listStoreData();
  }
  void listStoreData() {
    memory.write("saveTosbis", saveTosbi.toList());
  }
  void seeListData() {
    final storeList = memory.read<List<dynamic>>("saveTosbis");
    if (storeList != null) {
      saveTosbi.value = List<String>.from(storeList);
    }
  }
  void removeFromTosbiList(index) {
    saveTosbi.removeAt(index);
    listStoreData();
  }




}
