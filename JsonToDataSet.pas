unit JsonToDataSet;
 {Alterada por Neto Félix  - 15/07/2020 - 01:44:55}
interface
uses
 System.JSON,Data.DB, System.SysUtils, REST.Response.Adapter;

type
 TJsonToDataSet = class  Helper for TDataSet
 private
 public
function JsonToDataset(aJson:String):TDataSet;
 end;

implementation
{ TJsonToDelphi }


function TJsonToDataSet.JsonToDataset(aJson:String):TDataSet;
var
FobjetoArray : TJSONArray;
FObjeto      : TJSONObject;
lValidacao   : string;
vConv        : TCustomJSONDataSetAdapter;

begin
  if (aJson = EmptyStr) then
  begin
    Exit;
  end;
  lValidacao    := Copy(aJson,0,1);
  if lValidacao = '[' then
    begin
    FobjetoArray  := System.Json.TJSONObject.ParseJSONValue(aJson) as System.JSON.TJSONArray;
    vConv         := TCustomJSONDataSetAdapter.Create(Nil);

     try
      vConv.Dataset := self;
      vConv.UpdateDataSet(FobjetoArray);
    finally
      vConv.Free;
      FobjetoArray.Free;

    end;
  end
 else
 begin
   FObjeto := System.Json.TJSONObject.ParseJSONValue(aJson) as System.JSON.TJSONObject;
   vConv   := TCustomJSONDataSetAdapter.Create(Nil);
  try
    vConv.Dataset := self;
    vConv.UpdateDataSet(FObjeto);
  finally
    vConv.Free;
    FObjeto.Free;
  end;

 end;
end;

end.
