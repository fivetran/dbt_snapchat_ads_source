{{ config(enabled=var('ad_reporting__snapchat_ads_enabled', true)) }}

select *
from {{ var('creative_url_tag_history') }}
