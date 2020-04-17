#!/bin/bash

set -x
set -e

SETUP_DIR=$(dirname "$0")
SETUP_DIR=$(realpath $SETUP_DIR)

chmod +x $SETUP_DIR/hlds_l_3111_full.bin
echo yes | $SETUP_DIR/hlds_l_3111_full.bin
tar xzvf hlds_l_3111_full.tar.gz > /dev/null
tar xzvf $SETUP_DIR/hlds_l_3111e_update.tar.gz > /dev/null
cd hlds_l
tar xzvf $SETUP_DIR/cs_15_full.tar.gz > /dev/null

cd valve
rm valvecomm.lst
cp $SETUP_DIR/valvecomm.lst .
cd ..

# disable secure server
sed -i "s/secure.*$/secure \"0\"/g" cstrike/liblist.gam

touch nowon.c
echo "int NET_IsReservedAdr(){return 1;}" > nowon.c
gcc -c nowon.c -o nowon.o
ld -shared -o nowon.so nowon.o
#gcc -m32 -s -O3 -D_GNU_SOURCE -fPIC -shared -ldl -o nowon.so nowon.c

rm start.sh || /bin/true
touch start.sh
echo "#!/bin/bash" > start.sh
echo "" >> start.sh
echo 'cd "$(dirname "$0")"' >> start.sh
echo "./hlds_run -game cstrike -nomaster +map de_dust +maxplayers 16 +port 27015 +sv_lan 1 +rcon_password itsme" >> start.sh
echo "" >> start.sh
chmod +x start.sh

unzip -o $SETUP_DIR/hlds_20040707fix-c.zip
gcc -s -O3 -D_GNU_SOURCE -fPIC -shared -ldl -o hlds_20040707fix.so hlds_20040707fix.c

CURRENT_DIR=$(pwd)
sed -i "/export LD_.*$/a export LD_PRELOAD=\"$CURRENT_DIR/nowon.so\"" hlds_run
#sed -i "/export LD_.*$/a export LD_PRELOAD=\"$CURRENT_DIR/nowon.so $CURRENT_DIR/hlds_20040707fix.so\"" hlds_run
