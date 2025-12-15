#!/bin/bash
h=$(date +%H); m=$(date +%M); s=$(date +%S); tobin(){ printf "%06d" "$(echo "obase=2;$1" | bc)"; }; bH=$(tobin $h); bM=$(tobin $m); bS=$(tobin $s); line=""; for x in $bH $bM $bS; do for ((i=0;i<${#x};i++)); do [[ ${x:$i:1} == 1 ]] && line+="●" || line+="○"; done; line+=" "; done; echo "$line"
