class Tool {
  final int toolID;
  final String toolName, description, image;
  final int amount, status;

  Tool({this.toolID, this.toolName, this.description, this.image, this.amount, this.status});

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
      toolID: json['toolID'],
      toolName: json['toolName'],
      description: json['description'],
      image: json['image'],
      amount: json['amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    "toolName": toolName,
    "description": description,
    "image": image,
    "amount": amount,
  };

}

class ToolList {
  List<Tool> toolList;

  ToolList({this.toolList});

  factory ToolList.fromJson(List<dynamic> parseJson) {

    List<Tool> tools = new List<Tool>();

    tools = parseJson.map((i) => Tool.fromJson(i)).toList();
    
    return new ToolList(
      toolList: tools
    );
  }

}