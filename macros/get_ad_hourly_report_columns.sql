{% macro get_ad_hourly_report_columns() %}

{% set columns = [
    {"name": "ad_id", "datatype": dbt_utils.type_string()},
    {"name": "attachment_quartile_1", "datatype": dbt_utils.type_numeric()},
    {"name": "attachment_quartile_2", "datatype": dbt_utils.type_numeric()},
    {"name": "attachment_quartile_3", "datatype": dbt_utils.type_numeric()},
    {"name": "attachment_total_view_time_millis", "datatype": dbt_utils.type_numeric()},
    {"name": "attachment_view_completion", "datatype": dbt_utils.type_numeric()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "impressions", "datatype": dbt_utils.type_numeric()},
    {"name": "quartile_1", "datatype": dbt_utils.type_numeric()},
    {"name": "quartile_2", "datatype": dbt_utils.type_numeric()},
    {"name": "quartile_3", "datatype": dbt_utils.type_numeric()},
    {"name": "saves", "datatype": dbt_utils.type_numeric()},
    {"name": "screen_time_millis", "datatype": dbt_utils.type_numeric()},
    {"name": "shares", "datatype": dbt_utils.type_numeric()},
    {"name": "spend", "datatype": dbt_utils.type_numeric()},
    {"name": "swipes", "datatype": dbt_utils.type_numeric()},
    {"name": "video_views", "datatype": dbt_utils.type_numeric()},
    {"name": "view_completion", "datatype": dbt_utils.type_numeric()},
    {"name": "view_time_millis", "datatype": dbt_utils.type_numeric()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('snapchat_ads__ad_hourly_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
