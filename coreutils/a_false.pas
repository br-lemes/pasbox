{$include config.inc}

unit a_false;

interface

uses global;

type
	Tfalse = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Tfalse.exec;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount >= paramstart) and (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'false', line);
		write(stderr, line);
		write(stderr, 'Return an exit code of FALSE (1)', line);
	end;
{$endif}
	halt(1);
end;

initialization
	multicall.add(Tfalse.create('false' {$ifdef CONFIG_FEATURE_INSTALLER}, bin {$endif}));
end.
