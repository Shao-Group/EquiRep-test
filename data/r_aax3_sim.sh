dir=tmp

rm -r $dir
mkdir $dir
mkdir ./$dir/full_10 ./$dir/full_20

# echo "g++ -o full_sim full_sim.cpp -std=c++11"
g++ -o aax3_full_sim aax3_full_sim.cpp -std=c++11

./aax3_full_sim $dir