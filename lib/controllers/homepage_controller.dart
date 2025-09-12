import 'package:foodplan/models/homepage_manager.dart';

class HomepageController {
  late final  HomepageManager _homepageManager;
  HomepageController({required HomepageManager homepageManager}){
    _homepageManager=homepageManager;
  }
    

  
  void scrollToTop(){
    
    _homepageManager.scrollToTop();
  }
}