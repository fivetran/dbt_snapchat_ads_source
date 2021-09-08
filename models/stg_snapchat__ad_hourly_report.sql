
with base as (

    select * 
    from {{ ref('stg_snapchat__ad_hourly_report_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat__ad_hourly_report_tmp')),
                staging_columns=get_ad_hourly_report_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        ad_id,
        date as date_hour,
        impressions,
        (spend / 1000000.0) as spend,
        swipes
    from fields
)

select * from final
