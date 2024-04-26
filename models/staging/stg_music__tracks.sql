select 
    trackid	              as track_id,
    name	                  as track_name,
    albumid	              as album_id,
    mediatypeid              as mediatype_id,
    genreid	              as genre_id,
    composer	              as track_composer,
    milliseconds             as track_length_ms,
    bytes	                  as bytes,
    unitprice	              as unit_price,
    track_length_ms/1000     as track_length_seconds,
    track_length_seconds/60  as track_length_mins
from {{ source('music', 'track') }}