class AddShoppingCart2Model {
  final int scenarioID, toolID, amount,status;
  final String  CreateOnDt;

  AddShoppingCart2Model({this.scenarioID, this.toolID, this.amount, this.CreateOnDt, this.status});

  Map<String, dynamic> toJson() => {
    "ScenarioId": scenarioID,
    "ToolId": toolID,
    "Amount": amount,
    "CreateOnDt": CreateOnDt,
    "Status": 1
  };
}