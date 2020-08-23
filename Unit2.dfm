object Form2: TForm2
  Left = 618
  Top = 62
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 768
  ClientWidth = 1028
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clSilver
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 1025
    Height = 769
    HorzScrollBar.Size = 12
    VertScrollBar.Position = 1
    VertScrollBar.Size = 12
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = ScrollBox1Click
    object Image1: TImage
      Left = 0
      Top = -1
      Width = 1920
      Height = 1080
      AutoSize = True
      Center = True
      PopupMenu = PopupMenu1
      OnClick = Image1Click
    end
    object Label2: TLabel
      Left = 992
      Top = -1
      Width = 32
      Height = 13
      Caption = 'Label2'
      Visible = False
    end
    object Label1: TLabel
      Left = 0
      Top = -1
      Width = 54
      Height = 13
      Caption = 'Image Path'
      Visible = False
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 16
    object Play1: TMenuItem
      AutoCheck = True
      Caption = 'Play'
      OnClick = Play1Click
    end
    object NextPic1: TMenuItem
      Caption = 'Next Pic'
      OnClick = Form1NextPic1Click
    end
    object PrevPic1: TMenuItem
      Caption = 'Prev Pic'
      OnClick = PrevPic1Click
    end
    object Fit1: TMenuItem
      AutoCheck = True
      Caption = 'Fit'
      OnClick = Fit1Click
    end
    object Stretch1: TMenuItem
      AutoCheck = True
      Caption = 'Stretch'
      OnClick = Stretch1Click
    end
    object ShowPath1: TMenuItem
      AutoCheck = True
      Caption = 'Show Path'
      OnClick = ShowPath1Click
    end
    object ShowTimer1: TMenuItem
      AutoCheck = True
      Caption = 'Show Timer'
      OnClick = ShowTimer1Click
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 16
    Top = 48
  end
end
