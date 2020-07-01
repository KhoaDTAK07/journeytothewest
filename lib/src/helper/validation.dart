class Validation {

  static String validateUsername(String username) {
    if(username == null){
      return "Username can't be blank";
    } else if (username.length < 6) {
      return "Username require minimum 6 characters";
    } else
      return null;
  }

  static String validatePassword(String password) {
    if(password == null){
      return "Password can't be blank";
    } else if (password.length < 6) {
      return "Password require minimum 6 characters";
    } else
      return null;
  }

}