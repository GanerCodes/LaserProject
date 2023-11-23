1. Make sure you are using a linux environment
2. Install npm, python, c++ build tools (gcc, make, etc.)
3. Run the following commands:
```shell
git clone --recurse-submodules https://github.com/GanerCodes/LaserProject
cd ./LaserProject
cd ./Building/cpy/build+test/
sh ./build.sh
cd -
./Building/cpy/bin/cpy_binary -m pip install -r requirements.txt
sh ./build
```
After running ./build, open `http://localhost:8000` in your browser.
