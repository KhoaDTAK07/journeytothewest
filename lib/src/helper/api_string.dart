class APIString {

  static String apiLogin() {
    String url = "http://prmapi.azurewebsites.net/api/login";
    return url;
  }

  //-------------------- API Actor ----------------------------------
  static String apiGetAllActor() {
    String url = "http://prmapi.azurewebsites.net/api/Actor/getall";
    return url;
  }

  static String apiGetActorDetailByUsername() {
    String url = "http://prmapi.azurewebsites.net/api/Actor/";
    return url;
  }

  static String apiGetActorByName() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  static String apiAddActor() {
    String url = "http://prmapi.azurewebsites.net/api/Actor";
    return url;
  }

  static String apiUpdateActor() {
    String url = "http://prmapi.azurewebsites.net/api/Actor";
    return url;
  }

  static String apiDeleteActor() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  //-------------------- API Tool ----------------------------------
  static String apiGetAllTool() {
    String url = "http://prmapi.azurewebsites.net/api/Tools/getall";
    return url;
  }

  static String apiGetToolByName() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  static String apiGetToolDetail() {
    String url = "http://prmapi.azurewebsites.net/api/Tools/";
    return url;
  }

  static String apiAddTool() {
    String url = "http://prmapi.azurewebsites.net/api/Tools";
    return url;
  }

  static String apiUpdateTool() {
    String url = "http://prmapi.azurewebsites.net/api/Tools/";
    return url;
  }

  static String apiDeleteTool() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  //-------------------- API Scenario ----------------------------------
  static String apiGetAllScenario() {
    String url = "http://prmapi.azurewebsites.net/api/Scenario/getall";
    return url;
  }

  static String apiGetScenarioByName() {
    String url = "prmapi.azurewebsites.net";
    return url;
}

  static String apiGetScenarioDetail() {
    String url = "http://prmapi.azurewebsites.net/api/Scenario/";
    return url;
  }

  static String apiAddScenario() {
    String url = "http://prmapi.azurewebsites.net/api/Scenario";
    return url;
  }

  static String apiUpdateScenario() {
    String url = "http://prmapi.azurewebsites.net/api/Scenario/";
    return url;
  }

  static String apiDeleteScenario() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }


  //-------------------- API Shopping Cart1 ----------------------------------
  static String apiGetAllShoppingCart1ByScenarioID() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  static String apiAddActorToCart() {
    String url = "http://prmapi.azurewebsites.net/api/ActorScenarioDetail";
    return url;
  }

  static String apiDeleteActorFromCart() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  //-------------------- API Shopping Cart2 ----------------------------------
  static String apiGetAllShoppingCart2ByScenarioID() {
    String url = "prmapi.azurewebsites.net";
    return url;
  }

  static String apiAddToolToScenario() {
    String url = "http://prmapi.azurewebsites.net/api/ToolScenarioDetail";
    return url;
  }

}