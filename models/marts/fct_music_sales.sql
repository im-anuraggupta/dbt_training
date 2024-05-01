{{
    config(
        materialized='table'
    )
}}


with 
invoice_lines as (
    select * from {{ ref('int_invoice_lines_joined_to_invoices') }}
),

customers_and_employees as (
    select * from {{ ref('int_customers_joined_to_employees') }}
),

tracks as (
    select * from {{ ref('int_tracks_joined_to_albums_artists_genre_mediatype') }}
),

joined as (
    select 
        ---- id columns
        invoice_lines.invoice_lineid,
        invoice_lines.invoice_id,
        invoice_lines.track_id,
        tracks.album_id,
        tracks.mediatype_id,
        tracks.genre_id,
        invoice_lines.customer_id,
        customers_and_employees.employee_id,

        ----sales related transformations
        invoice_lines.invoice_date_est,
        invoice_lines.billing_state,
        invoice_lines.billing_country,
        invoice_lines.quantity_purchased,
        invoice_lines.invoice_lineitem_revenue_usd,

        ---- tracks related informations
        tracks.track_name,
        tracks.track_composer,
        tracks.album_title,
        tracks.artist_name,
        tracks.mediatype_name,
        tracks.genre_name,
        tracks.track_length_ms,
        tracks.track_length_seconds,
        tracks.track_length_mins,
        tracks.bytes,
        customers_and_employees.customer_mailing_state,
        customers_and_employees.customer_mailing_country,
        customers_and_employees.customer_email_address,
        customers_and_employees.employee_name,
        customers_and_employees.employee_title,
        customers_and_employees.employee_city,
        customers_and_employees.employee_state,
        customers_and_employees.employee_country
    from invoice_lines
    left join customers_and_employees
        on invoice_lines.customer_id = customers_and_employees.customer_id
    left join tracks
        on invoice_lines.track_id = tracks.track_id
)

select * from joined 