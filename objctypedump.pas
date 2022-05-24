unit objctypedump;

interface
{$mode delphi}
{$modeswitch objectivec2}
uses
  CocoaAll;

procedure DumpDictionary(d: NSDictionary);
function NSObjectToString(obj : NSObject): string;

implementation

function NSObjectToString(obj : NSObject): string;
begin
  if obj = nil then Result := 'nil'
  else if (obj.isKindOfClass(NSString)) then Result := NSString(obj).UTF8String
  else if (obj.isKindOfClass(NSNumber)) then Result := NSNumber(obj).stringValue.UTF8String
  else Result := obj.className.UTF8String;
end;

procedure DumpDictionary(d: NSDictionary);
var
  k : NSString;
  v : NSObject;
begin
  if d = nil then begin
    writeln('nil');
    Exit;
  end;
  for k in d.keyEnumerator do
  begin
    write(k.UTF8String);
    write(' => ');
    v := d.objectForKey(k);
    write ( NSObjectToString(v));
    writeln;
  end;

end;

end.
