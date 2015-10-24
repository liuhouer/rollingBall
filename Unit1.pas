unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;var sa:Tshape;ta:Ttimer;
begin
  for i:=form1.ControlCount downto 1 do
  begin
    if (form1.Controls[i-1].ClassType=Tshape) then
     form1.Controls[i-1].Destroy;
    if (form1.Controls[i-1].ClassType=tTimer) then
     form1.Controls[i-1].Enabled:=false;
  end;

  for i:=1 to strtoint(edit1.Text) do
  begin
    sa:=Tshape.Create(self);
    sa.Parent:=form1;
    sa.Height:=20;
    sa.Width:=20;
    sa.shape:=stCircle;
    sa.Pen.Color:=rgb(i*50,0,0);
    sa.Visible:=true;
    sa.Left:=20;
    sa.Top:=22*i-20;
    sa.Name:='sa'+inttostr(1000+i);
    if form1.FindComponent('ta'+inttostr(1000+i))=nil then
    begin
      ta:=Ttimer.Create(self);
      ta.Name:='ta'+inttostr(1000+i);
      ta.Interval:=i*10+30;
      ta.OnTimer:=Timer1Timer;
      ta.Enabled:=true;
    end
    else
    begin
      ta:=form1.FindComponent('ta'+inttostr(1000+i)) as Ttimer;
      ta.Interval:=i*10+30;
      ta.OnTimer:=Timer1Timer;
      ta.Enabled:=true;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var s:string;sa:Tshape;i:integer;
begin
 s:=copy((sender as ttimer).Name,3,4);
 for i:=1 to form1.ControlCount do
 if form1.Controls[i-1].Name='sa'+s then
 begin
   sa:=form1.Controls[i-1] as Tshape;
   sa.Left:=sa.Left+5;
   if sa.Left+sa.Width>=form1.ClientWidth then
   begin
     (sender as ttimer).Enabled:=false;
      sa.Left:=form1.ClientWidth-sa.Width;
   end;
 end;
end;

end.
