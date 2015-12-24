{$include config.inc}

unit a_dirname;

interface

uses global;

type
	Tdirname = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Tdirname.exec;
var
	n: string;
	i: longint;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount < paramstart) or (paramcount > paramstart) or (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'dirname FILENAME', line);
		write(stderr, line);
		write(stderr, 'Strip non-directory suffix from FILENAME', line);
		halt(1);
	end;
{$endif}
	n := paramstr(paramstart);
	i := length(n);
	while (i > 1) and (n[i] in ['/', '\']) do
		dec(i);
	while (i > 0) and not (n[i] in ['/','\']) do
		dec(i);
	while (i > 1) and (n[i] in ['/', '\']) do
		dec(i);
	if i = 0 then writeln('.') else writeln(copy(n, 1, i));
end;

initialization
	multicall.add(Tdirname.create('dirname' {$ifdef CONFIG_FEATURE_INSTALLER}, usrbin {$endif}));
end.
