{{ config(enabled=var('ad_reporting__snapchat_ads_enabled', true)) }}

with base as (

    select * 
    from {{ ref('stg_snapchat_ads__ad_squad_hourly_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads__ad_squad_hourly_report_tmp')),
                staging_columns=get_ad_squad_hourly_report_columns()
            )
        }}        
    from base
),

final as (
    
    select 
        ad_squad_id,
        cast (date as {{ dbt.type_timestamp() }}) as date_hour,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        (attachment_total_view_time_millis / 1000000.0) as attachment_total_view_time,
        attachment_view_completion,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        shares,
        (screen_time_millis / 1000000.0) as screen_time,
        video_views,
        view_completion,
        (view_time_millis / 1000000.0) as view_time,
        impressions,
        (spend / 1000000.0) as spend,
        swipes

        {{ fivetran_utils.fill_pass_through_columns('snapchat_ads__ad_squad_hourly_passthrough_metrics') }}
    
    from fields
)

select *
from final
