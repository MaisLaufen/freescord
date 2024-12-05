const String zapretPath = 'lib/domain/zapret';

const String binPath = '$zapretPath/bin';

const String winwsPath = '$binPath/winws.exe';

const String freescordVersion = '1.0.0';

const String zapretVersion = '1.6.1';

const List<String> defaultDiscordCommand = [
  '--wf-tcp=443',
  '--wf-udp=443,50000-50100',
  '--filter-udp=443',
  '--hostlist=$zapretPath/list-discord.txt',
  '--dpi-desync=fake',
  '--dpi-desync-repeats=6',
  '--dpi-desync-fake-quic=$binPath/quic_initial_www_google_com.bin',
  '--new',
  '--filter-udp=50000-50100',
  '--ipset=$zapretPath/ipset-discord.txt',
  '--dpi-desync=fake',
  '--dpi-desync-any-protocol',
  '--dpi-desync-cutoff=d3',
  '--dpi-desync-repeats=6',
  '--new',
  '--filter-tcp=443',
  '--hostlist=$zapretPath/list-discord.txt',
  '--dpi-desync=fake,split',
  '--dpi-desync-autottl=2',
  '--dpi-desync-repeats=6',
  '--dpi-desync-fooling=badseq',
  '--dpi-desync-fake-tls=$binPath/tls_clienthello_www_google_com.bin',
];
