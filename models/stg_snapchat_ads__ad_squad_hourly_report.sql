
with base as (

    select * 
    from {{ ref('stg_snapchat_ads_source__ad_squad_hourly_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads_source__ad_squad_hourly_report_tmp')),
                staging_columns=get_ad_squad_hourly_report_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        ad_squad_id,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        attachment_total_view_time_millis,
        attachment_view_completion,
        date,
        impressions,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        screen_time_millis,
        shares,
        spend,
        swipes,
        total_installs,
        video_views,
        view_completion,
        view_time_millis
    from fields
)

select *
from final
