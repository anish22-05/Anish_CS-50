<-- The app’s user engagement team needs to identify active users. Find all usernames of users who have logged in since 2024-01-01. 
-- Ensure your query uses the search_users_by_last_login index, which is defined as follows:
SELECT username FROM users WHERE last_login_date = "2024-01-01";

<-- Users need to be prevented from re-opening a message that has expired. Find when the message with ID 151 expires.
    -- You may use the message’s ID directly in your query.
    -- Ensure your query uses the index automatically created on the primary key column of the messages table.
SELECT expires_timestamp FROM messages WHERE id = 151;
<--The app needs to rank a user’s “best friends,” similar to Snapchat’s “Friend Emojis” feature. 
    -- Find the user IDs of the top 3 users to whom creativewisdom377 sends messages most frequently. 
    -- Order the user IDs by the number of messages creativewisdom377 has sent to those users, most to least.
    -- Ensure your query uses the search_messages_by_from_user_id index, which is defined as follows:
SELECT m.to_user_id, COUNT(*) AS message_count FROM messages m
JOIN users u ON m.from_user_id = u.id
WHERE u.username = "creativewisdom377"
GROUP BY m.to_user_id
ORDER BY message_count DESC
LIMIT 3;
<-- The app needs to send users a summary of their engagement. 
-- Find the username of the most popular user, defined as the user who has had the most messages sent to them.
-- Ensure your query uses the search_messages_by_to_user_id index, which is defined as follows:
SELECT * FROM users JOIN messages ON users.id = messages.to_user_id
    GROUP BY users.id
    ORDER BY count(messages.id) DESC, users.username ASC LIMIT 1;
<--For any two users, the app needs to quickly show a list of the friends they have in common. Given two usernames, 
-- lovelytrust487 and exceptionalinspiration482, find the user IDs of their mutual friends. 
-- A mutual friend is a user that both lovelytrust487 and exceptionalinspiration482 count among their friends.
--     Ensure your query uses the index automatically created on primary key columns of the friends table. 
--     This index is called sqlite_autoindex_friends_1.
SELECT friend_id
FROM friends
WHERE user_id = (SELECT id FROM users WHERE username = 'lovelytrust487')

INTERSECT

SELECT friend_id
FROM friends
WHERE user_id = (SELECT id FROM users WHERE username = 'exceptionalinspiration482');
-------USING INNER JOIN WHICH IS SIMMILAR TO INTERSECTION AS INNER JOIN THIS JOIN WILL HAVE THE VALUES THAT ARE EQUAL ONLY.

SELECT f1.friend_id
FROM friends f1
INNER JOIN friends f2
  ON f1.friend_id = f2.friend_id
WHERE f1.user_id = (SELECT id FROM users WHERE username = 'lovelytrust487')
  AND f2.user_id = (SELECT id FROM users WHERE username = 'exceptionalinspiration482')
---------USING SELF JOIN WHICH IS A SPECIAL CASE OF INNER JOIN WHERE WE APPLY JOIN ON SAME TABLE USING ALLIAS FEATURE.

SELECT f1.friend_id
FROM friends f1
JOIN friends f2 ON f1.friend_id = f2.friend_id
WHERE f1.user_id = (SELECT id FROM users WHERE username = 'lovelytrust487')
  AND f2.user_id = (SELECT id FROM users WHERE username = 'exceptionalinspiration482');
--------------------------------------------DIFFERNCE BETWEEN SELF & INNER JOIN'S----------------------------------------------------------
<-- 1.Definition:	A self join is a special case of join where a table joins to itself.	
-- Inner join joins two tables (can be same or different tables) and returns rows where there’s a matching condition.
-- 2.How it works:	You create two copies of the same table using aliases (e.g., t1, t2) and join them.	 
-- Joins two tables (same or different) by matching a condition.
-- 3.Key Point:	Always joining the same table to itself.	
-- Tables can be different or same — general matching based on a condition.
-- 4.Why used:	When you want to compare rows within the same table (e.g., finding mutual friends, manager–employee relationships).	
-- Whenever you want to find matching rows from any two tables.
-- Example:	Find mutual friends of two users in a social app.	Find customers and their orders by joining customers and orders.
-- Keyword	Still uses INNER JOIN syntax! But it's called "self join" because it joins table to itself.	
-- Normal INNER JOIN, whether tables are same or different.