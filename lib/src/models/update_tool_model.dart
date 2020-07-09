class UpdateToolModel {
  final String toolName, description, image;
  final int toolID, amount;

  UpdateToolModel({this.toolID, this.toolName, this.description, this.amount, this.image});

  Map<String, dynamic> toJson() => {
    "ToolID": toolID,
    "ToolName": toolName,
    "Description": description,
    "Image": image,
    "Amount": amount,
    "Status": 1
  };
}