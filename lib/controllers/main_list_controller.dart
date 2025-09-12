import 'package:foodplan/models/main_list_manager.dart';
import 'package:foodplan/properties/enums/main_list_property.dart';


class MainListController {

  late final MainListManager _mainListManager;

  MainListController({required MainListManager mainListManager}){
    _mainListManager=mainListManager;
  }




  bool _isValidListId(String listId) {
    return true;
  }


  // bool _isSafeToAccessProperty(String listId, MainListProperty property) {
  //   if (_isValidListId(listId)) {
  //     if (_isPropertyInProperties(listId, property)) {
  //       return true;
  //     }
  //     throw Exception("property is not in property");
  //   }
  //   throw (Exception("list is not in box"));
  // }


  // bool _isPropertyInProperties(String listId, MainListProperty property) {
  //   if(_isValidListId(listId)){
  //     return _mainListManager.queryDbGet(listId)!.hasProperty(property);

  //   }
  //   return false;

  // }

 

   void onChangedHandler(int requiredLenght, int homeLenght, String listId) {
    if(_isValidListId(listId)&&_isValidListLenghts(requiredLenght, homeLenght)){
      try{
      _mainListManager.onChangedHandler(requiredLenght, homeLenght, listId);

      }catch(e){
        throw(Exception("Eccezione di tipo $e nel changed handler"));
      }

    }else{
      throw(Exception("Something went wrong when changing progress"));
    }
  }


  
  dynamic getProperty(String listId, MainListProperty property) {
    if(_isValidListId(listId)&& _isValidMainListProperty(property)){
      return _mainListManager.getProperty(listId, property);

    }else{
      throw(Exception("Something went wrong in get main list property"));
    }
  }

  double getListProgress(String listId) {//getter without knowing implementations, all properties should be like this
    return getProperty(listId, MainListProperty.progress);
  }
  String getTitle(String listId) {
    return getProperty(listId, MainListProperty.title);
  }



 void addMainList() {
    _mainListManager.addMainList();
  }

  void removeMainList(String removeId) {
    if(_isValidListId(removeId)){
      _mainListManager.removeMainList(removeId);
    }
  }



  void changeEditState(String listId) {
    if(_isValidListId(listId)){
      _mainListManager.changeEditState(listId);
    }
  }

  
  
 
  void renameItem(String renameId, String newTitle) {
    if(_isValidListId(renameId)&& newTitle.length<26){
      _mainListManager.renameItem(renameId, newTitle);
    }else{
      throw(Exception("renaming went wrong"));
    }
  }

  
  bool getEditStatus(String listId) {
    if(_isValidListId(listId)){
      return getProperty(listId, MainListProperty.isBeingEdited);

    }else{
      throw(Exception("getting edit status went wrong"));
    }
  }

  //TODO:refactor code in other files to use this instead of model



  
 bool _isValidListLenghts(int requiredLenght, int homeLenght){
    if(requiredLenght>=0 && homeLenght>=0 && requiredLenght+homeLenght!=0){
      return true;
    }
    return false;
  } 




  bool _isValidMainListProperty(MainListProperty property) {
    return true;
  }



}