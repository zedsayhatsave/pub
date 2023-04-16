#!/bin/bash

set +x
CUR_BR=draft0
WORK_BR=draft1
WD=$(date +%Y%m%d_%H%M%S)


which_check() {
 which wget || true
 which curl || true
 which chrome || true
 which goole-chrome || true
 which firefox || true
 which edge || true
 which lynx || true
 which links || true
 which w3m || true
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
 mkdir $WD
 cd $WD
 echo $WD > report.txt
}


git_update_push_work() {
 git add $WD/report.txt --sparse
 git status
 git commit -am .
 git push origin $(WORK_BR)
}


git_clean() {
  git checkout ${CUR_BR}
  git clean -df
}


which_check
git_config
# git_test_report_update_push
git_sparse_checkout_work
work
git_update_push_work
git_clean
