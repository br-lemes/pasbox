{$include config.inc}

unit a_pwd;

interface

uses global;

type
	Tpwd = class (TApplet)
		procedure exec; override;
	end;

implementation

procedure Tpwd.exec;
var s: string;
begin
{$ifdef CONFIG_SHOW_USAGE}
	if (paramcount >= paramstart) and (paramstr(paramstart) = '--help') then
	begin
		write(stderr, copying, line);
		write(stderr, line);
		write(stderr, usage, 'pwd', line);
		write(stderr, line);
		write(stderr, 'Print the full filename of the current working directory', line);
		halt(1);
	end;
{$endif}
	getdir(0, s);
	writeln(s);
end;

initialization
	multicall.add(Tpwd.create('pwd' {$ifdef CONFIG_FEATURE_INSTALLER}, bin {$endif}));
end.
