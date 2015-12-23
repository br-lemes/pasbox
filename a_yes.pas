{$include config.inc}

unit a_yes;

interface

uses global;

type
	Tyes = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Tyes.exec;
var
	s: string;
	i: integer;
begin
	if paramcount >= paramstart then
	begin
		s := paramstr(paramstart);
	{$ifdef CONFIG_SHOW_USAGE}
		if s = '--help' then
		begin
			write(stderr, copying, line);
			write(stderr, line);
			write(stderr, usage, 'yes [STRING]', line);
			write(stderr, line);
			write(stderr, 'Repeatedly output a line with STRING, or ''y''', line);
			halt(1);
		end;
	{$endif}
		for i := paramstart + 1 to paramcount do
			s := s + ' ' + paramstr(i);
	end else s := 'y';
	while true do writeln(s);
end;

initialization
	multicall.add(Tyes.create('yes' {$ifdef CONFIG_FEATURE_INSTALLER}, usrbin {$endif}));
end.
