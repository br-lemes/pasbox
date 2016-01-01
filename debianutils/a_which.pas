{$include config.inc}

unit a_which;

interface

uses global;

type
	Twhich = class (TApplet)
		procedure exec; override;
	end;

implementation

uses sysutils;

{$ifdef CONFIG_SHOW_USAGE}
procedure showusage;
begin
	write(stderr, copying, line);
	write(stderr, line);
	write(stderr, usage, 'which [COMMAND]...', line);
	write(stderr, line);
	write(stderr, 'Locate a COMMAND', line);
	halt(1);
end;
{$endif}

procedure Twhich.exec;
var
	i: integer;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if paramcount < paramstart then showusage;
	for i := paramstart to paramcount do
		if paramstr(i) = '--help' then showusage;
{$endif}
	for i := paramstart to paramcount do
		writeln(exesearch(paramstr(i), getenvironmentvariable('PATH')));
end;

initialization
	multicall.add(Twhich.create('which' {$ifdef CONFIG_FEATURE_INSTALLER}, usrbin {$endif}));
end.
