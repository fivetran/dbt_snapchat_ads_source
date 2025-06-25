# dbt_snapchat_ads_source v0.9.0

[PR #28](https://github.com/fivetran/dbt_snapchat_ads_source/pull/28) includes the following updates:

## Breaking Change for dbt Core < 1.9.6
> *Note: This is not relevant to Fivetran Quickstart users.*

Migrated `freshness` from a top-level source property to a source `config` in alignment with [recent updates](https://github.com/dbt-labs/dbt-core/issues/11506) from dbt Core. This will resolve the following deprecation warning that users running dbt >= 1.9.6 may have received:

```
[WARNING]: Deprecated functionality
Found `freshness` as a top-level property of `snapchat_ads` in file
`models/src_snapchat_ads.yml`. The `freshness` top-level property should be moved
into the `config` of `snapchat_ads`.
```

**IMPORTANT:** Users running dbt Core < 1.9.6 will not be able to utilize freshness tests in this release or any subsequent releases, as older versions of dbt will not recognize freshness as a source `config` and therefore not run the tests.

If you are using dbt Core < 1.9.6 and want to continue running Snapchat Ads freshness tests, please elect **one** of the following options:
  1. (Recommended) Upgrade to dbt Core >= 1.9.6
  2. Do not upgrade your installed version of the `snapchat_ads_source` package. Pin your dependency on v0.8.0 in your `packages.yml` file.
  3. Utilize a dbt [override](https://docs.getdbt.com/reference/resource-properties/overrides) to overwrite the package's `snapchat_ads` source and apply freshness via the [old](https://github.com/fivetran/dbt_snapchat_ads_source/blob/v0.8.0/models/src_snapchat.yml#L10-L12) top-level property route. This will require you to copy and paste the entirety of the `src_snapchat_ads.yml` [file](https://github.com/fivetran/dbt_snapchat_ads_source/blob/v0.8.0/models/src_snapchat.yml#L4-L479) and add an `overrides: snapchat_ads_source` property.

## Under the Hood
- Updated the package maintainer PR template.

# dbt_snapchat_ads_source v0.8.0
[PR #27](https://github.com/fivetran/dbt_snapchat_ads_source/pull/27) includes the following updates:

## Schema Updates

**5 total changes • 0 breaking changes**
| **Data Model** | **Change type** | **Old name** | **New name** | **Notes** |
| ---------------- | --------------- | ------------ | ------------ | --------- |
| [stg_snapchat_ads__campaign_geo_country_daily_report](https://fivetran.github.io/dbt_snapchat_ads_source/#!/model/model.snapchat_ads_source.stg_snapchat_ads__campaign_geo_country_daily_report) | New Staging Model |   |   |  Uses `campaign_geo_country_daily_report` source table  |
| [stg_snapchat_ads__campaign_geo_region_daily_report](https://fivetran.github.io/dbt_snapchat_ads_source/#!/model/model.snapchat_ads_source.stg_snapchat_ads__campaign_geo_region_daily_report) | New Staging Model |   |   |  Uses `campaign_geo_region_daily_report` source table  |
| [stg_snapchat_ads__campaign_geo_country_daily_report_tmp](https://fivetran.github.io/dbt_snapchat_ads/#!/model/model.snapchat_ads_source.stg_snapchat_ads__campaign_geo_country_daily_report_tmp) | New Temp Model |   |   |  Uses `campaign_geo_country_daily_report` source table  |
| [stg_snapchat_ads__campaign_geo_region_daily_report_tmp](https://fivetran.github.io/dbt_snapchat_ads/#!/model/model.snapchat_ads_source.stg_snapchat_ads__campaign_geo_region_daily_report_tmp) | New Temp Model |   |   |  Uses `campaign_geo_region_daily_report` source table  |
| [stg_snapchat_ads__campaign_history](https://fivetran.github.io/dbt_snapchat_ads_source/#!/model/model.snapchat_ads_source.stg_snapchat_ads__campaign_history) | New Columns |   |  `daily_budget_micro`, `start_time`, `end_time`, `lifetime_spend_cap_micro`, `status`, `objective`  |    |

Please note that these are disabled by default for dbt Core users. To enable them, add the following configuration to your root `dbt_project.yml` file. For more information on how to configure this, refer to the [README](https://github.com/fivetran/dbt_snapchat_ads_source/tree/main?tab=readme-ov-file#enabling-models-that-are-disabled-by-default).


```yml
vars:
    snapchat_ads__using_campaign_country_report: true # Necessary for the stg_snapchat_ads__campaign_geo_country_daily_report model. False by default. Requires the campaign_geo_country_daily_report source table
    snapchat_ads__using_campaign_region_report: true # Necessary for the stg_snapchat_ads__campaign_geo_region_daily_report model. False by default. Requires the campaign_geo_region_daily_report source table
```

## Feature Updates
- Introduced the following variables for each respective new staging model in order to pass through additional metrics from their corresponding source tables:
  - `snapchat_ads__campaign_daily_country_report_passthrough_metrics`
  - `snapchat_ads__campaign_daily_region_report_passthrough_metrics`
For more information on how to configure this, refer to the [README](https://github.com/fivetran/dbt_snapchat_ads_source/tree/main?tab=readme-ov-file#passing-through-additional-metrics).

## Documentation Updates
- Updated field descriptions to make more accurate.

# dbt_snapchat_ads_source v0.7.0
[PR #24](https://github.com/fivetran/dbt_snapchat_ads_source/pull/24) includes the following **BREAKING CHANGE** updates:

## Feature Updates: Conversion Support
We have added more robust support for conversions in our data models by doing the following:

- Created a `snapchat_ads__conversion_fields` variable to pass through additional conversion fields in the `stg_snapchat_ads__ad_hourly_report`,`stg_snapchat_ads__ad_squad_hourly_report` and `stg_snapchat_ads__campaign_hourly_report` models.
  - By default, `snapchat_ads__conversion_fields` will bring in the most used conversion field, `conversion_purchases`. See the [README](https://github.com/fivetran/dbt_snapchat_ads_source/tree/main?tab=readme-ov-file#configuring-conversion-fields) for details on how to adjust this.
- Brought in the `conversion_purchases_value` field to the above mentioned  `stg_snapchat_ads__*_hourly_report` models.
> **IMPORTANT**: The above new field additions are **breaking changes** for users who were not already bringing in conversion fields via passthrough columns.

## Documentation Update 
- Documented how to use the new `snapchat_ads__conversion_fields` variable [here](https://github.com/fivetran/dbt_snapchat_ads_source/tree/main?tab=readme-ov-file#configuring-conversion-fields).
- Added new metrics to `src` and `stg` yml files.

## Under the Hood
- Updated `snapchat_*_hourly_report_data` seed files with relevant conversion fields for more robust testing. 
- Ensured backwards compatibility with existing passthrough column frameworks by creating `snapchat_ads_add_pass_through_columns` and `snapchat_ads_fill_pass_through_columns` macro checks for whether these conversion fields are already brought in by the existing [passthrough variables](https://github.com/fivetran/dbt_snapchat_ads_source/tree/main?tab=readme-ov-file#passing-through-additional-metrics). This ensures there are no duplicate column errors if both the new conversion variable and the old passthrough variable are leveraged in any `stg_snapchat_ads__*_hourly_report*` data model.

## Contributors
- [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation)

# dbt_snapchat_ads_source v0.6.0
[PR #20](https://github.com/fivetran/dbt_snapchat_ads_source/pull/20) includes the following updates:
## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple snapchat_ads connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_snapchat_ads_source/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- Updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro.
- Updated tests to account for the new `source_relation` column.

[PR #17](https://github.com/fivetran/dbt_snapchat_ads_source/pull/17) includes the following updates:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).

# dbt_snapchat_ads_source v0.5.0
## 🚨 Breaking Changes 🚨:
[PR #15](https://github.com/fivetran/dbt_snapchat_ads_source/pull/15) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

# dbt_snapchat_ads_source v0.4.0
PR [#13](https://github.com/fivetran/dbt_snapchat_ads_source/pull/13) applies the Ad Reporting V2 updates:

## 🚨 Breaking Changes 🚨
- Changes `snapchat_schema` and `snapchat_database` variable names to `snapchat_ads_schema` and `snapchat_ads_database` 
- Updates model names to prefix with `snapchat_ads`
## 🎉 Feature Enhancements 🎉
- Adds the `ad_squad_hourly_report` and `campaign_hourly_report` source tables and accompanying staging models
- Adds the field descriptions and grain uniqueness tests for the new models 
- Adds additional fields to existing models 
- Applies README standardization updates
- Introduces the identifier variable for all source models
- Casts all timestamp fields using dbt_utils.type_timestamp()
- Inclusion of passthrough metrics:
  - `snapchat_ads__ad_hourly_passthrough_metrics`
  - `snapchat_ads__ad_squad_hourly_passthrough_metrics`
  - `snapchat_ads__campaign_hourly_report_passthrough_metrics`
> This applies to all passthrough columns within the `dbt_snapchat_ads_source` package and not just the `snapchat_ads__ad_hourly_passthrough_metrics` example.
```yml
vars:
  snapchat_ads__ad_hourly_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```
- Add enable configs for this specific ad platform, for use in the Ad Reporting rollup package 

# dbt_snapchat_ads_source v0.3.1
## Bug Fixes
- Includes `updated_at` in uniqueness tests on `stg_snapchat__creative_url_tag_history`. This was originally missing, causing erroneous uniqueness test failures on this history table ([#10](https://github.com/fivetran/dbt_snapchat_ads_source/issues/10)).

# dbt_snapchat_ads_source v0.3.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_snapchat_ads_source v0.1.0 -> v0.2.1
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
