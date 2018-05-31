# lynx --dump -width=999 devlog_grs1040.html     | sed -f sed_log_parse.sed | sort | uniq   >  grs1040_devlog_uniq.txt
# lynx --dump -width=999 devlog_msp30.html       | sed -f sed_log_parse.sed | sort | uniq   >  msp30_devlog_uniq.txt
# lynx --dump -width=999 msp40_07002_devlog.html | sed -f sed_log_parse.sed | sort | uniq   >  msp40_07002_devlog_uniq.txt
# lynx --dump -width=999 devlog_dragon.html      | sed -f sed_log_parse.sed | sort | uniq   >  dragon_07200_devlog_uniq.txt

#==>output:
#Critical  [CLI tCliSessionTeln 0x0012002b] CLI-Input: socket operation read failed with error code 62

#Debug     [DOS nim_t 0x80000229] DoS Activate Startup done

#Error     [WATSON nimStartup_t 0x000d003e] Measured system boot time = ~~removed~~ ms

#remove first line "Devel Log"
s/^.*Devel Log$//

#remove useless info
# "    229134.         0: Notice    Jan 1 2018 01:00:35 "  -->  "Notice"
s/[ \t]*[0-9]*\.[ \t]*[0-9]*: \([a-zA-Z]*\)\( *\).*\[/\1\2[/

#remove repeated logs
s/.*The last message was repeated [0-9]* time.*//

#remove several L2 mcast debug info
s/\(.*Found empty config ID\).*/\1/

#remove several FDB delete warnings
s/\(.*received delete for unexpected FDB entry\).*/\1/


s/\(.*Measured system boot time =\).*/\1 ~~removed~~ ms/

s/\(.*Log init done after \).*/\1 ~~removed~~ ms/

s/\(.*Watson system monitor started. \).*/\1 ~~removed~~ /

s/\(.*STP port state changed to discarding on interface \).*/\1 ~~removed~~ /
s/\(.*STP Topology Change Notification received on interface \).*/\1 ~~removed~~ /
s/\(.*STP port state changed to Forwarding on interface \).*/\1 ~~removed~~ /
s/\(.*New Root Bridge elected on interface \).*/\1 ~~removed~~ /
s/\(.*This Bridge was elected as Root Bridge\).*/\1 ~~removed~~ /
s/\(.*Bridge Tx Hold Count limit reached on interface: \).*/\1 ~~removed~~ /

s/\(.*VLAN ID\) [0-9]* \(to port based routing interface\).*/\1 ~~removed~~ \2 ~~removed~~ /

s/\(.*OSPFv2 neighbor\) .* \(moved from state\).*/\1 ~~removed~~ \2 ~~removed~~ /

s/\(.*sshdListenTask\) .* \(started, exited\).*/\1 removed \2 ~~removed~~ /

s/\(.*New neighbour detected \).*/\1 ~~removed~~ /

#PIM-SM
s/\(.*Neighbor\) .* \(expired on interface\).*/\1 ~~removed~~ \2 ~~removed~~ /
s/\(.*The new elected DR is\) .* \(on interface\).*/\1 ~~removed~~ \2 ~~removed~~ /


s/\(.*Successful installation of ACL\).*/\1 ~~removed~~ /

s/\(.*System time set to\).*/\1 ~~removed~~ /

s/\(.*Sending TIMERANGE_EVENT_.* notification for time-range\).*/\1 ~~removed~~ /


s/\(.*Info: CFR2 \).*/\1 ~~removed~~ /
s/\(.*Info: HDCI \).*/\1 ~~removed~~ /
s/\(.*Info: USAI \).*/\1 ~~removed~~ /
s/\(.*Info: NIMP \).*/\1 ~~removed~~ /
s/\(.*Info: DEFF \).*/\1 ~~removed~~ /

#remove empty lines
#s/^\s*$//