{$include config.inc}

unit global;

interface

{$ifdef CONFIG_FEATURE_USE_CRT}
uses crt {$ifdef DEBUG}, heaptrc {$endif};
{$else}
{$ifdef DEBUG}uses heaptrc; {$endif}
{$endif}

const
	version = '0.1.1';
	copying = 'PasBox ' + version + ' Copyright (C) 2015-2016 Breno Ramalho Lemes';
{$ifdef CONFIG_FEATURE_INSTALLER}
	path: array [1..4] of string = ('bin/', 'sbin/', 'usr/bin/', 'usr/sbin/');
	bin     = 1;
	sbin    = 2;
	usrbin  = 3;
	usrsbin = 4;
{$endif}
{$ifdef CONFIG_SHOW_USAGE}
	usage = 'Usage: ';
{$endif}
	listplain = 1;
	listfull  = 2;
	listwide  = 3;
{$ifdef CONFIG_FEATURE_USE_CRT}
	line = #13#10;
{$else}
	line = lineending;
{$endif}

var
	paramstart: integer = 1;
	appletname: string;

type
	TApplet = class
	private
		_name: string;
	{$ifdef CONFIG_FEATURE_INSTALLER}
		_path: byte;
	{$endif}
	public
		constructor create(const name: string {$ifdef CONFIG_FEATURE_INSTALLER}; const path: byte{$endif});
		procedure exec; virtual; abstract;
		property name: string read _name;
	{$ifdef CONFIG_FEATURE_INSTALLER}
		property path: byte read _path;
	{$endif}
	end;

	TMulticall = class
	private
		applets: array of TApplet;
	public
		destructor destroy; override;
		procedure add(applet: TApplet);
		procedure list(const style: byte);
		function exec(const name: string): boolean;
	end;

var
	multicall: TMulticall;

implementation

constructor TApplet.create(const name: string {$ifdef CONFIG_FEATURE_INSTALLER}; const path: byte{$endif});
begin
	inherited create;
	_name := name;
{$ifdef CONFIG_FEATURE_INSTALLER}
	_path := path;
{$endif}
end;

destructor TMulticall.destroy;
var i: integer;
begin
	for i := 0 to High(applets) do
		applets[i].destroy;
	setlength(applets, 0);
	inherited;
end;

procedure TMulticall.add(applet: TApplet);
var i: integer;
begin
	i := length(applets);
	setlength(applets, i + 1);
	applets[i] := applet;
end;

function TMulticall.exec(const name: string): boolean;
var i: integer;
begin
	exec := false;
	for i := 0 to High(applets) do
		if applets[i].name = name then
		begin
			applets[i].exec;
			exec := true;
			break;
		end;
end;

procedure TMulticall.list(const style: byte);
var
	i: integer;
{$ifdef CONFIG_FEATURE_USE_CRT}
	wcount: integer = 0;
{$endif}
begin
	for i := 0 to High(applets) do
	begin
		if style = listplain then
			writeln(applets[i].name)
	{$ifdef CONFIG_FEATURE_INSTALLER}
		else if style = listfull then
			writeln(path[applets[i].path], applets[i].name)
	{$endif}
		else if style = listwide then
	{$ifdef CONFIG_FEATURE_USE_CRT}
		begin
			if (wcount <> 0) and (wcount + length(applets[i].name) + 3 < screenwidth) then
			begin
				write(', ', applets[i].name);
				inc(wcount, length(applets[i].name) + 2);
			end else begin
				if wcount <> 0 then writeln(',');
				write('   ', applets[i].name);
				wcount := length(applets[i].name) + 3;
			end;
		end;
	{$else}
		writeln(#9, applets[i].name);
	{$endif}
	end;
{$ifdef CONFIG_FEATURE_USE_CRT}
	if style = listwide then writeln;
{$endif}
end;

initialization
	multicall := TMulticall.create;
finalization
	multicall.destroy;
end.
