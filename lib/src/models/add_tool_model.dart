class AddToolModel {
  final String toolName, description, image;
  final int amount;

  AddToolModel({this.toolName, this.description, this.amount, this.image});

  Map<String, dynamic> toJson() => {
    "ToolName": toolName,
    "Description": description,
    "Image": image,
    "Amount": amount,
  };
}