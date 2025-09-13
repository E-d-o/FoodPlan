import 'package:foodplan/components/editable.dart';
import 'package:foodplan/models/main_list_manager.dart';
import 'package:foodplan/properties/enums/main_list_property.dart';


class MainListController with Editable {

  late final MainListManager _mainListManager;

  MainListController({required MainListManager mainListManager}){
    _mainListManager=mainListManager;
  }



   void onChangedHandler(int requiredLenght, int homeLenght, String listId) {
    _checkPresentListId(listId);
    _checkValidListLenghts(requiredLenght, homeLenght);
    _mainListManager.onChangedHandler(requiredLenght, homeLenght, listId);
    
  }


  
  dynamic getProperty(String listId, MainListProperty property) {
    _checkValidMainListProperty(property);
    _checkPresentListId(listId);
    return _mainListManager.getProperty(listId, property);
      

    
  }

  double getListProgress(String listId) {//getter without knowing implementations, all properties should be like this
    return getProperty(listId, MainListProperty.progress);
  }
 


 void addMainList() {
    _mainListManager.addMainList();
  }

  void removeMainList(String removeId) {
    _checkPresentListId(removeId);
     _mainListManager.removeMainList(removeId);
  }

    
  
  //only check for valid list id, throws when not valid
  void _checkPresentListId(String listId) {
    if(!_mainListManager.containsListId(listId)){
      throw(ArgumentError.value(listId,"listId" ,"listId is not in Db"));
    }
  }

  

   void _checkValidListLenghts(int requiredLenght, int homeLenght){
   
      if(requiredLenght<0){
        throw(ArgumentError.value(requiredLenght, "requiredLenght","is negative"));
      }
      if(homeLenght<0){
        throw(ArgumentError.value(homeLenght, "homeLenght","is negative"));
      }
      if(requiredLenght+homeLenght==0){
        throw(ArgumentError.value([requiredLenght,homeLenght], "requiredLenght, homeLenght","are both 0"));
      }
    }
   




  void _checkValidMainListProperty(MainListProperty property) {
    
  }

void _checkValidTitle(String newTitle) {
  if(newTitle.length>26){
    throw(ArgumentError.value(newTitle,"newTitle","is too long, exceeds 26 chars"));
  }
}

 @override
  String getTitle(String listId) {

    return getProperty(listId, MainListProperty.title);//get property perfomes validation
  }


  @override
  void changeEditState(String listId) {
    _checkPresentListId(listId);
     _mainListManager.changeEditState(listId);
    
  }

 
  @override
  void renameItem(String renameId, String newTitle) {
    _checkPresentListId(renameId);
    _checkValidTitle(newTitle);
     _mainListManager.renameItem(renameId,newTitle);
  }

  
  @override
  bool getEditStatus(String listId) {
    _checkPresentListId(listId);
    return _mainListManager.getEditStatus(listId);
  }
  
  
//TODO: crash on rename item when clicked
 



  




}