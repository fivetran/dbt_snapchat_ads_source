{% macro get_campaign_hourly_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "android_installs", "datatype": dbt_utils.type_int()},
    {"name": "attachment_avg_view_time_millis", "datatype": dbt_utils.type_int()},
    {"name": "attachment_quartile_1", "datatype": dbt_utils.type_int()},
    {"name": "attachment_quartile_2", "datatype": dbt_utils.type_int()},
    {"name": "attachment_quartile_3", "datatype": dbt_utils.type_int()},
    {"name": "attachment_total_view_time_millis", "datatype": dbt_utils.type_int()},
    {"name": "attachment_view_completion", "datatype": dbt_utils.type_int()},
    {"name": "avg_screen_time_millis", "datatype": dbt_utils.type_int()},
    {"name": "avg_view_time_millis", "datatype": dbt_utils.type_int()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "conversion_add_billing", "datatype": dbt_utils.type_int()},
    {"name": "conversion_add_cart", "datatype": dbt_utils.type_int()},
    {"name": "conversion_app_opens", "datatype": dbt_utils.type_int()},
    {"name": "conversion_level_completes", "datatype": dbt_utils.type_int()},
    {"name": "conversion_page_views", "datatype": dbt_utils.type_int()},
    {"name": "conversion_purchases", "datatype": dbt_utils.type_int()},
    {"name": "conversion_purchases_value", "datatype": dbt_utils.type_int()},
    {"name": "conversion_save", "datatype": dbt_utils.type_int()},
    {"name": "conversion_searches", "datatype": dbt_utils.type_int()},
    {"name": "conversion_sign_ups", "datatype": dbt_utils.type_int()},
    {"name": "conversion_start_checkout", "datatype": dbt_utils.type_int()},
    {"name": "conversion_view_content", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "ios_installs", "datatype": dbt_utils.type_int()},
    {"name": "quartile_1", "datatype": dbt_utils.type_int()},
    {"name": "quartile_2", "datatype": dbt_utils.type_int()},
    {"name": "quartile_3", "datatype": dbt_utils.type_int()},
    {"name": "saves", "datatype": dbt_utils.type_int()},
    {"name": "screen_time_millis", "datatype": dbt_utils.type_int()},
    {"name": "shares", "datatype": dbt_utils.type_int()},
    {"name": "spend", "datatype": dbt_utils.type_int()},
    {"name": "story_completes", "datatype": dbt_utils.type_int()},
    {"name": "story_opens", "datatype": dbt_utils.type_int()},
    {"name": "swipe_up_percent", "datatype": dbt_utils.type_int()},
    {"name": "swipes", "datatype": dbt_utils.type_int()},
    {"name": "total_installs", "datatype": dbt_utils.type_int()},
    {"name": "video_views", "datatype": dbt_utils.type_int()},
    {"name": "view_completion", "datatype": dbt_utils.type_int()},
    {"name": "view_time_millis", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
