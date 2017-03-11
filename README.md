# [tracebook](http://tracebook.herokuapp.com/)

A social network clone built with Ruby on Rails. View it on [Heroku](http://tracebook.herokuapp.com/).

Explore the app by logging in with one of many prepopulated accounts, or start from scratch with a blank guest account.

**Prepopulated account logins:**

```
user1@email.com (works up through user20)

password
```

**Guest Account:**

```
guest@email.com

password
```

![Signup screen](https://github.com/blackwright/tracebook/blob/master/screenshots/signup.jpg?raw=true)

![Welcome screen](https://github.com/blackwright/tracebook/blob/master/screenshots/welcome.jpg?raw=true)

## Features

### Profile Information

- Users can share personal details about themselves, such as contact and location info.

![About screen](https://github.com/blackwright/tracebook/blob/master/screenshots/profile.jpg?raw=true)

### Finding and Adding Friends

- Friends can be searched for by name.

![Search screen](https://github.com/blackwright/tracebook/blob/master/screenshots/search.jpg?raw=true)

- Friend requests can be sent to other users.
- A friend request must be accepted in order to add a friend.

![Friend request screen](https://github.com/blackwright/tracebook/blob/master/screenshots/friends.jpg?raw=true)

### Posting and Commenting

- Each user has a timeline for posting their thoughts.

![Post creation screen](https://github.com/blackwright/tracebook/blob/master/screenshots/create-post.jpg?raw=true)

- Posts can only be commented on by the author's friends.

![Comment creation screen](https://github.com/blackwright/tracebook/blob/master/screenshots/post-comment.jpg?raw=true)

- Posts and comments can be liked by all users.
- Posts and comments have a running tally of likes.
- Users can view their friends' recent posts through a newsfeed.

### Photos

- Photos can be added to a gallery through links or upload.
- Users can select an image to use as their profile or cover photo.
- Photos can only be commented on by the author's friends.

![Photos screen](https://github.com/blackwright/tracebook/blob/master/screenshots/photos.jpg?raw=true)

### Mailer

- Newly signed-up users are automatically greeted with a welcome email.

### Technical Notes

- Postgresql database seeded with Faker gem.
- Posts, comments, and likes processed through ajax request.
- Utilizes flash notices from native Rails and ajax.
- Emails delivered with Heroku Sendgrid.
- Image attachments with Paperclip gem, hosted on Amazon S3.
- User search handled through SQL query.
- Environmental variables imported through Figaro gem and secrets.
- SASS styling with Bootstrap components.
