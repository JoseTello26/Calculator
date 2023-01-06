#!/bin/bash
test $(curl 192.168.49.2:8765/sum?a=1\&b=2) -eq 3
