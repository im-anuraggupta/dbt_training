{{
    config(
        materialized='table'
    )
}}

with
tracks as (
    select * from {{ ref('int_tracks_joined_to_albums_artists_genre_mediatype') }}
),

joined as (
    select
        tracks.track_id,
        tracks.album_id,
        tracks.mediatype_id,
        tracks.genre_id,
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
        tracks.unit_price
    from tracks
)

select * from joined