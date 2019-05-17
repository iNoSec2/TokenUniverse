unit NtUtils.Exec;

interface

uses
  NtUtils.Exceptions;

type
  TExecParam = (
    ppParameters, ppCurrentDirectory, ppDesktop, ppToken, ppLogonFlags,
    ppInheritHandles, ppCreateSuspended, ppBreakaway,
    ppRequireElevation, ppShowWindowMode
  );

  IExecProvider = interface
    function Provides(Parameter: TExecParam): Boolean;
    function Application: String;
    function Parameters: String;
    function CurrentDircetory: String;
    function Desktop: String;
    function Token: THandle;
    function LogonFlags: Cardinal;
    function InheritHandles: Boolean;
    function CreateSuspended: Boolean;
    function Breakaway: Boolean;
    function RequireElevation: Boolean;
    function ShowWindowMode: Word;
  end;

  IExecMethod = interface
    function Supports(Parameter: TExecParam): Boolean;
    procedure Execute(ParamSet: IExecProvider);
  end;

  TDefaultExecProvider = class(TInterfacedObject, IExecProvider)
    function Provides(Parameter: TExecParam): Boolean; virtual;
    function Application: String; virtual; abstract;
    function Parameters: String; virtual; abstract;
    function CurrentDircetory: String; virtual;
    function Desktop: String; virtual;
    function Token: THandle; virtual;
    function LogonFlags: Cardinal; virtual;
    function InheritHandles: Boolean; virtual;
    function CreateSuspended: Boolean; virtual;
    function Breakaway: Boolean; virtual;
    function RequireElevation: Boolean; virtual;
    function ShowWindowMode: Word; virtual;
  end;

function PrepareCommandLine(ParamSet: IExecProvider): String;

implementation

uses
  Winapi.WinUser;

{ TDefaultExecProvider }

function TDefaultExecProvider.Breakaway: Boolean;
begin
  Result := False;
end;

function TDefaultExecProvider.CreateSuspended: Boolean;
begin
  Result := False;
end;

function TDefaultExecProvider.CurrentDircetory: String;
begin
  Result := '';
end;

function TDefaultExecProvider.Desktop: String;
begin
  Result := '';
end;

function TDefaultExecProvider.InheritHandles: Boolean;
begin
  Result := False;
end;

function TDefaultExecProvider.LogonFlags: Cardinal;
begin
  Result := 0;
end;

function TDefaultExecProvider.Provides(Parameter: TExecParam): Boolean;
begin
  Result := False;
end;

function TDefaultExecProvider.RequireElevation: Boolean;
begin
  Result := False;
end;

function TDefaultExecProvider.ShowWindowMode: Word;
begin
  Result := SW_SHOWNORMAL;
end;

function TDefaultExecProvider.Token: THandle;
begin
  Result := 0;
end;

{ Functions }

function PrepareCommandLine(ParamSet: IExecProvider): String;
begin
  Result := '"' + ParamSet.Application + '"';
  if ParamSet.Provides(ppParameters) then
    Result := Result + ' ' + ParamSet.Parameters;
end;

end.
