import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';
import 'package:foodplan/components/editable.dart';
import 'package:foodplan/models/settings_manager.dart';
import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/properties/main_list_properties.dart';
import 'package:foodplan/properties/enums/main_list_property.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager extends Editable with ChangeNotifier{
  final List<MainList> _mainListPages = [];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  String defaultTitle = "Nuova Lista";
  double progressOfNewList = 0;
  bool defaultEditState = true; //defualt edit state true but is startUpEditState for startup list
  bool startupEditState = false;
  String startupTitle = "Supermercato";
  final SettingsManager settingsManager;
  final _box = Hive.box("mainlist"); //is Map String, MainlistProperties

  set selectedId(String myId) {
    if (myId.isNotEmpty) {
      _selectedId = myId;
    } else {
      throw ArgumentError("The id given is empty");
    }
  }

  MainListManager({required this.settingsManager}) {
    _initProperties();
  }
  SingleListManager createSingleListManager(Box box, String listId) {
    //SingleListManager depends on Mainlist, used to pass function and its values back to Mainlistmanager, there probably is a better way

    return SingleListManager(
      box: box,
      settingsManager: settingsManager,
      mainListManager: this,
      mainListId: listId,
    );
  }




  void _initProperties() async {
    await _loadExistingLists();
  }


  String get selectedId => _selectedId;

  dynamic queryDbGet(String listId) {
    
    return _box.get(listId);     
    
  }


  bool containsListId(String listId){
    return _box.containsKey(listId);
  }
 

  void onChangedHandler(int requiredLenght, int homeLenght, String listId) {
    _setListsLenghts(requiredLenght, homeLenght, listId);
    double value = homeLenght / (requiredLenght + homeLenght);
    _setProgress(listId, value);
  }


  dynamic getProperty(String listId, MainListProperty property) {
    return _box.get(listId)!.getProperty(property);
  }


  
  void addMainList() {
    String generatedId = uuid.v4();
    MainList newList = MainList(
      id: generatedId,
      givenTitle: defaultTitle,
      nameOfBox: generatedId,
    );
    _mainListPages.insert(
      //inserisco nella lista
      _mainListPages.length,
      newList,
    );
    _addProperties(
      generatedId,
    ); //aggiungo le proprieta' relative alla lista alla mappa (un nuovo oggetto MainListProperties)

    notifyListeners();
  }

  void removeMainList(String removeId) {
    _mainListPages.removeWhere((mainlist) => mainlist.id == removeId);
    _removeProperties(removeId);
    _box.delete(removeId);
    notifyListeners();
  }

 


   void _setProgress(String listId, double value) {
    _setProperty(listId, MainListProperty.progress, value);
    notifyListeners();
  }

  void _setProperty(String listId, MainListProperty property, dynamic value) {
    MainListProperties properties = _box.get(listId);
    properties.setProperty(property, value);
    _box.put(listId, properties);
  }

  void _addNewTitle(String listId, String newTitle) {
    _setProperty(listId, MainListProperty.title, newTitle);
  }

  void _removeProperties(String listId) {
    _box.delete(listId);
  }

  void _addProperties(String listId) {
    _box.put(
      listId,
      MainListProperties(
        title: defaultTitle,
        progress: progressOfNewList,
        isBeingEdited: defaultEditState,
        timeOfAddition: DateTime.timestamp(),
      ),
    );
  }

  void _setListsLenghts(int requiredLenght, int homeLenght, String listId) {
    _setProperty(listId, MainListProperty.requiredLenght, requiredLenght);
    _setProperty(listId, MainListProperty.homeLenght, homeLenght);
  }

  Future<void> _loadExistingLists() async {
    if (_box.isEmpty) {
      // ignore: avoid_print
      print("box vuota, creo prima lista");
      String id = uuid.v4();
      MainList firstList = MainList(id: id, nameOfBox: id);
      _box.put(
        firstList.id,
        MainListProperties(
          title: startupTitle,
          progress: progressOfNewList,
          isBeingEdited: startupEditState,
          timeOfAddition: DateTime.timestamp(),
        ),
      );
      _mainListPages.add(firstList);
    } else {
      // ignore: avoid_print
      print("carico liste esistenti, sono: ${_box.length}");
      await _loadHiveLists();
    }
  }

  Future<void> _loadHiveLists() async {
    _mainListPages.clear();

    final Map<DateTime, String> timestampToId = {};
    final List<String> nameOfBoxes = [];
    for (var key in _box.keys) {
      MainListProperties properties = _box.get(key);
      nameOfBoxes.add(key);
      timestampToId[properties.timeOfAddition] = key.toString();
    }
    List<DateTime> timestamps = timestampToId.keys.toList();
    timestamps.sort();

    int i = 0;
    for (var time in timestamps) {
      String? id = timestampToId[time];
      MainList mainList = MainList(
        id: id.toString(),
        nameOfBox: nameOfBoxes[i],
      );

      _mainListPages.add(mainList);
      i += 1;
    }
  }

  @override
  void changeEditState(String listId) {
    bool oldValue = getProperty(listId, MainListProperty.isBeingEdited);
    _setProperty(listId, MainListProperty.isBeingEdited, !oldValue);
    notifyListeners();
  }

  @override
  String getTitle(String listId) {
    return getProperty(listId, MainListProperty.title);
  }

  @override
  void renameItem(String renameId, String newTitle) {
    changeEditState(renameId);
    _addNewTitle(renameId, newTitle);
    notifyListeners();
  }

  @override
  bool getEditStatus(String listId) {
    return getProperty(listId, MainListProperty.isBeingEdited);
  }
}


