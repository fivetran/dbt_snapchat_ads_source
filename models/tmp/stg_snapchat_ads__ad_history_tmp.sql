{{ config(enabled=var('ad_reporting__snapchat_ads_enabled', true)) }}

select *
from {{ var('ad_history') }}
