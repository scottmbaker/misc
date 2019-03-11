#! /usr/bin/python

import os

CORD_DIR=os.path.expanduser(os.environ.get("CORD_DIR", "~/projects/opencord"))  
BASE_DIR=os.path.expanduser(CORD_DIR + "/orchestration/xos-services")
XOS_DIR=os.path.expanduser(CORD_DIR + "/orchestration/xos")
TOSCA_DIR=os.path.expanduser(CORD_DIR + "/orchestration/xos-tosca")

def patch_dockerfile(fn):
    lines = open(fn).readlines()
    needs_fixup = False
    for line in lines:
        if line.startswith("FROM xosproject/xos-"):
            (firstpart, version) = line.strip().split(":",1)
            if (version == "candidate"):
                needs_fixup = True

    if needs_fixup:
        print "fixup", fn
        os.system("chdir %s && git checkout %s" % (os.path.dirname(fn), os.path.basename(fn)))

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

#patch_dockerfile(os.path.join(PROFILES_DIR, "rcord", "Dockerfile.synchronizer"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.libraries"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.synchronizer-base"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.client"))
patch_dockerfile(os.path.join(XOS_DIR, "containers", "xos", "Dockerfile.xos-core"))
patch_dockerfile(os.path.join(TOSCA_DIR, "Dockerfile"))
