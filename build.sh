
fan compilerDoc -all
cp -r ../fanx/env/doc/* apidoc/

cd src
fan build.fan
cd -
