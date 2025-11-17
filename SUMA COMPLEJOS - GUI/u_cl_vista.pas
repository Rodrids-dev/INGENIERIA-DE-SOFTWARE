unit U_CL_VISTA;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { CL_VISTA }

  CL_VISTA = class(TForm)
    btn_sumar: TButton;
    btn_borrar: TButton;
    ct_img1: TEdit;
    ct_img2: TEdit;
    ct_img_res: TEdit;
    ct_real1: TEdit;
    ct_real2: TEdit;
    ct_real_res: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_borrarClick(Sender: TObject);
    procedure btn_sumarClick(Sender: TObject);
  private

  public
    procedure set_ct_real_res(txt:String);
    procedure set_ct_img_res(txt:String);
    function get_ct_real1:String;
    function get_ct_img1:String;
    function get_ct_real2:String;
    function get_ct_img2:String;
    function get_ct_real_res:String;
    function get_ct_img_res:String;
  end;

var
  interfaz: CL_VISTA;

implementation

uses
  U_CTRL_OPERACION;

{$R *.lfm}

{ CL_VISTA }

procedure CL_VISTA.FormCreate(Sender: TObject);
begin
    obj_control:=CTRL_OPERACION.Create;
end;

procedure CL_VISTA.btn_sumarClick(Sender: TObject);
begin
    obj_control.click_btn_sumar;
end;

procedure CL_VISTA.btn_borrarClick(Sender: TObject);
begin
    obj_control.click_btn_borrar;
end;

procedure CL_VISTA.set_ct_real_res(txt:String);
begin
  ct_real_res.Text:= txt;
end;

procedure CL_VISTA.set_ct_img_res(txt:String);
begin
  ct_img_res.Text:= txt;
end;

function CL_VISTA.get_ct_real1:String;
begin
  Result:= ct_real1.Text;
end;

function CL_VISTA.get_ct_img1:String;
begin
  Result:= ct_img1.Text;
end;

function CL_VISTA.get_ct_real2:String;
begin
  Result:= ct_real2.Text;
end;

function CL_VISTA.get_ct_img2:String;
begin
  Result:= ct_img2.Text;
end;

function CL_VISTA.get_ct_real_res:String;
begin
  Result:= ct_real_res.Text;
end;

function CL_VISTA.get_ct_img_res:String;
begin
  Result:= ct_img_res.Text;
end;

end.

