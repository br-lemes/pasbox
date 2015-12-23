{$include config.inc}

unit a_basename;

interface

uses global;

type
	Tbasename = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Tbasename.exec;
var
	n, s: string;
	i, j: integer;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount < paramstart) or (paramcount > paramstart + 1) or (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'basename FILE [SUFFIX]', line);
		write(stderr, line);
		write(stderr, 'Strip directory path and .SUFFIX from FILE', line);
		halt(1);
	end;
{$endif}
	n := paramstr(paramstart); { FILE }
	i := length(n);
	while (i > 0) and (n[i] in ['/', '\']) do
		dec(i);
	j := i;
	while (i > 0) and not (n[i] in ['/', '\']) do
		dec(i);
	if (i = 0) and (n[1] in ['/', '\']) then
		dec(i);
	n := copy(n, i + 1, j - i);
	if (paramcount = paramstart) then
		writeln(n)
	else begin
		s := paramstr(paramstart + 1); { [SUFFIX] }
		i := length(n);
		j := length(s);
		if copy(n, i - j + 1, j) = s then
			writeln(copy(n, 1, i - j))
		else
			writeln(n);
	end;
end;

initialization
	multicall.add(Tbasename.create('basename' {$ifdef CONFIG_FEATURE_INSTALLER}, usrbin {$endif}));
end.
