#!/bin/bash
test $(curl 172.18.0.1:8765/sum?a=1\&b=2) -eq 3
