# fetch changes from uaa
git submodule update --remote
# build local & run tests
bundle install && bundle exec rake
# build release (note the name)
UAA_VERSION=0.0.0 bosh create-release --force --name=rluaa
# upload relese
bosh upload-release --rebase --name=rluaa
# update release version in ops file
export OPS_FOLDER=$(PWD)/src/acceptance_tests/opsfiles
sed -i '' "s/[0-9.]*+dev.[0-9]*/$(bosh releases | grep rluaa | head -1 | grep -E -o '[0-9.]+\+dev.[0-9]+')/g" $OPS_FOLDER/additional-uaa.yaml