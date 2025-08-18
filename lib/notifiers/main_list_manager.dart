import 'package:foodplan/components/mainlist.dart';
import 'package:foodplan/notifiers/editable.dart';

import 'package:foodplan/properties/main_list_properties.dart';
import 'package:foodplan/properties/main_list_property.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager extends Editable {
  final List<MainList> _mainListPages = [MainList(id: uuid.v4())];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  String defaultTitle = "Nuova Lista";
  double progressOfNewList = 0;
  bool defaultEditState =
      true; //defualt edit state true but is startUpEditState for startup list
  bool startupEditState = false;
  String startupTitle = "Supermercato";
  final Map<String, MainListProperties> _mainListProperties = {};

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

  void _initProperties() {
    for (int i = 0; i < mainListPages.length; i++) {
      _mainListProperties[_mainListPages[i].id] = MainListProperties(
        title: startupTitle, //special title for the list thats already present
        progress: progressOfNewList,
        isBeingEdited:
            startupEditState, //the list thats already there has a special value since we dont want to start the app having to rename it
      );
    }
  }

  String get selectedId => _selectedId;

  bool _isListInProperties(String listId) {
    if (_mainListProperties.containsKey(listId)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPropertyInProperties(String listId, MainListProperty property) {
    //assumes listId is in properties
    return _mainListProperties[listId]!.hasProperty(property);
  }

  bool _isSafeToAccessProperty(String listId, MainListProperty property) {
    if (_isListInProperties(listId)) {
      if (_isPropertyInProperties(listId, property)) {
        return true;
      } else {
        throw ArgumentError("property given is not in properties");
      }
    } else {
      throw ArgumentError("id is not in properties");
    }
  }

  void _setProperty(String listId, MainListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      _mainListProperties[listId]!.setProperty(property, value);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic getProperty(String listId, MainListProperty property) {
    if (_isSafeToAccessProperty(listId, property)) {
      return _mainListProperties[listId]!.getProperty(property);
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
    _mainListProperties.remove(listId);
  }

  void _addProperties(String listId) {
    _mainListProperties[listId] = MainListProperties(
      title: defaultTitle,
      progress: progressOfNewList,
      isBeingEdited: defaultEditState,
    );
  }

  void addMainList() {
    String generatedId = uuid.v4();

    _mainListPages.insert(
      //inserisco nella lista
      _mainListPages.length,
      MainList(id: generatedId, givenTitle: defaultTitle),
    );
    _addProperties(
      generatedId,
    ); //aggiungo le proprieta' relative alla lista alla mappa (un nuovo oggetto MainListProperties)

    notifyListeners();
  }

  void removeMainList(String removeId) {
    _mainListPages.removeWhere((mainlist) => mainlist.id == removeId);
    _removeProperties(removeId);
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
