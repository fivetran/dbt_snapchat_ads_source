#!/bin/bash

set -euo pipefail

apt-get update
apt-get install libsasl2-dev

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip setuptools
pip install -r integration_tests/requirements.txt
mkdir -p ~/.dbt
cp integration_tests/ci/sample.profiles.yml ~/.dbt/profiles.yml

db=$1
echo `pwd`
cd integration_tests
dbt deps
dbt seed --target "$db" --full-refresh
dbt run --target "$db" --full-refresh
dbt test --target "$db"
dbt run --vars '{ad_reporting__url_report__using_null_filter: false, snapchat_ads__using_campaign_region_report: true, snapchat_ads__using_campaign_country_report: true}' --target "$db" --full-refresh
dbt test --vars '{ad_reporting__url_report__using_null_filter: false, snapchat_ads__using_campaign_region_report: true, snapchat_ads__using_campaign_country_report: true}' --target "$db"
dbt run-operation fivetran_utils.drop_schemas_automation --target "$db"
