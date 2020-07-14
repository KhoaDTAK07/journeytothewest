class UpdateActorModel {
  final String username, fullName, sex, image, description, phone, email, dob, updateBy, updateOnDT;
  final int isAdmin, status;

  UpdateActorModel({
    this.username,
    this.fullName,
    this.sex,
    this.image,
    this.description,
    this.phone,
    this.email,
    this.dob,
    this.updateBy,
    this.updateOnDT,
    this.isAdmin,
    this.status
  });

  Map<String, dynamic> toJson() => {
    "Username": username,
    "FullName": fullName,
    "Sex": sex,
    "Image": image,
    "Description": description,
    "Phone": phone,
    "Email": email,
    "DOB": dob,
    "UpdateBy": updateBy,
    "updateOnDT": updateOnDT,
    "IsAdmin": 0,
    "Status": 1
  };

}