codeunit 50029 "Json Mgt"
{

    trigger OnRun()
    begin
    end;

    //     var
    //         StringBuilder: DotNet StringBuilder;
    //         StringWriter: DotNet StringWriter;
    //         JsonTextWriter: DotNet JsonTextWriter;
    //         JsonTextReader: DotNet JsonTextReader;
    //         EwaySetup: Record "E_Invoice Setup";

    //     procedure Initialize()
    //     var
    //         Formatting: DotNet Formatting;
    //     begin
    //         StringBuilder := StringBuilder.StringBuilder;
    //         StringWriter := StringWriter.StringWriter(StringBuilder);
    //         JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
    //         JsonTextWriter.Formatting := Formatting.Indented;
    //     end;

    //     [Scope('Internal')]
    //     procedure StartJSon()
    //     begin
    //         IF ISNULL(StringBuilder) THEN
    //             Initialize;
    //         JsonTextWriter.WriteStartObject;
    //     end;

    //     [Scope('Internal')]
    //     procedure StartJSonArray()
    //     begin
    //         IF ISNULL(StringBuilder) THEN
    //             Initialize;
    //         JsonTextWriter.WriteStartArray;
    //     end;

    //     [Scope('Internal')]
    //     procedure AddJSonBranch(BranchName: Text)
    //     begin
    //         JsonTextWriter.WritePropertyName(BranchName);
    //         StringWriter.Write('[');
    //         JsonTextWriter.WriteStartObject;
    //     end;

    //     [Scope('Internal')]
    //     procedure AddToJSon(VariableName: Text; Variable: Variant)
    //     begin
    //         JsonTextWriter.WritePropertyName(VariableName);
    //         JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
    //     end;

    //     [Scope('Internal')]
    //     procedure EndJSonBranch()
    //     begin
    //         JsonTextWriter.WriteEndObject;
    //         StringWriter.Write(']');
    //     end;

    //     [Scope('Internal')]
    //     procedure EndJSonArray()
    //     begin
    //         JsonTextWriter.WriteEndArray;
    //     end;

    //     [Scope('Internal')]
    //     procedure EndJSon()
    //     begin
    //         JsonTextWriter.WriteEndObject;
    //     end;

    //     [Scope('Internal')]
    //     procedure GetJSon() JSon: Text
    //     begin
    //         JSon := StringBuilder.ToString;
    //         Initialize;
    //     end;

    //     [Scope('Internal')]
    //     procedure ReadJSon(var String: DotNet String; var TempPostingExchField: Record "50097" temporary)
    //     var
    //         PrefixArray: DotNet Array;
    //         PrefixString: DotNet String;
    //         PropertyName: Text;
    //         ColumnNo: Integer;
    //         InArray: array[250] of Boolean;
    //         JsonToken: DotNet JsonToken;
    //         StringReader: DotNet StringReader;
    //     begin
    //         PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 1250);
    //         StringReader := StringReader.StringReader(String); //moved from global to local
    //         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
    //         WHILE JsonTextReader.Read DO
    //             CASE TRUE OF
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
    //                     BEGIN
    //                         InArray[JsonTextReader.Depth + 1] := TRUE;
    //                         ColumnNo := 0;
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
    //                     BEGIN
    //                         PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
    //                         IF JsonTextReader.Depth > 1 THEN BEGIN
    //                             PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
    //                             IF PrefixString.Length > 0 THEN
    //                                 PropertyName := PrefixString.ToString + '.' + FORMAT(JsonTextReader.Value, 0, 9)
    //                             ELSE
    //                                 PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
    //                         END ELSE
    //                             PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
    //                     BEGIN
    //                         //IF NOT TempPostingExchField.GET(JsonTextReader.Depth,JsonTextReader.LineNumber,ColumnNo,PropertyName) THEN BEGIN
    //                         TempPostingExchField.INIT;
    //                         TempPostingExchField."Data Exch. No." := JsonTextReader.Depth;
    //                         TempPostingExchField."Line No." := JsonTextReader.LineNumber;
    //                         TempPostingExchField."Column No." := ColumnNo;
    //                         TempPostingExchField."Node ID" := PropertyName;
    //                         TempPostingExchField."Line Position" := JsonTextReader.LinePosition;
    //                         //MESSAGE('PropertyName = %1\\Value = %2',PropertyName,FORMAT(JsonTextReader.Value,0,9));
    //                         TempPostingExchField.Value := COPYSTR(FORMAT(JsonTextReader.Value, 0, 9), 1, 250);
    //                         TempPostingExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
    //                         TempPostingExchField."Entry No." := TempPostingExchField."Entry No." + 1;
    //                         TempPostingExchField.INSERT;
    //                         //END;
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
    //                     InArray[JsonTextReader.Depth + 1] := FALSE;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
    //                     IF JsonTextReader.Depth > 0 THEN
    //                         IF InArray[JsonTextReader.Depth] THEN ColumnNo += 1;
    //             END;
    //     end;

    //     [Scope('Internal')]
    //     procedure ReadFirstJSonValue(var String: DotNet String; ParameterName: Text) ParameterValue: Text
    //     var
    //         PropertyName: Text;
    //         JsonToken: DotNet JsonToken;
    //         StringReader: DotNet StringReader;
    //     begin
    //         StringReader := StringReader.StringReader(String);
    //         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
    //         WHILE JsonTextReader.Read DO
    //             CASE TRUE OF
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
    //                     PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
    //                 (PropertyName = ParameterName) AND NOT ISNULL(JsonTextReader.Value):
    //                     BEGIN
    //                         ParameterValue := FORMAT(JsonTextReader.Value, 0, 9);
    //                         EXIT;
    //                     END;
    //             END;
    //     end;

    //     [Scope('Internal')]
    //     procedure DownloadString(Url: Text; UserName: Text; Password: Text): Text
    //     var
    //         WebClient: DotNet WebClient;
    //         Credential: DotNet NetworkCredential;
    //     begin
    //         Credential := Credential.NetworkCredential;
    //         Credential.UserName := UserName;
    //         Credential.Password := Password;

    //         WebClient := WebClient.WebClient;
    //         WebClient.Credentials := Credential;
    //         EXIT(WebClient.DownloadString(Url));
    //     end;

    //     [Scope('Internal')]
    //     procedure CreateWebRequest(var HttpWebRequest: DotNet HttpWebRequest; WebServiceURL: Text; Method: Text)
    //     var
    //         ServicePointManager: DotNet ServicePointManager;
    //         SecurityProtocolType: DotNet SecurityProtocolType;
    //     begin
    //         EwaySetup.GET;
    //         HttpWebRequest := HttpWebRequest.Create(WebServiceURL);
    //         ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;//TL12

    //         HttpWebRequest.Method := Method;
    //         HttpWebRequest.KeepAlive := TRUE;
    //         HttpWebRequest.Timeout := 500000;
    //         HttpWebRequest.ContentType('application/json');
    //         HttpWebRequest.Headers.Add('companyId:' + EwaySetup."Company ID");
    //         HttpWebRequest.Headers.Add('X-Auth-Token:' + EwaySetup.Password1 + EwaySetup.Password2);
    //         HttpWebRequest.Headers.Add('product: ONYX');



    //         //HttpWebRequest.Headers.Add('companyid:'+EwaySetup."Company ID");
    //         //HttpWebRequest.Headers.Add('product:'+'TOPAZ');
    //     end;

    //     [Scope('Internal')]
    //     procedure CreateCredentials(var HttpWebRequest: DotNet HttpWebRequest; UserName: Text; Password: Text)
    //     var
    //         Credential: DotNet NetworkCredential;
    //     begin
    //         Credential := Credential.NetworkCredential;
    //         Credential.UserName := UserName;
    //         Credential.Password := Password;
    //         HttpWebRequest.Credentials := Credential;
    //     end;

    //     [Scope('Internal')]
    //     procedure SetRequestStream(var HttpWebRequest: DotNet HttpWebRequest; var String: DotNet String)
    //     var
    //         StreamWriter: DotNet StreamWriter;
    //         Encoding: DotNet Encoding;
    //     begin
    //         StreamWriter := StreamWriter.StreamWriter(HttpWebRequest.GetRequestStream, Encoding.GetEncoding('iso8859-1'));
    //         StreamWriter.Write(String);
    //         StreamWriter.Close;
    //     end;

    //     [Scope('Internal')]
    //     procedure DoWebRequest(var HttpWebRequest: DotNet HttpWebRequest; var HttpWebResponse: DotNet WebResponse; IgnoreCode: Code[10])
    //     var
    //         NAVWebRequest: DotNet NAVWebRequest;
    //         HttpWebException: DotNet WebException;
    //         HttpWebRequestError: Label 'Error: %1\%2';
    //     begin
    //         NAVWebRequest := NAVWebRequest.NAVWebRequest;
    //         IF NOT NAVWebRequest.doRequest(HttpWebRequest, HttpWebException, HttpWebResponse) THEN
    //             IF (IgnoreCode = '') OR (STRPOS(HttpWebException.Message, IgnoreCode) = 0) THEN
    //                 ERROR(HttpWebRequestError, HttpWebException.Status.ToString, HttpWebException.Message);
    //     end;

    //     [Scope('Internal')]
    //     procedure GetResponseStream(var HttpWebResponse: DotNet WebResponse; var String: DotNet String)
    //     var
    //         StreamReader: DotNet StreamReader;
    //         MemoryStream: DotNet MemoryStream;
    //     begin
    //         StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
    //         String := StreamReader.ReadToEnd;
    //     end;

    //     [Scope('Internal')]
    //     procedure GetValueFromJsonString(var String: DotNet String; ParameterName: Text): Text
    //     var
    //         TempPostingExchField: Record "50097";
    //     begin
    //         ReadJSon(String, TempPostingExchField);
    //         EXIT(GetJsonValue(TempPostingExchField, ParameterName));
    //     end;

    //     [Scope('Internal')]
    //     procedure GetJsonValue(var TempPostingExchField: Record "50097" temporary; ParameterName: Text): Text
    //     begin
    //         WITH TempPostingExchField DO BEGIN
    //             SETRANGE("Node ID", ParameterName);
    //             IF FINDFIRST THEN EXIT(Value);
    //         END;
    //     end;

    //     [Scope('Internal')]
    //     procedure AddDecToJSon(VariableName: Text; Variable: Variant)
    //     begin
    //         JsonTextWriter.WritePropertyName(VariableName);
    //         JsonTextWriter.WriteValue(Variable);
    //     end;

    //     [Scope('Internal')]
    //     procedure AddNullToJSon(VariableName: Text)
    //     begin
    //         JsonTextWriter.WritePropertyName(VariableName);
    //         JsonTextWriter.WriteRawValue('null');
    //     end;

    //     [Scope('Internal')]
    //     procedure CreateWebRequest2(var HttpWebRequest: DotNet HttpWebRequest; WebServiceURL: Text; Method: Text)
    //     var
    //         ServicePointManager: DotNet ServicePointManager;
    //         SecurityProtocolType: DotNet SecurityProtocolType;
    //     begin
    //         EwaySetup.GET;
    //         HttpWebRequest := HttpWebRequest.Create(WebServiceURL);
    //         ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;//TL12
    //         HttpWebRequest.Method := Method;
    //         HttpWebRequest.KeepAlive := TRUE;
    //         HttpWebRequest.Timeout := 30000;
    //         //HttpWebRequest.Accept('application/json');
    //         //HttpWebRequest.Accept('application/json');
    //         HttpWebRequest.ContentType('application/json');
    //         //HttpWebRequest.Headers.Add('content-type:application/json');
    //         //HttpWebRequest.Headers.Add(EwaySetup."Admin Token Type"+EwaySetup."Admin Personal Token");
    //     end;

    //     [Scope('Internal')]
    //     procedure UploadJSon2(WebServiceURL: Text; var String: DotNet String; Method: Text)
    //     var
    //         HttpWebRequest: DotNet HttpWebRequest;
    //         HttpWebResponse: DotNet WebResponse;
    //     begin
    //         CreateWebRequest2(HttpWebRequest, WebServiceURL, Method);
    //         SetRequestStream(HttpWebRequest, String);
    //         DoWebRequest(HttpWebRequest, HttpWebResponse, '');
    //         GetResponseStream(HttpWebResponse, String);
    //     end;

    //     [Scope('Internal')]
    //     procedure UploadJSon(WebServiceURL: Text; var String: DotNet String; Method: Text)
    //     var
    //         HttpWebRequest: DotNet HttpWebRequest;
    //         HttpWebResponse: DotNet WebResponse;
    //     begin
    //         CreateWebRequest(HttpWebRequest, WebServiceURL, Method);
    //         SetRequestStream(HttpWebRequest, String);
    //         DoWebRequest(HttpWebRequest, HttpWebResponse, '');
    //         GetResponseStream(HttpWebResponse, String);
    //     end;

    //     [Scope('Internal')]
    //     procedure ReadJSon2(var String: DotNet String; var TempPostingExchField: Record "50097" temporary)
    //     var
    //         PrefixArray: DotNet Array;
    //         PrefixString: DotNet String;
    //         PropertyName: Text;
    //         ColumnNo: Integer;
    //         InArray: array[250] of Boolean;
    //         JsonToken: DotNet JsonToken;
    //         StringReader: DotNet StringReader;
    //     begin
    //         PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 1250);
    //         StringReader := StringReader.StringReader(String); //moved from global to local
    //         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
    //         WHILE JsonTextReader.Read DO
    //             CASE TRUE OF
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
    //                     BEGIN
    //                         InArray[JsonTextReader.Depth + 1] := TRUE;
    //                         ColumnNo := 0;
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
    //                     BEGIN
    //                         PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
    //                         IF JsonTextReader.Depth > 1 THEN BEGIN
    //                             PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
    //                             IF PrefixString.Length > 0 THEN
    //                                 PropertyName := PrefixString.ToString + '.' + FORMAT(JsonTextReader.Value, 0, 9)
    //                             ELSE
    //                                 PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
    //                         END ELSE
    //                             PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
    //                     BEGIN
    //                         TempPostingExchField."Data Exch. No." := JsonTextReader.Depth;
    //                         TempPostingExchField."Line No." := JsonTextReader.LineNumber;
    //                         TempPostingExchField."Column No." := ColumnNo;
    //                         TempPostingExchField."Node ID" := PropertyName;
    //                         TempPostingExchField.Value := FORMAT(JsonTextReader.Value, 0, 9);
    //                         TempPostingExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
    //                         TempPostingExchField.INSERT;
    //                     END;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
    //                     ;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
    //                     InArray[JsonTextReader.Depth + 1] := FALSE;
    //                 JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
    //                     IF JsonTextReader.Depth > 0 THEN
    //                         IF InArray[JsonTextReader.Depth] THEN ColumnNo += 1;
    //             END;
    //     end;

    //     [Scope('Internal')]
    //     procedure StartJsonArray2(BranchName: Text)
    //     begin
    //         JsonTextWriter.WritePropertyName(BranchName);
    //         JsonTextWriter.WriteStartArray;
    //     end;

    //     [Scope('Internal')]
    //     procedure WriteString(Input: Text)
    //     begin
    //         StringWriter.Write(Input);
    //     end;

    //     [Scope('Internal')]
    //     procedure AddJsonCurlyBracket(BranchName: Text)
    //     begin
    //         JsonTextWriter.WritePropertyName(BranchName);
    //         StringWriter.Write('');
    //         JsonTextWriter.WriteStartObject;
    //     end;

    //     [Scope('Internal')]
    //     procedure EndJSonCurlyBracket()
    //     begin
    //         JsonTextWriter.WriteEndObject;
    //         StringWriter.Write('');
    //     end;

    //     [Scope('Internal')]
    //     procedure AddToJSonValue(Variable: Variant)
    //     begin
    //         //JsonTextWriter.WritePropertyName;
    //         JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
    //     end;

    //     [Scope('Internal')]
    //     procedure AddToJSonValueWithDoubleComm(Variable: Variant)
    //     begin
    //         //JsonTextWriter.WritePropertyName;
    //         JsonTextWriter.WriteRawValue(FORMAT(Variable, 0, 9));
    //     end;

    //     [Scope('Internal')]
    //     procedure AddToJSonRaw(VariableName: Text; Variable: Variant)
    //     begin
    //         JsonTextWriter.WritePropertyName(VariableName);
    //         JsonTextWriter.WriteRawValue(FORMAT(Variable, 0, 9));
    //     end;

    //     [Scope('Internal')]
    //     procedure CreateWebRequestForGSTNo(var HttpWebRequest: DotNet HttpWebRequest; WebServiceURL: Text; Method: Text)
    //     var
    //         ServicePointManager: DotNet ServicePointManager;
    //         SecurityProtocolType: DotNet SecurityProtocolType;
    //     begin
    //         EwaySetup.GET;
    //         HttpWebRequest := HttpWebRequest.Create(WebServiceURL);
    //         ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;//TL12
    //         HttpWebRequest.Method := Method;
    //         HttpWebRequest.KeepAlive := TRUE;
    //         HttpWebRequest.Timeout := 500000;
    //         HttpWebRequest.ContentType('application/json');
    //         HttpWebRequest.Headers.Add('apikey', 'eccdfa79-adba-40ac-b9eb-e8fa2e678fc5');
    //     end;
}

