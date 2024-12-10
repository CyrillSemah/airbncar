Geocoder.configure(
  # Geocoding options
  timeout: 3,                 # geocoding service timeout (secs)
  lookup: :nominatim,         # name of geocoding service (symbol)
  ip_lookup: :ipapi,         # name of IP address geocoding service (symbol)
  language: :fr,             # ISO-639 language code
  use_https: true,           # use HTTPS for lookup requests? (if supported)
  units: :km,                # :km for kilometers or :mi for miles
  distances: :linear         # :spherical or :linear
)
