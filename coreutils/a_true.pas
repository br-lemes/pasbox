{$include config.inc}

unit a_true;

interface

uses global;

type
	Ttrue = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Ttrue.exec;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount >= paramstart) and (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'true', line);
		write(stderr, line);
		write(stderr, 'Return and exit coe of TRUE (0)', line);
		halt(1);
	end;
{$endif}
	halt(0);
end;

initialization
	multicall.add(Ttrue.create('true' {$ifdef CONFIG_FEATURE_INSTALLER}, bin {$endif}));
end.
