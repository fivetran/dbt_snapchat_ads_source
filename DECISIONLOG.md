# Snapchat Ads Source Decision Log
## Filtering for the most recent record 
We filter for `is_most_recent_record` using `_fivetran_synced` rather than `updated_at` due to cases where the `updated_at` field is null, in which the partition wouldn't be able to work. The exception is for the `stg_snapchat_ads__creative_url_tag_history` model where `_fivetran_synced` is not an existing field.

The unique combination tests are also done using each table's primary key and `_fivetran_synced` instead of `updated_at`, for the same reason.

## Selecting which columns to include from the source tables
Snapchat passes many fields; in order to eliminate clutter we made a judgement call on which fields to include in our models. For fields that you wish to use that aren't included by default, refer to the [passthrough column feature](https://github.com/fivetran/dbt_snapchat_ads_source/blob/feature/v2_updates/README.md#passing-through-additional-metrics). 