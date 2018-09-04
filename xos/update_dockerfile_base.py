#! /usr/bin/python

import os

BASE_DIR=os.path.expanduser("~/cord/orchestration/xos_services")
PROFILES_DIR=os.path.expanduser("~/cord/orchestration/profiles")
XOS_DIR=os.path.expanduser("~/cord/orchestration/xos")

def patch_dockerfile(fn):
    lines = open(fn).readlines()
    new_lines=[]
    for line in lines:
        if line.startswith("FROM xosproject/xos-"):
            (firstpart, version) = line.strip().split(":",1)
            if (version != "candidate"):
                old_line = line
                line = firstpart + ":" + "candidate\n"
                print "modify %s: '%s' --> '%s'" % (fn, old_line.strip(), line.strip()) 
        new_lines.append(line)

    if new_lines != lines:
        print "save", fn
        open(fn,"w").writelines(new_lines)

for service_fn in os.listdir(BASE_DIR):
    if service_fn.startswith("."):
        continue
    service_dir = os.path.join(BASE_DIR, service_fn)
    if not os.path.isdir(service_dir):
        continue
    dockerfile_fn = os.path.join(service_dir, "Dockerfile.synchronizer")
    if not os.path.exists(dockerfile_fn):
        continue
    patch_dockerfile(dockerfile_fn)

patch_dockerfile(os.path.join(PROFILES_DIR, "rcord", "Dockerfile.synchronizer"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.libraries"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.synchronizer-base"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.client"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.xos-core"))
