unit DirectoryLurk;

interface

uses stdctrls, filectrl;


    procedure adddirs2list(FileListbox:TFileListBox; listbox:TListbox);
    procedure FolderList(listbox:TListBox; filelistbox:Tfilelistbox; DirectoryListBox:TDirectoryListBox);


implementation

procedure adddirs2list(FileListbox:TFileListBox; listbox:TListbox); {Adds current dirs of current directory of directorylistbox 2 listbox1}
var
i:integer;
begin
for i:=0 to filelistbox.Items.Count-1 do
 if pos('[',filelistbox.Items.Strings[i])=1 then
  if copy(filelistbox.Items.Strings[i],length(filelistbox.Items.Strings[i]),1)=']' then
   if filelistbox.Items.Strings[i]='[.]' then else
    if filelistbox.Items.Strings[i]='[..]' then else
//    if directoryexists(filelistbox.Directory+'\'+
//         copy(filelistbox.Items.Strings[i],2,length(filelistbox1.Items.Strings[i])-2 ) ) then
    listbox.Items.Add(filelistbox.Directory+'\'+
         copy(filelistbox.Items.Strings[i],2,length(filelistbox.Items.Strings[i])-2 ) );
end;

procedure FolderList(listbox:TListBox; filelistbox:Tfilelistbox; DirectoryListBox:TDirectoryListBox);
var
j:integer;
begin
listbox.Clear;

listbox.Items.Add(Directorylistbox.Directory);

adddirs2list(filelistbox, listbox);

if length(directorylistbox.Directory)=3 then
  begin
  for j:=1 to listbox.Items.Count-1 do
    listbox.Items.Strings[j]:=listbox.Items.Strings[0]+copy(listbox.Items.Strings[j],5,length(listbox.Items.Strings[j])-4);
  listbox.Items.Strings[0]:=copy(listbox.Items.Strings[0],1,2);

  end;

j:=0;

if listbox.Items.count>1 then
repeat
inc(j);
DirectoryListBox.Directory:=listbox.Items.Strings[j];
adddirs2list(FileListbox,Listbox);
until j=listbox.Items.Count-1;
directorylistbox.Directory:=listbox.Items.Strings[0];
end;

end.
 