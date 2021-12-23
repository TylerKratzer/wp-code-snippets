/*Script to find users who have never signed in, and remove them.
Requires Wordfence to have been installed. Wordfence adds the meta_key
 `wfls-last-login` to the user_meta table, but only once someone has logged in once*/


/*Be sure to update wp_ with the correct prefix that your tables are using.*/

/*Create a temporary table to hold our search results*/
CREATE TABLE temp (user_id int);

/*Search for users who have the meta_key whfls-last-login and store it in our new table*/
INSERT INTO temp SELECT `user_id` FROM `wp_usermeta` WHERE `meta_key` LIKE '%wfls-last-login%';

/*Compare user_id from wp_usermeta against our temporary table and delete the user_ids that do not match*/
DELETE FROM `wp_usermeta` WHERE `user_id` NOT IN (SELECT `user_id` FROM `temp`); 

/*Compare ID from wp_users against our temporary table and delete the IDs that do not match*/
DELETE FROM `wp_users` WHERE `ID` NOT IN (SELECT `user_id` FROM `temp`); 

/*Clean up after ourselves*/
DROP TABLE temp;
