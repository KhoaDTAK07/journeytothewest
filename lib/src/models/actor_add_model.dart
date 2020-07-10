class AddActorModel {
  final String username, password, fullName, sex, image, description, phone, email, dob;
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
    "IsAdmin": 0,
    "Status": 1
  };

}