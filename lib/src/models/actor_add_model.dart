class AddActorModel {
  final String username, password, fullName, sex, image, description, phone, email, dob, createOnDT;
  final int isAdmin, status;

  AddActorModel({
   this.username,
   this.password,
   this.fullName,
   this.sex,
   this.image,
   this.description,
   this.phone,
   this.email,
   this.dob,
    this.createOnDT,
   this.isAdmin,
   this.status
  });

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
    "FullName": fullName,
    "Sex": sex,
    "Image": image,
    "Description": description,
    "Phone": phone,
    "Email": email,
    "DOB": dob,
    "CreateOnDT": createOnDT,
    "IsAdmin": 0,
    "Status": 1
  };

}