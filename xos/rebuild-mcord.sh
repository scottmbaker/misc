pushd ~/cord/orchestration/xos-services/progran
sudo docker build -t xosproject/progran-synchronizer:candidate -f Dockerfile.synchronizer .
cd ../vspgwc
sudo docker build -t xosproject/vspgwc-synchronizer:candidate -f Dockerfile.synchronizer .
cd ../vspgwu
sudo docker build -t xosproject/vspgwu-synchronizer:candidate -f Dockerfile.synchronizer .
cd ../hss_db
sudo docker build -t xosproject/hssdb-synchronizer:candidate -f Dockerfile.synchronizer .
cd ../epc-service
sudo docker build -t xosproject/vepc-synchronizer:candidate -f Dockerfile.synchronizer .  
cd ../internetemulator
sudo docker build -t xosproject/internetemulator-synchronizer:candidate -f Dockerfile.synchronizer . 
cd ../sdn-controller
sudo docker build -t xosproject/sdncontroller-synchronizer:candidate -f Dockerfile.synchronizer . 
cd ../vhss
sudo docker build -t xosproject/vhss-synchronizer:candidate -f Dockerfile.synchronizer . 
cd ../vmme
sudo docker build -t xosproject/vmme-synchronizer:candidate -f Dockerfile.synchronizer .  
cd ../../profiles/mcord
sudo docker build -t xosproject/mcord-synchronizer:candidate -f Dockerfile.synchronizer .
popd
