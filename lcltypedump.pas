unit lclTypeDump;

interface

{$mode delphi}

uses Classes, SysUtils, Graphics;

const
  FontStylesStr : array [TFontStyle] of string = (
    'fsBold', 'fsItalic', 'fsUnderline', 'fsStrikeOut'
  );

function FontStylesToStr(Style: TFontStyles; const separator: string = ' '): string;

procedure FontToStr(font : TFont; dst: TStrings); overload;
function FontToStr(font : TFont): string; overload;

function ColorToHex(c: TColor): string;

implementation

function ColorToHex(c: TColor): string;
begin
  Result := IntToHex(c, 8);
end;

function FontStylesToStr(Style: TFontStyles; const separator: string = ' '): string;
var
 s : TFontStyle;
begin
  Result := '';
  for s:=low(TFontStyle) to high(TFontStyle) do
    if s in Style then begin
      if Result<>'' then Result:=Result+separator;
      Result:=Result+FontStylesStr[s];
    end;
end;

procedure FontToStr(font : TFont; dst: TStrings);
begin
  if (dst = nil) then Exit;
  if (font = nil) then begin
    dst.Add('nil');
    exit;
  end;
  dst.Add('Name: '+font.Name);
  dst.Add('Height: '+IntToStr(font.Height));
  dst.Add('Size: '+IntToStr(font.Size));
  dst.Add('Style: '+FontStylesToStr(font.Style));
  dst.Add('Color: '+ColorToHex(font.Color));
end;

function FontToStr(font : TFont): string;
var
  st : TStringList;
begin
  st := TStringList.Create;
  try
    FontToStr(font, st);
    Result := st.Text;
  finally
    st.Free;
  end;
end;

end.
