{$include config.inc}

unit a_clear;

interface

uses global;

type
	Tclear = class (TApplet)
		procedure exec; override;
	end;

implementation

uses crt;

procedure Tclear.exec;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount >= paramstart) and (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'clear', line);
		write(stderr, line);
		write(stderr, 'Clear screen', line);
		halt(1);
	end;
{$endif}
	clrscr;
end;

initialization
	multicall.add(Tclear.create('clear' {$ifdef CONFIG_FEATURE_INSTALLER}, usrbin {$endif}));
end.
