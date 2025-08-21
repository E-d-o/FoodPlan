import 'package:foodplan/components/mainlist.dart';
import 'package:foodplan/managers/editable.dart';

import 'package:foodplan/models/main_list_properties.dart';
import 'package:foodplan/models/enums/main_list_property.dart';
import 'package:hive/hive.dart';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager extends Editable {
  final List<MainList> _mainListPages = [];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  String defaultTitle = "Nuova Lista";
  double progressOfNewList = 0;
  bool defaultEditState =
      true; //defualt edit state true but is startUpEditState for startup list
  bool startupEditState = false;
  String startupTitle = "Supermercato";

  final _box = Hive.box("storage"); //is Map String, MainlistProperties

  set selectedId(String myId) {
    if (myId.isNotEmpty) {
      _selectedId = myId;
    } else {
      throw ArgumentError("The id given is empty");
    }
  }

  MainListManager() {
    _initProperties();
  }

  void _initProperties() async {
    await _loadExistingLists();
  }

  Future<void> _loadExistingLists() async {
    if (_box.isEmpty) {
      print("box vuota, creo prima lista");
      MainList firstList = MainList(id: uuid.v4());
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
      print("carico liste esistenti, sono: ${_box.length}");
      await _loadHiveLists();
    }
  }

  Future<void> _loadHiveLists() async {
    _mainListPages.clear();

    final Map<DateTime, String> timestampToId = {};
    for (var key in _box.keys) {
      MainListProperties properties = _box.get(key);

      timestampToId[properties.timeOfAddition] = key.toString();
    }
    List<DateTime> timestamps = timestampToId.keys.toList();
    timestamps.sort();
    print(timestamps.toString());

    for (var time in timestamps) {
      String? id = timestampToId[time];
      MainList mainList = MainList(id: id.toString());

      _mainListPages.add(mainList);

      print("aggiunta lista con timestamp $time");
    }

    print("fine loading");
  }

  String get selectedId => _selectedId;

  bool _isListInProperties(String listId) {
    if (_box.containsKey(listId)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPropertyInProperties(String listId, MainListProperty property) {
    //assumes listId is in properties
    return _box.get(listId)!.hasProperty(property);
  }

  bool _isSafeToAccessProperty(String listId, MainListProperty property) {
    if (_isListInProperties(listId)) {
      if (_isPropertyInProperties(listId, property)) {
        return true;
      }
      throw Exception("property is not in property");
    }
    throw (Exception("list is not in box"));
  }

  void _setProperty(String listId, MainListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      MainListProperties properties = _box.get(listId);
      properties.setProperty(property, value);
      _box.put(listId, properties);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic getProperty(String listId, MainListProperty property) {
    if (_isSafeToAccessProperty(listId, property)) {
      return _box.get(listId)!.getProperty(property);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
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

  double getListProgress(String listId) {
    return getProperty(listId, MainListProperty.progress);
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

  void addMainList() {
    String generatedId = uuid.v4();
    MainList newList = MainList(id: generatedId, givenTitle: defaultTitle);
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
