/*Script to find users who haven't signed in since X date, and remove them.
Requires Wordfence to have been installed. Wordfence adds the meta_key
 `wfls-last-login` to the user_meta table, but only once someone has logged in once

Value on line 15 can be updated by entering desired date here  https://www.epochconverter.com


Be sure to update wp_ with the correct prefix that your tables are using.*/


/*Create a temporary table to hold our search results*/
CREATE TABLE temp (user_id int);

/*Search for users who haven't logged in since X date and store it in our new table*/
INSERT INTO temp SELECT `user_id` FROM `wp_usermeta` WHERE `meta_key` LIKE '%wfls-last-login%' AND `meta_value` < '1577854799';

/*Compare user_id from wp_usermeta against our temporary table and delete the user_ids that match*/
DELETE FROM `wp_usermeta` WHERE `user_id` IN (SELECT `user_id` FROM `temp`); 

/*Compare ID from wp_users against our temporary table and delete the IDs that match*/
DELETE FROM `wp_users` WHERE `ID` IN (SELECT `user_id` FROM `temp`); 

/*Clean up after ourselves*/
DROP TABLE temp;
