unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtDlgs, jpeg, clipbrd, ExtCtrls, Menus, FileCtrl, DirectoryLurk;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Open1: TOpenPictureDialog;
    Image1: TImage;
    ListBox3: TListBox;
    Button2: TButton;
    Save1: TSaveDialog;
    Image2: TImage;
    Button3: TButton;
    Open2: TOpenDialog;
    ListBox1Ad: TListBox;
    PopupListbox2: TPopupMenu;
    Show: TMenuItem;
    PopupListbox1: TPopupMenu;
    Delete1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    ExplorerButton: TButton;
    Image3: TImage;
    Button4: TButton;
    TabSheet4: TTabSheet;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    ListBox4: TListBox;
    Button5: TButton;
    Button6: TButton;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    UpDownEdit1: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Button9: TButton;
    CopyPath1: TMenuItem;
    IndexText: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ShowClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure PopupListbox1Popup(Sender: TObject);
    procedure MoveUp1Click(Sender: TObject);
    procedure MoveDown1Click(Sender: TObject);
    procedure ExplorerButtonClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CopyPath1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExplorerCheck;
    procedure Add2ShowList;
    procedure IndexTextShow;
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}


var
exedir:string;

//////////////////////////////////////////////////////////////////

procedure TForm1.ExplorerCheck;
begin
if listbox1.Items.Count>0 then ExplorerButton.Enabled:=true else ExplorerButton.Enabled:=false;
end;

Procedure TForm1.Add2ShowList;
var
i:integer;
begin
if listbox3.Items.Count=0 then listbox1.Clear;
listbox3.Items.Add(listbox2.Items.Strings[listbox2.ItemIndex]);
listbox1ad.Items.LoadFromFile(exedir+'lists\'+listbox3.Items.Strings[listbox3.Items.count-1]+'.lst');
//listbox1.Items.Add('/@   LIST FILE: '+listbox3.Items.Strings[listbox3.Items.count-1]+'    @/');
for i:=0 to listbox1ad.Items.Count-1 do
listbox1.Items.Add(listbox1ad.Items.Strings[i]);
listbox1ad.Clear;
ExplorerCheck;
IndexTextShow;
end;

procedure TForm1.IndexTextShow;
begin
if ListBox1.ItemIndex>-1 then
 IndexText.Caption:=IntToStr(Listbox1.ItemIndex+1)+'/'+IntToStr(ListBox1.Items.Count)
 else
 IndexText.Caption:=IntToStr(ListBox1.Items.Count);
end;


//////////////////////////////////////////////////////////////////

procedure TForm1.Button1Click(Sender: TObject);
begin
if open1.Execute then
listbox1.Items.AddStrings(open1.Files);
ExplorerCheck;
IndexTextShow;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
if listbox1.ItemIndex>-1 then
  image1.Picture.LoadFromFile( listbox1.Items.Strings[listbox1.ItemIndex] );
IndexTextShow;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if listbox1.Items.Count=0 then
 showmessage('Unable to save file becouse list is empty')
else
if save1.Execute then
if pos('.lst',save1.FileName)=0 then begin save1.FileName:=save1.FileName+'.lst';
listbox1.Items.SaveToFile(save1.FileName);
listbox2.Items.Add( copy(extractfilename(save1.FileName),1,length(extractfilename(save1.FileName))-4) );
listbox2.Items.SaveToFile(exedir+'lists\listindex.usr');  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if open2.Execute then
 begin
 listbox1.Items.LoadFromFile(open2.FileName);
 ExplorerCheck;
 IndexTextShow;
 end;
end;

procedure TForm1.ShowClick(Sender: TObject);
begin
Add2ShowList;
end;

procedure TForm1.Delete1Click(Sender: TObject);
var
i:integer;
begin
i:=listbox1.ItemIndex;
listbox1.Items.Delete(i);
if listbox1.Items.Count>0 then
 if i=listbox1.Items.Count then listbox1.ItemIndex:=i-1
 else listbox1.ItemIndex:=i;
listbox3.Clear;
ExplorerCheck;
IndexTextShow;
end;

procedure TForm1.PopupListbox1Popup(Sender: TObject);
begin
if listbox1.ItemIndex=-1 then
 delete1.Enabled:=false
else
 delete1.Enabled:=true;
end;

procedure TForm1.MoveUp1Click(Sender: TObject);
begin
listbox1.Items.Exchange(listbox1.ItemIndex,listbox1.ItemIndex-1);
listbox3.Clear;
IndexTextShow;
end;

procedure TForm1.MoveDown1Click(Sender: TObject);
begin
listbox1.Items.Exchange(listbox1.ItemIndex,listbox1.ItemIndex+1);
listbox3.Clear;
IndexTextShow;
end;

procedure TForm1.ExplorerButtonClick(Sender: TObject);
begin
if listbox1.ItemIndex=-1 then listbox1.ItemIndex:=0;
if pos('/',listbox1.Items.Strings[listbox1.ItemIndex])=1 then
  listbox1.itemindex:=listbox1.itemindex+1;
form2.visible:=true;
form2.WindowState:=wsMaximized;

form2.ScrollBox1.Height:=  Monitor.Height+1;
form2.ScrollBox1.Width:= Monitor.Width+1;
form2.label2.Left:=Monitor.Width-form2.label2.Width-2;
form2.ShowPic;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
Add2ShowList;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
ListBox1.Clear;
ExplorerButton.Enabled:=false;
IndexText.Caption:='0';
end;

procedure TForm1.Button5Click(Sender: TObject);
var
lk,i,k:integer;
begin
folderlist(listbox4,filelistbox1,directorylistbox1);
lk:=listbox4.Items.Count;
filelistbox1.Mask:='*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf';

for i:=0 to lk-1 do
  begin
  filelistbox1.Directory:=listbox4.Items.Strings[i];
  for k:=0 to filelistbox1.Items.Count-1 do
  listbox4.Items.Add(filelistbox1.Directory + '\' +
    filelistbox1.Items.Strings[k]);
  end;
filelistbox1.Directory:=listbox4.Items.Strings[0];
for i:=0 to lk-1 do
  listbox4.Items.Delete(0);
filelistbox1.Mask:='*.*';
if listbox4.Items.Count=0 then Showmessage('No Pictures Found in Subdirectories');
end;



procedure TForm1.ListBox4Click(Sender: TObject);
begin
listbox4.Hint:=listbox4.Items.Strings[listbox4.itemindex];
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
if listbox4.Items.Count=0 then
 showmessage('Unable to Export. List of files is empty.')
else
if save1.Execute then
if pos('.lst',save1.FileName)=0 then begin save1.FileName:=save1.FileName+'.lst';
listbox4.Items.SaveToFile(save1.FileName);
if not fileexists(save1.FileName)then
listbox2.Items.Add( copy(extractfilename(save1.FileName),1,length(extractfilename(save1.FileName))-4) );
listbox2.Items.SaveToFile(exedir+'lists\listindex.usr');  end;
end;

procedure TForm1.ListBox3DblClick(Sender: TObject);
var
i,j:integer;
begin
Listbox3.Items.Delete(Listbox3.ItemIndex);
listbox1.Clear;
if listbox3.Items.Count>0 then
for i:=0 to listbox3.Items.Count-1 do
  begin
  listbox1ad.Items.LoadFromFile(exedir+'lists\'+listbox3.Items.Strings[i]+'.lst');
  listbox1.Items.Add('/@   LIST FILE: '+listbox3.Items.Strings[i]+'    @/');
  for j:=0 to listbox1ad.Items.Count-1 do
  listbox1.Items.Add(listbox1ad.Items.Strings[j]);
  listbox1ad.Clear;
  end;
ExplorerCheck;
IndexTextShow;
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
edit2.Text:=directorylistbox1.Directory;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
i:integer;
begin
if listbox4.Items.Count>0 then
  begin
  explorerbutton.Enabled:=true;
  if listbox3.Items.Count>0 then begin listbox1.Clear; listbox3.Clear; end;
  for i:=0 to listbox4.Items.Count-1 do
    listbox1.Items.Add(listbox4.Items.Strings[i]);
  end else showmessage('No Pictures to add');
IndexTextShow;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=chr(13) then directorylistbox1.Directory:=edit2.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if listbox3.Items.Count>0 then
  listbox1.Clear;
  listbox1.Items.SaveToFile(exedir+'lists\templist')

end;

procedure TForm1.FormCreate(Sender: TObject);
var
b:boolean;
s:string;
begin
exedir:=ExtractFilePath(Application.ExeName);
if not fileexists(exedir+'lists\listindex.usr') then
  begin
  createdirectory(pchar(exedir+'lists'),nil);
  listbox2.Items.SaveToFile(exedir+'lists\listindex.usr');
  end
else
  begin
  listbox2.Items.LoadFromFile(exedir+'lists\listindex.usr');
  end;
save1.InitialDir:=exedir+'lists';
open2.InitialDir:=exedir+'lists';
if fileexists(exedir+'lists\templist') then
  listbox1.Items.LoadFromFile(exedir+'lists\templist');
if listbox1.Items.Count>0 then explorerbutton.Enabled:=true;
end;

procedure TForm1.CopyPath1Click(Sender: TObject);
var
c:TClipboard;
s:pchar;
begin
if listbox1.ItemIndex>-1 then
 begin
 c:=tclipboard.Create;
 s:=pchar(listbox1.Items.Strings[listbox1.ItemIndex]);
 c.SetTextBuf(s);
 c.Free;
 end;
end;

end.
