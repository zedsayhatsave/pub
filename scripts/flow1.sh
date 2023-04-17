#!/bin/bash

set +x
CUR_BR=draft0
WORK_BR=draft1
SCR_MV_DIR=scripts_mv
#WD=$(date +%Y%m%d_%H%M%S)
WD=temp



which_version_check() {
 # https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md
 
 which wget || true
 which curl || true

 chromium --version
 chromedriver --version
 which chromium || true
 which goole-chrome || true
 #which chromedriver || true
 
 firefox --version
 geckodriver --version
 #which firefox || true
 #which firefoxdriver || true
 #which geckodriver || true
 
 microsoft-edge --version
 msedgedriver --version
 #which microsoft-edge || true
 #which msedgedriver  || true
 
 #which lynx || true
 #which links || true
 #which links2 || true
 #which w3m || true
 
 python3 --version
 # pip3 list
 
#export CHROMEWEBDRIVER
#export EDGEWEBDRIVER
#export GECKOWEBDRIVER
#export SELENIUM_JAR_PATH
}


git_config() {
 git branch
 git status
 git config user.name 'action'
 git config user.email 'action'
}


git_test_report_update_push() {
 echo $WD > report.txt
 git add report.txt
 git commit -am .
 git push
}


git_sparse_checkout_work() {
 git branch
 git status
 ls
 git sparse-checkout init --cone
 git sparse-checkout set .
 ls
 git status
 git fetch --depth 1 origin ${WORK_BR}
 git branch ${WORK_BR} origin/${WORK_BR}
 git checkout ${WORK_BR}
 ls
 git status
}


work() {
 echo WD: $WD
 mkdir $WD || true
 cd $WD
 echo $WD > report.txt
 
 # chromium --headless=new --dump-dom --timeout 10000 <url> > page.html

 python3 -m pip --disable-pip-version-check install selenium==4.8.3 --quiet 
 python3 ../${SCR_MV_DIR}/flow1.py || true
 
 cd ..
}


git_update_push_work() {
 # git add $WD/report.txt --sparse
 git add $WD/* --sparse
 git status
 git commit -am .
 git push origin ${WORK_BR}
}


git_clean() {
  git checkout ${CUR_BR}
  git clean -df
}


which_version_check
git_config

if true; then
 mv scripts ${SCR_MV_DIR}
 # git_test_report_update_push
 git_sparse_checkout_work
 work
 git_update_push_work
 git_clean
fi
