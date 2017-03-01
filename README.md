# tracebook

A social network clone built with Ruby on Rails.

[View on Heroku](http://tracebook.herokuapp.com/)

Explore the app using one of its prepopulated accounts, or with an empty guest account:

**Prepopulated account logins:**

```
user1@email.com (works up through user20)

password
```

**Guest Account:**

```
guest

password
```

## Features

### Finding and Adding Friends

- Friends can be searched for by name.
- Friend requests can be sent to other users.
- A friend request must be accepted in order to add a friend.

### Posting and Commenting

- Users can post their thoughts on their own timeline.
- Posts can only be commented on by the author's friends.
- Posts and comments can be liked by all users.
- Users can view their friends' recent posts through a newsfeed.

### Photos

- Photos can be added to a gallery through links or upload.
- Users can select an image to use as their profile or cover photo.
- Photos can only be commented on by the author's friends.
- Images hosted on Amazon S3 using Paperclip.

### Mailer

- Newly signed-up users are automatically greeted with a welcome email.
