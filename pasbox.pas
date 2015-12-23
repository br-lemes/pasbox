{$include config.inc}

program pasbox;

{$include uses.inc}

var
	i: longint;
begin
	appletname := {$if declared(argv)}argv[0]{$else}paramstr(0){$endif};
	i := length(appletname);
	while (i > 0) and not (appletname[i] in ['/','\']) do
		dec(i);
	if copy(appletname, length(appletname) - 3, 1) = '.' then
		appletname := copy(appletname, i + 1, length(appletname) - 4)
	else
		appletname := copy(appletname, i + 1, maxint);
	if (appletname = 'pasbox') and (paramcount >= 1) then
	begin
		paramstart := 2;
		appletname := paramstr(1);
	end;
	if (appletname = 'pasbox') or (appletname = '--help') then
	begin
		writeln(copying);
	{$ifdef CONFIG_SHOW_USAGE}
		writeln(usage, 'pasbox [function [arguments]...]');
		writeln('   or: pasbox --list' {$ifdef CONFIG_FEATURE_INSTALLER}, '[-full]' {$endif});
	{$ifdef CONFIG_FEATURE_INSTALLER}
		writeln('   or: pasbox --install [-s] [DIR]');
	{$endif}
		writeln('   or: function [arguments]...');
		writeln;
	{$endif}
		writeln('PasBox is a multi-call binary similar to BusyBox implemented in Free');
		writeln('Pascal as a demonstration project to show that things could be simpler.');
		writeln;
		writeln('Currently defined functions:');
		multicall.list(listwide);
	end	else if appletname = '--list' then multicall.list(listplain)
{$ifdef CONFIG_FEATURE_INSTALLER}
	else if appletname = '--list-full' then multicall.list(listfull)
{	else if appletname = '--install' then _install }
{$endif}
	else if not multicall.exec(appletname) then
	begin
		write(stderr, appletname, ': applet not found', line);
		halt(1);
	end;
end.
