/****** Object:  Table [admin_dash_current]    Script Date: 9/24/2015 2:28:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [admin_dash_current](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[test_id] [int] NULL,
	[client_id] [int] NULL,
	[hour_interval] [datetime] NULL,
	[num_pass] [int] NULL,
	[num_fail] [int] NULL,
	[num_alerts] [int] NULL,
	[num_notifications] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [idx_admin_dashboard_summary] ON [admin_dash_current]( [hour_interval] ASC )
CREATE NONCLUSTERED INDEX [idx_admin_dashboard_details] ON [admin_dash_current]( [hour_interval] ASC, [client_id] ASC )
CREATE NONCLUSTERED INDEX [idx_admin_dashboard_per_client] ON [admin_dash_current]( [hour_interval] ASC, [client_id] ASC, [test_id] ASC )
GO

/****** Object:  Table [partners]    Script Date: 9/24/2015 2:29:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [partners](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[description] [nvarchar](250) NULL,
	[subscription_start_date] [datetime] NULL,
	[subscription_end_date] [datetime] NULL,
	[max_tests_allowed] [int] NULL,
	[min_test_schedule_period_in_minutes] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [partners] ADD  DEFAULT ((15)) FOR [min_test_schedule_period_in_minutes]
GO


INSERT INTO [partners] (name, description, subscription_start_date, subscription_end_date, max_tests_allowed, min_test_schedule_period_in_minutes, created_at, updated_at)
VALUES ('Empirix', 'Empirix Install Partner', CURRENT_TIMESTAMP, '2032-12-31 23:59:59.000', 1000, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)

ALTER TABLE clients ADD client_type NVARCHAR(25) DEFAULT 'Client' NOT NULL, partner_id INT, partner_name NVARCHAR(100), 
partner_end_tied BIT DEFAULT 0 NOT NULL, partner_schedule_tied BIT DEFAULT 0 NOT NULL