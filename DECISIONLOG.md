# Snapchat Ads Source Decision Log
## Filtering for the most recent record 
We filter for `is_most_recent_record` using `_fivetran_synced` rather than `updated_at` due to cases where the `updated_at` field is null, in which the partition wouldn't be able to work. The exception is for the `stg_snapchat_ads__creative_url_tag_history` model where `_fivetran_synced` is not an existing field.