#! /usr/bin/env python
# avahi-alias.py

import avahi, dbus
from encodings.idna import ToASCII

# Got these from /usr/include/avahi-common/defs.h
CLASS_IN = 0x01
TYPE_CNAME = 0x05

TTL = 60

def IP2Int(ip):
    o = map(int, ip.split('.'))
    res = (16777216 * o[0]) + (65536 * o[1]) + (256 * o[2]) + o[3]
    return res
    
def publish_cname(cname):
    bus = dbus.SystemBus()
    server = dbus.Interface(bus.get_object(avahi.DBUS_NAME, avahi.DBUS_PATH_SERVER),
            avahi.DBUS_INTERFACE_SERVER)
    group = dbus.Interface(bus.get_object(avahi.DBUS_NAME, server.EntryGroupNew()),
            avahi.DBUS_INTERFACE_ENTRY_GROUP)

    rdata = createRR(server.GetHostNameFqdn())
    
    cname = encode_dns(cname)

    group.AddRecord(avahi.IF_UNSPEC, avahi.PROTO_UNSPEC, dbus.UInt32(0),
        cname, CLASS_IN, TYPE_CNAME, TTL, rdata)
    group.Commit()


def encode_dns(name):
    out = []
    for part in name.split('.'):
        if len(part) == 0: continue
        out.append(ToASCII(part))
    return '.'.join(out)

def createRR(name):
    out = []
    for part in name.split('.'):
        if len(part) == 0: continue
        out.append(chr(len(part)))
        out.append(ToASCII(part))
    out.append('\0')
    return ''.join(out)

def advertise_cnames():
    try:
        hosts_file = open("/home/avahi/hosts_list", "r")
        content = [x.strip('\n') for x in hosts_file.readlines()]
        hosts_file.close()
        delay = 1
        while 1:
                time.sleep(delay)
                for each in content:
                        #print " host %s" % (each)
                        name = unicode(each, locale.getpreferredencoding())
                        print " Publish %s" % (name)
                        publish_cname(name)
                # Just loop forever
                delay = 60
    except KeyboardInterrupt:
        print "Reloading"
        return


if __name__ == '__main__':
    import time, sys, locale, os
    pid = os.getpid()
    pid_file = open("/home/engines/run/avahi-publisher.pid", "w+")
    s = str(pid)
    pid_file.write(s)
    pid_file.close()
    while 1:
        try:
                advertise_cnames()
        except KeyboardInterrupt:
                print "Reloading"
                continue
        continue

