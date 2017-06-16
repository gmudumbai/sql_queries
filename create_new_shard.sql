/* Create new shard 116 */
SELECT * INTO taasdata_jpmc.dbo.call_action116s FROM taasdata_jpmc.dbo.call_action100s WHERE 1=2
SELECT * INTO taasdata_jpmc.dbo.call_action_error116s FROM taasdata_jpmc.dbo.call_action_error100s WHERE 1=2
SELECT * INTO taasdata_jpmc.dbo.load_call116s FROM taasdata_jpmc.dbo.load_call100s WHERE 1=2
SELECT * INTO taasdata_jpmc.dbo.connected_call116s FROM taasdata_jpmc.dbo.connected_call100s WHERE 1=2

/* Add entry in scheduledtest_table_maps for new shard 116 */
INSERT INTO [taasdata_jpmc].[dbo].[scheduledtest_table_maps]
           ([scheduledtest_guid], [table_id], [created_at], [updated_at])
     VALUES ('0', 116, GETUTCDATE(), GETUTCDATE())
GO