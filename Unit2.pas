unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, jpeg;

type
  TForm2 = class(TForm)
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    PrevPic1: TMenuItem;
    Play1: TMenuItem;
    Fit1: TMenuItem;
    Stretch1: TMenuItem;
    ShowPath1: TMenuItem;
    ShowTimer1: TMenuItem;
    Timer1: TTimer;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    Label2: TLabel;
    Label1: TLabel;
    procedure Close1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ShowPath1Click(Sender: TObject);
    procedure Stretch1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ShowTimer1Click(Sender: TObject);
    procedure Form1NextPic1Click(Sender: TObject);
    procedure PrevPic1Click(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure Fit1Click(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NextPic;
    procedure PrevPic;
    procedure ShowPic;
    procedure BigPic;
    procedure Fit;
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}


var
monitorRatio:double;

////////////////////////////////////////////////////////////

procedure TForm2.NextPic;
begin
if Form1.ListBox1.ItemIndex=Form1.ListBox1.Items.Count-1 then
  Form1.ListBox1.ItemIndex:=0
else
  Form1.ListBox1.ItemIndex:=Form1.ListBox1.ItemIndex+1;
   //if pos('/',Form1.listbox1.Items.Strings[Form1.listbox1.ItemIndex])=1 then
   //NextPic;
//image1.Picture:=NextBitmap;
ShowPic;
//NextBitmap.LoadFromFile(Form1.ListBox1.Items.Strings[Form1.ListBox1.itemindex+1]);
end;

procedure TForm2.PrevPic;
begin
if Form1.ListBox1.ItemIndex=0 then
  Form1.ListBox1.ItemIndex:=Form1.ListBox1.Items.Count-1
else
  Form1.ListBox1.ItemIndex:=Form1.ListBox1.ItemIndex-1;
//if pos('/',Form1.listbox1.Items.Strings[Form1.listbox1.ItemIndex])=1 then
//PrevPic;
image1.Picture.LoadFromFile(Form1.ListBox1.Items.Strings[Form1.ListBox1.itemindex]);
ShowPic;
end;

procedure TForm2.ShowPic;
begin
image1.Picture.LoadFromFile(Form1.ListBox1.Items.Strings[Form1.ListBox1.itemindex]);
if fit1.Checked then Fit else
  if stretch1.Checked=false then BigPic;

if Label1.Visible then Label1.Caption:=Form1.ListBox1.Items.Strings[Form1.ListBox1.itemindex];
end;

procedure TForm2.BigPic;
begin
image1.AutoSize:=true;
image1.AutoSize:=false;
if image1.Height<Monitor.Height then begin image1.Height:=Monitor.Height; ScrollBox1.VertScrollBar.Visible:=false; end else
 if image1.Height>Monitor.Height then ScrollBox1.VertScrollBar.Visible:=true;
if image1.Width<Monitor.Width then begin image1.Width:=Monitor.Width; ScrollBox1.HorzScrollBar.Visible:=false; end else
 if image1.Width>Monitor.Width then ScrollBox1.HorzScrollBar.Visible:=true;
end;

procedure TForm2.Fit;
var
imageRatio:double;
begin
image1.AutoSize:=true;
image1.AutoSize:=false;
image1.Stretch:=true;
imageRatio:=image1.Height/image1.Width;
if imageRatio=monitorRatio then
  begin
  image1.Height:=Monitor.Height;
  image1.Width:=Monitor.Width;
  image1.Top:=0;
  image1.Left:=0;
  end else
if ( (imageRatio) > monitorRatio ) then   //height larger
  begin
  image1.Height:=Monitor.Height;
  image1.Width:=trunc(Monitor.Height/imageRatio);
  image1.Top:=0;
  image1.Left:=(Monitor.Width div 2)-(image1.Width div 2);
  end
else                           //width larger
  begin
  image1.Width:=Monitor.Width;
  image1.Height:=trunc(imageRatio*Monitor.Width);
  image1.Left:=0;
  image1.Top:=(Monitor.Height div 2)-(image1.Height div 2);
  end;
end;


////////////////////////////////////////////////////////////

procedure TForm2.Close1Click(Sender: TObject);
begin
timer1.Enabled:=false;
play1.Checked:=false;
showtimer1.Checked:=false;
Close;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
monitorRatio:=monitor.Height/monitor.Width;
image1.Picture.LoadFromFile(Form1.ListBox1.Items.Strings[Form1.ListBox1.ItemIndex]);
//NextBitmap:=TPicture.Create;
//NextBitmap.LoadFromFile(Form1.ListBox1.Items.Strings[Form1.ListBox1.ItemIndex+1]);
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
NextPic;
end;

procedure TForm2.ShowPath1Click(Sender: TObject);
begin
Label1.Visible:=ShowPath1.Checked;
label1.Caption:=Form1.ListBox1.Items.Strings[Form1.ListBox1.itemindex];
end;

procedure TForm2.Stretch1Click(Sender: TObject);
begin
fit1.Checked:=false;
image1.Top:=0;
image1.Left:=0;
BigPic;
image1.Stretch:=Stretch1.Checked;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
if label2.Visible then label2.Caption:=copy(timetostr(now),1,5);
if play1.Checked then NextPic;
end;

procedure TForm2.ShowTimer1Click(Sender: TObject);
begin
if not play1.Checked then timer1.Enabled:=showtimer1.Checked;
label2.Visible:=showtimer1.Checked;
label2.Caption:=copy(timetostr(now),1,5);
end;

procedure TForm2.Form1NextPic1Click(Sender: TObject);
begin
NextPic;
end;

procedure TForm2.PrevPic1Click(Sender: TObject);
begin
PrevPic;
end;

procedure TForm2.Play1Click(Sender: TObject);
begin
timer1.Interval:=Form1.UpDownEdit1.Position*1000;
if not label2.Visible then timer1.Enabled:=play1.Checked;
if play1.Checked=false then timer1.Interval:=60000;
end;

procedure TForm2.Fit1Click(Sender: TObject);
begin
stretch1.Checked:=false;
if fit1.Checked then Fit else
  begin
  image1.Stretch:=false;
  image1.Top:=0;
  image1.Left:=0;
  BigPic;

  end;
end;

procedure TForm2.ScrollBox1Click(Sender: TObject);
begin
NextPic;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
  vk_left:PrevPic;
  vk_right:NextPic;
  vk_escape:Close1Click(Sender);
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
with form1 do
Image1.Picture.LoadFromFile(listbox1.Items.Strings[listbox1.itemindex]);
//NextBitmap.Free;
Form1.IndexTextShow;
end;

end.
