
AHIR=$(date -d 'yesterday' '+%Y/%m/%d')
MAIL_ALERTA='sistemas@grupointercom.com'
RUTA='/var/log/troncal'
SENDMAIL='/usr/sbin/sendmail -t'

QUAN="Caigudes (en realitat són aixecades) del dia $(date -d 'yesterday' '+%d/%m/%Y'):\n\n"

if [ -f $RUTA/$AHIR/10.200.0.20.log ]; then

F5GI1v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.20.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10) 

if [ ! -z "$F5GI1v2" ];
then
	echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-gi-1\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$QUAN$F5GI1v2</pre></body></html>" | $SENDMAIL
fi

fi




if [ -f $RUTA/$AHIR/10.200.0.21.log ]; then

F5GI2v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.21.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10) 

if [ ! -z "$F5GI2v2" ];
then
	echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-gi-2\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$QUAN$F5GI2v2</pre></body></html>" | $SENDMAIL
fi

fi



if [ -f $RUTA/$AHIR/10.200.0.22.log ]; then

F5EM1v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.22.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10)

if [ ! -z "$F5EM1v2" ];
then
        echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-em-1\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$QUAN$F5EM1v2</pre></body></html>" | $SENDMAIL
fi

fi



if [ -f $RUTA/$AHIR/10.200.0.23.log ]; then

F5EM2v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.23.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10)

if [ ! -z "$F5EM2v2" ];
then
        echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-em-2\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$QUAN$F5EM2v2</pre></body></html>" | $SENDMAIL
fi

fi




if [ -f $RUTA/$AHIR/10.200.0.24.log ]; then

F5TEST1v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.24.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10)

if [ ! -z "$F5TEST1v2" ];
then
        echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-test-1\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$F5TEST1v2</pre></body></html>" | $SENDMAIL
fi

fi


if [ -f $RUTA/$AHIR/10.200.0.25.log ]; then

F5TEST2v2=$(grep "monitor status up" $RUTA/$AHIR/10.200.0.25.log | awk '{print $9 " " $11 " " $19}' | sed -r 's/^\/Common\/(.*) \/Common\/(.*) (.*)hrs?:(.*)mins?:(.*)sec$/\1 \2 \3 \4 \5/' | awk '{hores[$1$2] += $3; minuts[$1$2] += $4; segons[$1$2] += $5; caigudes[$1$2]+=1; pool[$1$2]=$1; membre[$1$2]=$2 } END {for (i in hores) { total_segons[i]=(hores[i]*3600 + minuts[i]*60 + segons[i]); dies[i]=int(total_segons[i]/86400); hores[i]=int((total_segons[i] % 86400)/3600); minuts[i]=int(((total_segons[i] % 86400)%3600)/60); segons[i]=((total_segons[i] % 86400)%3600)%60; printf "%8s %30s %30s  %3s d  %2s h  %2s m  %2s s\n", caigudes[i], pool[i], membre[i],  dies[i], hores[i], minuts[i], segons[i] }}' | sort -rn -k1,1 -k4,4 -k6,6 -k8,8 -k10,10)

if [ ! -z "$F5TEST2v2" ];
then
        echo -e "To: $MAIL_ALERTA\nSubject: [XARXA] Caigudes pools i membres f5-test-2\nContent-Type: text/html; charset=\"us-ascii\"\n<html><body><pre>$F5TEST2v2</pre></body></html>" | $SENDMAIL
fi

fi

