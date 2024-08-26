# Marketing team wants to reward the firve most loyal users

use ig_clone;
select * from users
order by created_at
limit 5;

# I’ve to identify users who have never posted on Instagram

select username from users
left join photos
on photos.user_id = users.id
where user_id is null;

# identify users who have got the most likes on a single photo

select username, photos.id, photos.image_url, count(likes.user_id) as total
from photos
inner join likes
on likes.photo_id = photos.id
inner join users
on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

# identify top 5 commonly used hashtag

select tag_name, count(*) as total
from photo_tags as P
join tags as t
on p.tag_id = t.id
group by t.id
order by total desc
limit 5;

# Identify day of the week when most users register on instagram

select dayname(created_at) as day, count(*) as total
from users
group by day
order by total desc
limit 1;

# Calculate the average number of posts per user on instagram

select (select count(*) from photos) / (select count(*) from users) as avg;

# Identify users who are potential bots who have liked every single photo

select username, count(*) as num_likes
from users
join likes 
on users.id = likes.user_id
group by users.id
having num_likes = (select count(*) from photos);