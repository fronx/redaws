# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fronx_photos_session',
  :secret      => '65031b6df1f8af9a8f3c996e0b16c9d85d4d97db7f3308a0e54bd701d8d1e147d4a89c61de8430f6887be92628f0c7f32509ff99b37980baa843ab86c9382d6f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
