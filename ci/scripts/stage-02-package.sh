#cd /opt/git/jackalope-jackrabbit.ci
ci/packaging/configure
make
mkdir -p ci/build/debs
mv /tmp/jackalope-jackrabbit/jackalope-jackrabbit_0.9.deb ci/build/debs
