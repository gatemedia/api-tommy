# This API deals with user operations.
#
# id - the id
# username - the username
# api_key - the api key
# email - the email
# first_name - the first name
# last_name - the last name
# role - the role
# role_promotion - the role from a promotion point of view
# activated - true or false indicating if the user is enabled
# shop_ids - an array of all shop ids
#
# Examples
#
# {
#     "id": "67bc91bf-d28d-5a24-ac73-296dfdbcdc6a",
#     "username": "sysadmin",
#     "api_key": null,
#     "email": "sys@admin.net",
#     "first_name": "sys",
#     "last_name": "admin",
#     "role": "sysadmin",
#     "role_promotion": "admin",
#     "activated": true,
#     "shop_ids": [
#         "7bf37141-20ed-537c-8aed-d1b1f1a23adc"
#     ]
# }
#
class SamplesController < ApplicationController
  # Get all users. Must be an authenticated sysadmin.
  # Only returns JSON responses. Pagination options are available.
  #
  # api_key - The api key
  #
  # Examples
  #   GET /api/v2/users
  #
  # Returns an array of all users (field '''users''' in the JSON repsonse).
  # Raises 401 if the current user is not authenticated.
  # Raises 403 if the current user is not sysadmin.
  # Raises 500 if an error occurs.
  def index
    puts "foobar"
  end
end
