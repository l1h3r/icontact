[![Gem Version](https://badge.fury.io/rb/icontact.svg)](http://badge.fury.io/rb/icontact)
[![Code Climate](https://codeclimate.com/github/L1h3r/icontact/badges/gpa.svg)](https://codeclimate.com/github/L1h3r/icontact)

Ruby Gem for iContact
---

For more details, read the iContact API documentation: http://www.icontact.com/developerportal/

Installation
---

TODO

Examples
---

Test connection to the API
```ruby
  client = IContact::Api.new(username, api_password, app_id)
  client.ping
```

Get all accounts
```ruby
  client.get_accounts
```

Get all lists
```ruby
  client.get_lists
```

Get a contact
```ruby
  client.get_contact(contact_id)
```

Create a contact
```ruby
  data = { email: 'user@example.com', firstName: 'John', lastName: 'Doe' }
  client.create_contact(data)
```

Update a contact
```ruby
  data = { firstName: 'Charlie', lastName: 'Brown', contactId: '8955' }
  client.update_contact(contact_id, data)
```

Delete a contact
```ruby
  client.delete_contact(contact_id)
```

Search for contacts
```ruby
  client.find_contacts(firstName: 'John')
```

Create a subscription
```ruby
  data = { listId: list_id, contactId: contact_id, status: 'normal' }
  client.create_subscription(data)
```

Contributing
---

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
