#!/bin/sh

echo -n $1'Cg==' | sed 's?thunder://??' | base64 -d | sed 's/^AA//; s/ZZ$//'
