USE [master]
GO
/****** Object:  Database [Transport_miejski]    Script Date: 30.01.2024 1:51:59 ******/
CREATE DATABASE [Transport_miejski]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Transport_miejski', FILENAME = N'C:\Users\bogda\Transport_miejski.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Transport_miejski_log', FILENAME = N'C:\Users\bogda\Transport_miejski_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Transport_miejski] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Transport_miejski].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Transport_miejski] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Transport_miejski] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Transport_miejski] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Transport_miejski] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Transport_miejski] SET ARITHABORT OFF 
GO
ALTER DATABASE [Transport_miejski] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Transport_miejski] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Transport_miejski] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Transport_miejski] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Transport_miejski] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Transport_miejski] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Transport_miejski] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Transport_miejski] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Transport_miejski] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Transport_miejski] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Transport_miejski] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Transport_miejski] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Transport_miejski] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Transport_miejski] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Transport_miejski] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Transport_miejski] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Transport_miejski] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Transport_miejski] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Transport_miejski] SET  MULTI_USER 
GO
ALTER DATABASE [Transport_miejski] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Transport_miejski] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Transport_miejski] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Transport_miejski] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Transport_miejski] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Transport_miejski] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Transport_miejski] SET QUERY_STORE = OFF
GO
USE [Transport_miejski]
GO
/****** Object:  Table [dbo].[Tram Departures]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tram Departures](
	[departure_id] [smallint] NOT NULL,
	[stop_id] [nvarchar](10) NOT NULL,
	[line_num] [nvarchar](4) NOT NULL,
	[departure_time] [time](7) NOT NULL,
 CONSTRAINT [PK_Tram Departures] PRIMARY KEY CLUSTERED 
(
	[departure_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tram Stops]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tram Stops](
	[stop_id] [nvarchar](10) NOT NULL,
	[stop_name] [varchar](50) NOT NULL,
	[stop_latitude] [decimal](9, 5) NOT NULL,
	[stop_longtitude] [decimal](9, 5) NOT NULL,
 CONSTRAINT [PK_Tram Stops] PRIMARY KEY CLUSTERED 
(
	[stop_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[AvgBusDepartures]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AvgBusDepartures]()
returns table
as 
return
select ts.stop_name, count(td.stop_id) as NumOfDepartures
from [Tram Departures] td left join [Tram Stops] ts on td.stop_id = ts.stop_id
group by ts.stop_name
GO
/****** Object:  Table [dbo].[Bus Departures]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus Departures](
	[departure_id] [int] NOT NULL,
	[stop_id] [nvarchar](10) NOT NULL,
	[line_num] [nvarchar](4) NOT NULL,
	[departure_time] [time](7) NOT NULL,
 CONSTRAINT [PK_Departures] PRIMARY KEY CLUSTERED 
(
	[departure_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bus Lines]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus Lines](
	[line_num] [nvarchar](4) NOT NULL,
	[starting_station_id] [nvarchar](10) NOT NULL,
	[destination_station_id] [nvarchar](10) NOT NULL,
	[route] [text] NOT NULL,
 CONSTRAINT [PK_Bus Lines] PRIMARY KEY CLUSTERED 
(
	[line_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bus Schedule]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus Schedule](
	[service_id] [smallint] NOT NULL,
	[line_num] [nvarchar](4) NOT NULL,
	[bus_num] [nvarchar](4) NOT NULL,
	[start_time] [time](7) NOT NULL,
	[duration] [smallint] NOT NULL,
 CONSTRAINT [PK_Bus Services] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bus Stops]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus Stops](
	[stop_id] [nvarchar](10) NOT NULL,
	[stop_name] [varchar](50) NOT NULL,
	[stop_longtitude] [decimal](9, 5) NOT NULL,
	[stop_latitude] [decimal](9, 5) NOT NULL,
 CONSTRAINT [PK_Bus Stops] PRIMARY KEY CLUSTERED 
(
	[stop_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers](
	[driver_id] [smallint] NOT NULL,
	[firstName] [varchar](10) NOT NULL,
	[lastName] [varchar](20) NOT NULL,
	[pesel] [nchar](11) NOT NULL,
	[city] [varchar](15) NOT NULL,
	[street] [varchar](15) NOT NULL,
	[street_num] [smallint] NOT NULL,
	[flat_num] [smallint] NULL,
	[birthdate] [date] NOT NULL,
	[phone_num] [nchar](9) NOT NULL,
 CONSTRAINT [PK_Drivers] PRIMARY KEY CLUSTERED 
(
	[driver_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginDriver]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginDriver](
	[driver_id] [smallint] NOT NULL,
	[login] [varchar](30) NOT NULL,
	[password] [varchar](30) NOT NULL,
 CONSTRAINT [PK_LoginDriver] PRIMARY KEY CLUSTERED 
(
	[driver_id] ASC,
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginManagement]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginManagement](
	[login] [varchar](30) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[manager_id] [int] NOT NULL,
 CONSTRAINT [PK_LoginManagement_1] PRIMARY KEY CLUSTERED 
(
	[login] ASC,
	[manager_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Managers]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Managers](
	[manager_id] [int] NOT NULL,
	[firstName] [varchar](10) NOT NULL,
	[lastName] [varchar](20) NOT NULL,
	[pesel] [nchar](11) NOT NULL,
	[street] [varchar](15) NOT NULL,
	[street_num] [smallint] NOT NULL,
	[flat_num] [smallint] NULL,
	[birthdate] [date] NOT NULL,
	[phone_num] [nchar](9) NULL,
 CONSTRAINT [PK_Managers] PRIMARY KEY CLUSTERED 
(
	[manager_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[ticket_id] [nchar](6) NOT NULL,
	[ticket_type] [text] NOT NULL,
	[ticket_duration] [smallint] NOT NULL,
	[ticket_price] [smallmoney] NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tram Lines]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tram Lines](
	[line_num] [nvarchar](4) NOT NULL,
	[starting_station_id] [nvarchar](10) NOT NULL,
	[destination_station_id] [nvarchar](10) NOT NULL,
	[route] [text] NOT NULL,
 CONSTRAINT [PK_Tram Lines] PRIMARY KEY CLUSTERED 
(
	[line_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tram Schedule]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tram Schedule](
	[service_id] [smallint] NOT NULL,
	[line_num] [nvarchar](4) NOT NULL,
	[tram_num] [nvarchar](4) NOT NULL,
	[start_time] [time](7) NOT NULL,
	[duration] [smallint] NOT NULL,
 CONSTRAINT [PK_Tram Services] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle Brands]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle Brands](
	[brand_id] [smallint] NOT NULL,
	[brand_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Vehicle Brands_1] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle Models]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle Models](
	[model_id] [smallint] NOT NULL,
	[brand_id] [smallint] NOT NULL,
	[model_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Vehicle Models] PRIMARY KEY CLUSTERED 
(
	[model_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle Repairs]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle Repairs](
	[repair_id] [nvarchar](10) NOT NULL,
	[vehicle_num] [nvarchar](4) NOT NULL,
	[repair_type] [varchar](50) NOT NULL,
	[repair_cost] [money] NOT NULL,
 CONSTRAINT [PK_Vehicle Repairs] PRIMARY KEY CLUSTERED 
(
	[repair_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[vehicle_num] [nvarchar](4) NOT NULL,
	[reg_num] [nvarchar](7) NULL,
	[vehicle_type] [nvarchar](10) NOT NULL,
	[brand_id] [smallint] NOT NULL,
	[model_id] [smallint] NOT NULL,
 CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[vehicle_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicles Incidents]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles Incidents](
	[entry_id] [smallint] NOT NULL,
	[vehicle_num] [nvarchar](4) NOT NULL,
	[incident_type] [varchar](50) NOT NULL,
	[driver_id] [smallint] NOT NULL,
 CONSTRAINT [PK_Vehicles_Incidents] PRIMARY KEY CLUSTERED 
(
	[entry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Work Shifts]    Script Date: 30.01.2024 1:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Work Shifts](
	[entry_id] [int] NOT NULL,
	[driver_id] [smallint] NOT NULL,
	[shift_date] [date] NOT NULL,
	[start_time] [time](1) NOT NULL,
	[finish_time] [time](1) NOT NULL,
 CONSTRAINT [PK_Work Shifts] PRIMARY KEY CLUSTERED 
(
	[entry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (1, N'1B', N'101', CAST(N'07:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (2, N'5B', N'102', CAST(N'08:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (3, N'10B', N'103', CAST(N'09:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (4, N'15B', N'104', CAST(N'10:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (5, N'20B', N'105', CAST(N'12:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (6, N'25B', N'106', CAST(N'13:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (7, N'30B', N'107', CAST(N'14:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (8, N'35B', N'108', CAST(N'15:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (9, N'40B', N'109', CAST(N'17:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (10, N'45B', N'110', CAST(N'18:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (11, N'50B', N'111', CAST(N'19:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (12, N'1B', N'112', CAST(N'20:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (13, N'5B', N'113', CAST(N'22:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (14, N'10B', N'114', CAST(N'23:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (15, N'15B', N'115', CAST(N'00:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (16, N'1B', N'113', CAST(N'08:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (17, N'1B', N'115', CAST(N'09:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (18, N'5B', N'101', CAST(N'10:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (19, N'5B', N'105', CAST(N'11:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (20, N'5B', N'112', CAST(N'13:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (21, N'10B', N'104', CAST(N'14:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (22, N'10B', N'106', CAST(N'15:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (23, N'10B', N'110', CAST(N'16:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (24, N'15B', N'102', CAST(N'18:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (25, N'15B', N'108', CAST(N'19:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (26, N'15B', N'114', CAST(N'20:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (27, N'20B', N'103', CAST(N'21:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (28, N'20B', N'107', CAST(N'23:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (29, N'20B', N'111', CAST(N'00:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (30, N'25B', N'109', CAST(N'01:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (31, N'25B', N'113', CAST(N'02:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (32, N'25B', N'115', CAST(N'04:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (33, N'30B', N'101', CAST(N'05:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (34, N'30B', N'105', CAST(N'06:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (35, N'30B', N'112', CAST(N'07:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (36, N'35B', N'104', CAST(N'09:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (37, N'35B', N'106', CAST(N'10:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (38, N'35B', N'110', CAST(N'11:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (39, N'40B', N'102', CAST(N'12:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (40, N'40B', N'108', CAST(N'14:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (41, N'40B', N'114', CAST(N'15:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (42, N'45B', N'103', CAST(N'16:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (43, N'45B', N'107', CAST(N'17:45:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (44, N'45B', N'111', CAST(N'19:00:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (45, N'50B', N'109', CAST(N'20:15:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (46, N'50B', N'113', CAST(N'21:30:00' AS Time))
INSERT [dbo].[Bus Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (47, N'50B', N'115', CAST(N'22:45:00' AS Time))
GO
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'101', N'1B', N'15B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'102', N'16B', N'30B', N'16B, 17B, 18B, 19B, 20B, 21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'103', N'31B', N'45B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B, 41B, 42B, 43B, 44B, 45B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'104', N'46B', N'50B', N'46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'105', N'1B', N'10B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'106', N'11B', N'20B', N'11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'107', N'21B', N'30B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'108', N'31B', N'40B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'109', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'110', N'1B', N'20B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'111', N'21B', N'40B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B, 31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'112', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'113', N'1B', N'30B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B, 21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'114', N'31B', N'50B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B, 41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'115', N'1B', N'20B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'116', N'21B', N'40B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B, 31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'117', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'118', N'1B', N'15B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'119', N'16B', N'30B', N'16B, 17B, 18B, 19B, 20B, 21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'120', N'31B', N'45B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B, 41B, 42B, 43B, 44B, 45B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'121', N'46B', N'50B', N'46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'122', N'1B', N'10B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'123', N'11B', N'20B', N'11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'124', N'21B', N'30B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'125', N'31B', N'40B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'126', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'127', N'1B', N'15B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'128', N'16B', N'30B', N'16B, 17B, 18B, 19B, 20B, 21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'129', N'31B', N'45B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B, 41B, 42B, 43B, 44B, 45B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'130', N'46B', N'50B', N'46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'131', N'1B', N'10B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'132', N'11B', N'20B', N'11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'133', N'21B', N'30B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'134', N'31B', N'40B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'135', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'136', N'1B', N'20B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'137', N'21B', N'40B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B, 31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'138', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'139', N'1B', N'30B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B, 21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'140', N'31B', N'50B', N'31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B, 41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'141', N'1B', N'20B', N'1B, 2B, 3B, 4B, 5B, 6B, 7B, 8B, 9B, 10B, 11B, 12B, 13B, 14B, 15B, 16B, 17B, 18B, 19B, 20B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'142', N'21B', N'40B', N'21B, 22B, 23B, 24B, 25B, 26B, 27B, 28B, 29B, 30B, 31B, 32B, 33B, 34B, 35B, 36B, 37B, 38B, 39B, 40B')
INSERT [dbo].[Bus Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'143', N'41B', N'50B', N'41B, 42B, 43B, 44B, 45B, 46B, 47B, 48B, 49B, 50B')
GO
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (1, N'101', N'165', CAST(N'07:00:00' AS Time), 60)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (2, N'102', N'193', CAST(N'08:15:00' AS Time), 45)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (3, N'103', N'253', CAST(N'09:30:00' AS Time), 55)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (4, N'104', N'327', CAST(N'10:45:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (5, N'105', N'945', CAST(N'12:00:00' AS Time), 40)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (6, N'106', N'607', CAST(N'13:15:00' AS Time), 65)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (7, N'107', N'585', CAST(N'14:30:00' AS Time), 30)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (8, N'108', N'725', CAST(N'15:45:00' AS Time), 75)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (9, N'109', N'865', CAST(N'17:00:00' AS Time), 55)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (10, N'110', N'626', CAST(N'18:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (11, N'111', N'403', CAST(N'19:30:00' AS Time), 45)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (12, N'106', N'607', CAST(N'20:45:00' AS Time), 60)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (13, N'110', N'626', CAST(N'22:00:00' AS Time), 40)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (14, N'111', N'403', CAST(N'23:15:00' AS Time), 35)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (15, N'115', N'165', CAST(N'00:30:00' AS Time), 70)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (16, N'107', N'165', CAST(N'07:00:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (17, N'103', N'193', CAST(N'08:15:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (18, N'113', N'253', CAST(N'09:30:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (19, N'131', N'316', CAST(N'10:45:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (20, N'127', N'327', CAST(N'12:00:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (21, N'130', N'351', CAST(N'13:15:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (22, N'101', N'366', CAST(N'14:30:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (23, N'120', N'403', CAST(N'15:45:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (24, N'107', N'564', CAST(N'17:00:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (25, N'128', N'585', CAST(N'18:15:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (26, N'119', N'607', CAST(N'19:30:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (27, N'137', N'626', CAST(N'20:45:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (28, N'119', N'657', CAST(N'22:00:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (29, N'114', N'725', CAST(N'23:15:00' AS Time), 51)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (30, N'133', N'733', CAST(N'00:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (31, N'134', N'824', CAST(N'07:00:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (32, N'110', N'830', CAST(N'08:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (33, N'111', N'865', CAST(N'09:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (34, N'104', N'867', CAST(N'10:45:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (35, N'105', N'945', CAST(N'12:00:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (36, N'136', N'165', CAST(N'13:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (37, N'105', N'193', CAST(N'14:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (38, N'102', N'253', CAST(N'15:45:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (39, N'110', N'316', CAST(N'17:00:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (40, N'127', N'327', CAST(N'18:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (41, N'142', N'351', CAST(N'19:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (42, N'111', N'366', CAST(N'20:45:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (43, N'102', N'403', CAST(N'22:00:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (44, N'141', N'564', CAST(N'23:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (45, N'143', N'585', CAST(N'00:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (46, N'139', N'607', CAST(N'07:00:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (47, N'133', N'626', CAST(N'08:15:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (48, N'133', N'657', CAST(N'09:30:00' AS Time), 50)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (49, N'118', N'725', CAST(N'10:45:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (50, N'119', N'733', CAST(N'12:00:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (51, N'112', N'824', CAST(N'13:15:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (52, N'140', N'830', CAST(N'14:30:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (53, N'108', N'865', CAST(N'15:45:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (54, N'143', N'867', CAST(N'17:00:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (55, N'111', N'945', CAST(N'18:15:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (56, N'127', N'193', CAST(N'19:30:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (57, N'119', N'253', CAST(N'20:45:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (58, N'142', N'316', CAST(N'22:00:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (59, N'140', N'327', CAST(N'23:15:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (60, N'112', N'351', CAST(N'00:30:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (61, N'128', N'366', CAST(N'07:00:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (62, N'122', N'403', CAST(N'08:15:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (63, N'105', N'564', CAST(N'09:30:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (64, N'116', N'585', CAST(N'10:45:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (65, N'103', N'607', CAST(N'12:00:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (66, N'132', N'626', CAST(N'13:15:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (67, N'128', N'657', CAST(N'14:30:00' AS Time), 49)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (68, N'112', N'725', CAST(N'15:45:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (69, N'143', N'733', CAST(N'17:00:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (70, N'123', N'824', CAST(N'18:15:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (71, N'141', N'830', CAST(N'19:30:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (72, N'108', N'865', CAST(N'20:45:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (73, N'131', N'867', CAST(N'22:00:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (74, N'136', N'945', CAST(N'23:15:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (75, N'105', N'193', CAST(N'00:30:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (76, N'142', N'253', CAST(N'07:00:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (77, N'107', N'316', CAST(N'08:15:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (78, N'115', N'327', CAST(N'09:30:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (79, N'107', N'351', CAST(N'10:45:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (80, N'108', N'366', CAST(N'12:00:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (81, N'110', N'403', CAST(N'13:15:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (82, N'124', N'564', CAST(N'14:30:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (83, N'131', N'585', CAST(N'15:45:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (84, N'104', N'607', CAST(N'17:00:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (85, N'118', N'626', CAST(N'18:15:00' AS Time), 48)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (86, N'115', N'657', CAST(N'19:30:00' AS Time), 47)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (87, N'119', N'725', CAST(N'20:45:00' AS Time), 47)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (88, N'143', N'733', CAST(N'22:00:00' AS Time), 47)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (89, N'126', N'824', CAST(N'23:15:00' AS Time), 47)
INSERT [dbo].[Bus Schedule] ([service_id], [line_num], [bus_num], [start_time], [duration]) VALUES (90, N'120', N'830', CAST(N'00:30:00' AS Time), 47)
GO
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'10B', N'Nowy Kleparz', CAST(19.94600 AS Decimal(9, 5)), CAST(50.06200 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'11B', N'Podgórze', CAST(19.97600 AS Decimal(9, 5)), CAST(50.04600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'12B', N'Kraków Glówny', CAST(19.94500 AS Decimal(9, 5)), CAST(50.07800 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'13B', N'Zablocie', CAST(19.96800 AS Decimal(9, 5)), CAST(50.04100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'14B', N'Mocak Museum', CAST(19.96100 AS Decimal(9, 5)), CAST(50.04300 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'15B', N'Krakow University', CAST(19.93600 AS Decimal(9, 5)), CAST(50.03400 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'16B', N'Bienczyce', CAST(19.96600 AS Decimal(9, 5)), CAST(50.06500 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'17B', N'Czyzyny', CAST(19.97800 AS Decimal(9, 5)), CAST(50.06100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'18B', N'Mlynówka Czyzyny', CAST(19.98800 AS Decimal(9, 5)), CAST(50.05800 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'19B', N'Dworzec Towarowy', CAST(20.00400 AS Decimal(9, 5)), CAST(50.05200 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'1B', N'Plac Wolnosci', CAST(19.94500 AS Decimal(9, 5)), CAST(50.06100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'20B', N'Cmentarz Rakowicki', CAST(19.97400 AS Decimal(9, 5)), CAST(50.05600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'21B', N'Os.Piastów', CAST(19.96600 AS Decimal(9, 5)), CAST(50.07300 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'22B', N'Os.Kolorowe', CAST(19.95800 AS Decimal(9, 5)), CAST(50.08300 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'23B', N'Bronowice Male', CAST(19.95300 AS Decimal(9, 5)), CAST(50.10000 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'24B', N'Osiedle Oficerskie', CAST(19.95300 AS Decimal(9, 5)), CAST(50.11400 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'25B', N'Bronowice Wielkie', CAST(19.95300 AS Decimal(9, 5)), CAST(50.12700 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'26B', N'Os.Piastów', CAST(19.95600 AS Decimal(9, 5)), CAST(50.14100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'27B', N'Krowodrza Górka', CAST(19.95800 AS Decimal(9, 5)), CAST(50.15500 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'28B', N'Lagiewniki', CAST(19.96600 AS Decimal(9, 5)), CAST(50.16700 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'29B', N'Prokocim', CAST(19.97400 AS Decimal(9, 5)), CAST(50.18000 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'2B', N'Rondo Mogilskie', CAST(19.95300 AS Decimal(9, 5)), CAST(50.06700 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'30B', N'Biezanów', CAST(19.97800 AS Decimal(9, 5)), CAST(50.19400 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'31B', N'Lagiewniki', CAST(19.99200 AS Decimal(9, 5)), CAST(50.20600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'32B', N'Zlocien', CAST(20.00600 AS Decimal(9, 5)), CAST(50.21500 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'33B', N'Kurdwanów', CAST(20.02100 AS Decimal(9, 5)), CAST(50.22600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'34B', N'Kobierzyn', CAST(20.03600 AS Decimal(9, 5)), CAST(50.23600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'35B', N'Kliny Zacisze', CAST(20.04800 AS Decimal(9, 5)), CAST(50.24600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'36B', N'Zarzecze', CAST(20.06200 AS Decimal(9, 5)), CAST(50.25600 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'37B', N'Nowa Huta', CAST(20.07500 AS Decimal(9, 5)), CAST(50.26700 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'38B', N'Kurdwanów Nowy', CAST(20.08800 AS Decimal(9, 5)), CAST(50.27800 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'39B', N'Cichy Kacik', CAST(20.10200 AS Decimal(9, 5)), CAST(50.28900 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'3B', N'Blonia Krakowskie', CAST(19.93200 AS Decimal(9, 5)), CAST(50.06500 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'40B', N'Os.Pólwsie', CAST(20.11600 AS Decimal(9, 5)), CAST(50.30000 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'41B', N'Ruczaj', CAST(20.13000 AS Decimal(9, 5)), CAST(50.31000 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'42B', N'Dabie', CAST(20.14400 AS Decimal(9, 5)), CAST(50.32100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'43B', N'Witkowice', CAST(20.15900 AS Decimal(9, 5)), CAST(50.33100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'44B', N'Borek Falecki', CAST(20.17400 AS Decimal(9, 5)), CAST(50.34100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'45B', N'Zakopianka', CAST(20.18800 AS Decimal(9, 5)), CAST(50.35100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'46B', N'Wzgórza Krzeslawickie', CAST(20.20200 AS Decimal(9, 5)), CAST(50.36100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'47B', N'Lagiewniki Kosciól', CAST(20.21700 AS Decimal(9, 5)), CAST(50.37100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'48B', N'Wawrzonki', CAST(20.23200 AS Decimal(9, 5)), CAST(50.38100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'49B', N'Dab Wielki', CAST(20.24600 AS Decimal(9, 5)), CAST(50.39200 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'4B', N'Teatr Bagatela', CAST(19.92800 AS Decimal(9, 5)), CAST(50.06200 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'50B', N'Giebultów', CAST(20.26000 AS Decimal(9, 5)), CAST(50.40200 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'5B', N'Rynek Glówny', CAST(19.93700 AS Decimal(9, 5)), CAST(50.06100 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'6B', N'Planty', CAST(19.94300 AS Decimal(9, 5)), CAST(50.05900 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'7B', N'Wawel Castle', CAST(19.93300 AS Decimal(9, 5)), CAST(50.04900 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'8B', N'Kosciuszki Avenue', CAST(19.92200 AS Decimal(9, 5)), CAST(50.04700 AS Decimal(9, 5)))
INSERT [dbo].[Bus Stops] ([stop_id], [stop_name], [stop_longtitude], [stop_latitude]) VALUES (N'9B', N'Kazimierz District', CAST(19.95500 AS Decimal(9, 5)), CAST(50.05100 AS Decimal(9, 5)))
GO
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (1, N'Jan', N'Nowak', N'90050545675', N'Warszawa', N'Aleje Jerozolim', 123, 45, CAST(N'1990-01-01' AS Date), N'555123432')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (2, N'Anna', N'Kowalska', N'85020223456', N'Kraków', N'ul. Florianska', 456, 78, CAST(N'1985-02-02' AS Date), N'555567887')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (3, N'Piotr', N'Lis', N'88030334567', N'Gdansk', N'ul. Dluga', 789, 90, CAST(N'1988-03-03' AS Date), N'555901298')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (4, N'Alicja', N'Zielinska', N'92040445678', N'Kraków', N'ul. Swidnicka', 101, 12, CAST(N'1992-04-04' AS Date), N'555473456')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (5, N'Michal', N'Wójcik', N'91050556789', N'Kraków', N'ul. Wielka', 202, 34, CAST(N'1991-05-05' AS Date), N'555017890')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (6, N'Katarzyna', N'Mazurek', N'86060678901', N'Kraków', N'ul. Staromlynsk', 303, 56, CAST(N'1986-06-06' AS Date), N'555342345')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (7, N'Grzegorz', N'Jankowski', N'87070789012', N'Lódz', N'ul. Piotrkowska', 404, 78, CAST(N'1987-07-07' AS Date), N'555496789')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (8, N'Magdalena', N'Nowicka', N'90080890123', N'Kraków', N'ul. Chorzowska', 505, 90, CAST(N'1990-08-08' AS Date), N'555010123')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (9, N'Tomasz', N'Dabrowski', N'91010112344', N'Warszawa', N'ul. Swietojansk', 606, 12, CAST(N'1992-09-09' AS Date), N'555734567')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (10, N'Karolina', N'Jastrzebska', N'88010112345', N'Warszawa', N'ul. Lipowa', 707, 34, CAST(N'1988-01-01' AS Date), N'555167890')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (11, N'Wojciech', N'Piotrowski', N'91010112345', N'Warszawa', N'ul. Marszalkows', 34, 56, CAST(N'1991-01-01' AS Date), N'666111222')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (12, N'Zuzanna', N'Sikorska', N'92020223456', N'Kraków', N'ul. Florianska', 78, 90, CAST(N'1992-02-02' AS Date), N'666222333')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (13, N'Marek', N'Kowalczyk', N'90030334567', N'Gdansk', N'ul. Dluga', 90, 12, CAST(N'1990-03-03' AS Date), N'666333444')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (14, N'Joanna', N'Baranowska', N'93040445678', N'Wroclaw', N'ul. Swidnicka', 12, 34, CAST(N'1993-04-04' AS Date), N'666444555')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (15, N'Kamil', N'Kowal', N'88050556789', N'Poznan', N'ul. Wielka', 56, 78, CAST(N'1988-05-05' AS Date), N'666555666')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (16, N'Weronika', N'Górska', N'86060678901', N'Szczecin', N'ul. Staromlynsk', 78, 90, CAST(N'1986-06-06' AS Date), N'666666777')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (17, N'Krzysztof', N'Jankowski', N'87070789012', N'Lódz', N'ul. Piotrkowska', 34, 56, CAST(N'1987-07-07' AS Date), N'666777888')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (18, N'Aleksandra', N'Lis', N'90080890123', N'Katowice', N'ul. Chorzowska', 56, 12, CAST(N'1990-08-08' AS Date), N'666888999')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (19, N'Damian', N'Szewczyk', N'92090901234', N'Gdynia', N'ul. Swietojansk', 12, 34, CAST(N'1992-09-09' AS Date), N'666999000')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (20, N'Natalia', N'Szymanska', N'88010112345', N'Bialystok', N'ul. Lipowa', 78, 90, CAST(N'1988-01-01' AS Date), N'666000111')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (21, N'Marta', N'Szymanska', N'85030323455', N'Kraków', N'ul. Zwierzyniec', 34, 56, CAST(N'1990-01-01' AS Date), N'555211111')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (22, N'Krzysztof', N'Jaworski', N'85020223456', N'Warszawa', N'ul. Marszalkows', 78, 90, CAST(N'1985-02-02' AS Date), N'555782122')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (23, N'Agnieszka', N'Kowalczyk', N'88030334567', N'Poznan', N'ul. Wielkopolsk', 90, 12, CAST(N'1988-03-03' AS Date), N'555773333')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (24, N'Daniel', N'Zajac', N'92040445678', N'Gdansk', N'ul. Dlugie Pobr', 12, 34, CAST(N'1992-04-04' AS Date), N'645231321')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (25, N'Kinga', N'Lisowska', N'91050556789', N'Wroclaw', N'ul. Slodowa', 56, 78, CAST(N'1991-05-05' AS Date), N'621451213')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (26, N'Rafal', N'Wozniak', N'86060678901', N'Szczecin', N'ul. Monte Cassi', 78, 90, CAST(N'1986-06-06' AS Date), N'641350213')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (27, N'Monika', N'Kaminska', N'87070789012', N'Lódz', N'ul. Piotrkowska', 34, 56, CAST(N'1987-07-07' AS Date), N'621451213')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (28, N'Pawel', N'Nowakowski', N'90080890123', N'Katowice', N'ul. Sródmiejska', 56, 12, CAST(N'1990-08-08' AS Date), N'676451243')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (29, N'Sylwia', N'Kaczmarek', N'92090901234', N'Gdynia', N'ul. Morska', 12, 34, CAST(N'1992-09-09' AS Date), N'987654321')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (30, N'Marcin', N'Lewandowski', N'88010112345', N'Bialystok', N'ul. Lipowa', 78, 90, CAST(N'1988-01-01' AS Date), N'123456789')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (31, N'Karol', N'Wojciechowski', N'88040434565', N'Warszawa', N'ul. Marszalkows', 34, 56, CAST(N'1990-01-01' AS Date), N'876543210')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (32, N'Zofia', N'Piotrowska', N'85020223456', N'Kraków', N'ul. Florianska', 78, 90, CAST(N'1985-02-02' AS Date), N'234567890')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (33, N'Robert', N'Stepien', N'88030334567', N'Gdansk', N'ul. Dluga', 90, 12, CAST(N'1988-03-03' AS Date), N'987123456')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (34, N'Patrycja', N'Baran', N'92040445678', N'Wroclaw', N'ul. Swidnicka', 12, 34, CAST(N'1992-04-04' AS Date), N'567890123')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (35, N'Kamil', N'Kwiatkowski', N'91050556789', N'Poznan', N'ul. Wielka', 56, 78, CAST(N'1991-05-05' AS Date), N'456789012')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (36, N'Natalia', N'Sikora', N'86060678901', N'Szczecin', N'ul. Staromlynsk', 78, 90, CAST(N'1986-06-06' AS Date), N'345678901')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (37, N'Dominik', N'Duda', N'87070789012', N'Lódz', N'ul. Piotrkowska', 34, 56, CAST(N'1987-07-07' AS Date), N'890123456')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (38, N'Oliwia', N'Grabowska', N'90080890123', N'Katowice', N'ul. Chorzowska', 56, 12, CAST(N'1990-08-08' AS Date), N'678901234')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (39, N'Artur', N'Stawicki', N'92090901234', N'Gdynia', N'ul. Swietojansk', 12, 34, CAST(N'1992-09-09' AS Date), N'123890456')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (40, N'Sandra', N'Glowacka', N'88010112345', N'Bialystok', N'ul. Lipowa', 78, 90, CAST(N'1988-01-01' AS Date), N'534213456')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (41, N'Dawid', N'Sobolewski', N'91020223456', N'Warszawa', N'ul. Nowy Swiat', 34, 56, CAST(N'1991-02-02' AS Date), N'555113455')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (42, N'Kornelia', N'Laskowska', N'90030334567', N'Kraków', N'ul. Grodzka', 78, 90, CAST(N'1990-03-03' AS Date), N'501213422')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (43, N'Pawel', N'Kubiak', N'89040445678', N'Gdansk', N'ul. Mariacka', 90, 12, CAST(N'1989-04-04' AS Date), N'521563333')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (44, N'Klaudia', N'Jankowska', N'93050556789', N'Wroclaw', N'ul. Kielbasnicz', 12, 34, CAST(N'1993-05-05' AS Date), N'555210014')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (45, N'Mateusz', N'Zalewski', N'87060678901', N'Poznan', N'ul. Garbary', 56, 78, CAST(N'1987-06-06' AS Date), N'555035915')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (46, N'Natalia', N'Szymczak', N'92070789012', N'Szczecin', N'ul. Monte Cassi', 78, 90, CAST(N'1992-07-07' AS Date), N'555420166')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (47, N'Grzegorz', N'Kozlowski', N'90080890123', N'Lódz', N'ul. Piotrkowska', 34, 56, CAST(N'1990-08-08' AS Date), N'555517717')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (48, N'Wiktoria', N'Sawicka', N'91090901234', N'Katowice', N'ul. Warszawska', 56, 12, CAST(N'1991-09-09' AS Date), N'555718218')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (49, N'Kamil', N'Lisowski', N'88010112345', N'Gdynia', N'ul. Morska', 12, 34, CAST(N'1988-01-01' AS Date), N'555019319')
INSERT [dbo].[Drivers] ([driver_id], [firstName], [lastName], [pesel], [city], [street], [street_num], [flat_num], [birthdate], [phone_num]) VALUES (50, N'Karolina', N'Pawlowska', N'89020223456', N'Bialystok', N'ul. Lipowa', 78, 90, CAST(N'1989-02-02' AS Date), N'555412301')
GO
INSERT [dbo].[LoginDriver] ([driver_id], [login], [password]) VALUES (1, N'drivertest', N'drivertest123')
INSERT [dbo].[LoginDriver] ([driver_id], [login], [password]) VALUES (2, N'test1', N'Testing123')
GO
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'NOR000', N'Normalny 24-godzinny', 1440, 12.0000)
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'NOR020', N'Normalny 20-minutowy', 20, 3.0000)
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'NOR060', N'Normalny 60-minutowy', 60, 5.0000)
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'ULG000', N'Ulgowy 24-godzinny', 1440, 6.5000)
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'ULG020', N'Ulgowy 20-minutowy', 20, 1.5000)
INSERT [dbo].[Tickets] ([ticket_id], [ticket_type], [ticket_duration], [ticket_price]) VALUES (N'ULG060', N'Ulgowy 60-minutowy', 60, 2.5000)
GO
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (1, N'1T', N'13', CAST(N'07:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (2, N'1T', N'15', CAST(N'08:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (3, N'5T', N'1', CAST(N'09:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (4, N'5T', N'5', CAST(N'10:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (5, N'5T', N'12', CAST(N'12:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (6, N'10T', N'4', CAST(N'13:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (7, N'10T', N'6', CAST(N'14:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (8, N'10T', N'10', CAST(N'15:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (9, N'15T', N'2', CAST(N'17:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (10, N'15T', N'8', CAST(N'18:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (11, N'15T', N'14', CAST(N'19:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (12, N'20T', N'3', CAST(N'20:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (13, N'20T', N'7', CAST(N'22:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (14, N'20T', N'11', CAST(N'23:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (15, N'25T', N'9', CAST(N'00:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (16, N'25T', N'13', CAST(N'01:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (17, N'25T', N'15', CAST(N'03:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (18, N'30T', N'1', CAST(N'04:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (19, N'30T', N'5', CAST(N'05:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (20, N'30T', N'12', CAST(N'06:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (21, N'35T', N'4', CAST(N'08:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (22, N'35T', N'6', CAST(N'09:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (23, N'35T', N'10', CAST(N'10:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (24, N'40T', N'2', CAST(N'11:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (25, N'40T', N'8', CAST(N'13:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (26, N'40T', N'14', CAST(N'14:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (27, N'45T', N'3', CAST(N'15:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (28, N'45T', N'7', CAST(N'16:45:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (29, N'45T', N'11', CAST(N'18:00:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (30, N'50T', N'9', CAST(N'19:15:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (31, N'50T', N'13', CAST(N'20:30:00' AS Time))
INSERT [dbo].[Tram Departures] ([departure_id], [stop_id], [line_num], [departure_time]) VALUES (32, N'50T', N'15', CAST(N'21:45:00' AS Time))
GO
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'1', N'1T', N'15T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'10', N'1T', N'20T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'11', N'21T', N'40T', N'21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T, 31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'12', N'41T', N'50T', N'41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'13', N'1T', N'30T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T, 21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'14', N'31T', N'50T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T, 41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'15', N'1T', N'20T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'16', N'21T', N'40T', N'21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T, 31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'17', N'41T', N'50T', N'41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'18', N'1T', N'15T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'19', N'16T', N'30T', N'16T, 17T, 18T, 19T, 20T, 21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'2', N'16T', N'30T', N'16T, 17T, 18T, 19T, 20T, 21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'20', N'31T', N'45T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T, 41T, 42T, 43T, 44T, 45T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'21', N'46T', N'50T', N'46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'22', N'1T', N'10T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'23', N'11T', N'20T', N'11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'24', N'21T', N'30T', N'21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'25', N'31T', N'40T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'26', N'41T', N'50T', N'41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'27', N'1T', N'30T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T, 21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'28', N'31T', N'50T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T, 41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'29', N'1T', N'20T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T, 11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'3', N'31T', N'45T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T, 41T, 42T, 43T, 44T, 45T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'30', N'21T', N'40T', N'21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T, 31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'4', N'46T', N'50T', N'46T, 47T, 48T, 49T, 50T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'5', N'1T', N'10T', N'1T, 2T, 3T, 4T, 5T, 6T, 7T, 8T, 9T, 10T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'6', N'11T', N'20T', N'11T, 12T, 13T, 14T, 15T, 16T, 17T, 18T, 19T, 20T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'7', N'21T', N'30T', N'21T, 22T, 23T, 24T, 25T, 26T, 27T, 28T, 29T, 30T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'8', N'31T', N'40T', N'31T, 32T, 33T, 34T, 35T, 36T, 37T, 38T, 39T, 40T')
INSERT [dbo].[Tram Lines] ([line_num], [starting_station_id], [destination_station_id], [route]) VALUES (N'9', N'41T', N'50T', N'41T, 42T, 43T, 44T, 45T, 46T, 47T, 48T, 49T, 50T')
GO
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (1, N'1', N'T124', CAST(N'06:45:00' AS Time), 50)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (2, N'2', N'T284', CAST(N'08:00:00' AS Time), 40)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (3, N'3', N'T346', CAST(N'09:15:00' AS Time), 55)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (4, N'4', N'T351', CAST(N'10:30:00' AS Time), 45)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (5, N'5', N'T601', CAST(N'11:45:00' AS Time), 60)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (6, N'1', N'T124', CAST(N'13:00:00' AS Time), 35)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (7, N'7', N'T425', CAST(N'14:15:00' AS Time), 50)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (8, N'8', N'T502', CAST(N'15:30:00' AS Time), 40)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (9, N'2', N'T284', CAST(N'16:45:00' AS Time), 55)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (10, N'10', N'T725', CAST(N'18:00:00' AS Time), 30)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (11, N'11', N'T867', CAST(N'19:15:00' AS Time), 45)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (12, N'12', N'T733', CAST(N'20:30:00' AS Time), 40)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (13, N'7', N'T425', CAST(N'21:45:00' AS Time), 65)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (14, N'14', N'T867', CAST(N'23:00:00' AS Time), 50)
INSERT [dbo].[Tram Schedule] ([service_id], [line_num], [tram_num], [start_time], [duration]) VALUES (15, N'15', N'T912', CAST(N'00:15:00' AS Time), 55)
GO
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'10T', N'Stradom', CAST(50.05556 AS Decimal(9, 5)), CAST(19.97222 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'11T', N'Kazimierz', CAST(50.06806 AS Decimal(9, 5)), CAST(19.98583 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'12T', N'Pilsudskiego', CAST(50.07861 AS Decimal(9, 5)), CAST(19.99083 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'13T', N'Galeria Kazimierz', CAST(50.09139 AS Decimal(9, 5)), CAST(19.99278 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'14T', N'Krakow Plaza', CAST(50.09639 AS Decimal(9, 5)), CAST(19.98500 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'15T', N'Uniwersytet Jagiellonski', CAST(50.10278 AS Decimal(9, 5)), CAST(19.97500 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'16T', N'Mistrzejowice', CAST(50.10833 AS Decimal(9, 5)), CAST(19.96250 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'17T', N'Bronowice', CAST(50.11417 AS Decimal(9, 5)), CAST(19.95278 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'18T', N'Salwator', CAST(50.11833 AS Decimal(9, 5)), CAST(19.94472 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'19T', N'Kosciuszki Avenue', CAST(50.12361 AS Decimal(9, 5)), CAST(19.93750 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'1T', N'Plac Centralny', CAST(50.06194 AS Decimal(9, 5)), CAST(19.93611 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'20T', N'Cmentarz Rakowicki', CAST(50.12917 AS Decimal(9, 5)), CAST(19.93194 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'21T', N'Osiedle Piastów', CAST(50.13750 AS Decimal(9, 5)), CAST(19.92472 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'22T', N'Osiedle Kolorowe', CAST(50.14444 AS Decimal(9, 5)), CAST(19.91944 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'23T', N'Bronowice Male', CAST(50.15111 AS Decimal(9, 5)), CAST(19.91417 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'24T', N'Osiedle Oficerskie', CAST(50.15806 AS Decimal(9, 5)), CAST(19.90972 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'25T', N'Bronowice Wielkie', CAST(50.16500 AS Decimal(9, 5)), CAST(19.90556 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'26T', N'Osiedle Piastów', CAST(50.17194 AS Decimal(9, 5)), CAST(19.90139 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'27T', N'Krowodrza Górka', CAST(50.17889 AS Decimal(9, 5)), CAST(19.89722 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'28T', N'Lagiewniki', CAST(50.18583 AS Decimal(9, 5)), CAST(19.89306 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'29T', N'Prokocim', CAST(50.19278 AS Decimal(9, 5)), CAST(19.88889 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'2T', N'Nowa Huta', CAST(50.07222 AS Decimal(9, 5)), CAST(19.97778 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'30T', N'Biezanów', CAST(50.19972 AS Decimal(9, 5)), CAST(19.88472 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'31T', N'Lagiewniki', CAST(50.20667 AS Decimal(9, 5)), CAST(19.88056 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'32T', N'Zlocien', CAST(50.21361 AS Decimal(9, 5)), CAST(19.87639 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'33T', N'Kurdwanów', CAST(50.22056 AS Decimal(9, 5)), CAST(19.87222 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'34T', N'Kobierzyn', CAST(50.22750 AS Decimal(9, 5)), CAST(19.86806 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'35T', N'Kliny Zacisze', CAST(50.23444 AS Decimal(9, 5)), CAST(19.86389 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'36T', N'Zarzecze', CAST(50.24139 AS Decimal(9, 5)), CAST(19.85972 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'37T', N'Nowa Huta', CAST(50.24833 AS Decimal(9, 5)), CAST(19.85556 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'38T', N'Kurdwanów Nowy', CAST(50.25528 AS Decimal(9, 5)), CAST(19.85139 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'39T', N'Cichy Kacik', CAST(50.26222 AS Decimal(9, 5)), CAST(19.84722 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'3T', N'Rondo Grunwaldzkie', CAST(50.08333 AS Decimal(9, 5)), CAST(19.92222 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'40T', N'Osiedle Pólwsie', CAST(50.26917 AS Decimal(9, 5)), CAST(19.84306 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'41T', N'Ruczaj', CAST(50.27611 AS Decimal(9, 5)), CAST(19.83889 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'42T', N'Dabie', CAST(50.28306 AS Decimal(9, 5)), CAST(19.83472 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'43T', N'Witkowice', CAST(50.29000 AS Decimal(9, 5)), CAST(19.83056 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'44T', N'Borek Falecki', CAST(50.29694 AS Decimal(9, 5)), CAST(19.82639 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'45T', N'Zakopianka', CAST(50.30389 AS Decimal(9, 5)), CAST(19.82222 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'46T', N'Wzgórza Krzeslawickie', CAST(50.31083 AS Decimal(9, 5)), CAST(19.81806 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'47T', N'Lagiewniki Kosciól', CAST(50.31778 AS Decimal(9, 5)), CAST(19.81389 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'48T', N'Wawrzonki', CAST(50.32472 AS Decimal(9, 5)), CAST(19.80972 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'49T', N'Dab Wielki', CAST(50.33167 AS Decimal(9, 5)), CAST(19.80556 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'4T', N'Pilsudskiego', CAST(50.07500 AS Decimal(9, 5)), CAST(19.93611 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'50T', N'Giebultów', CAST(50.33861 AS Decimal(9, 5)), CAST(19.80139 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'5T', N'Starowislna', CAST(50.06528 AS Decimal(9, 5)), CAST(19.95139 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'6T', N'Dworzec Glówny', CAST(50.07361 AS Decimal(9, 5)), CAST(19.93972 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'7T', N'Wawel', CAST(50.08194 AS Decimal(9, 5)), CAST(19.95417 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'8T', N'Kopiec Kosciuszki', CAST(50.07083 AS Decimal(9, 5)), CAST(19.95972 AS Decimal(9, 5)))
INSERT [dbo].[Tram Stops] ([stop_id], [stop_name], [stop_latitude], [stop_longtitude]) VALUES (N'9T', N'Zablocie', CAST(50.06528 AS Decimal(9, 5)), CAST(19.96667 AS Decimal(9, 5)))
GO
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (1, N'Autosan')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (2, N'Mercedes-Benz')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (3, N'MAN')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (4, N'Solaris')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (5, N'Konstal')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (6, N'Duwag')
INSERT [dbo].[Vehicle Brands] ([brand_id], [brand_name]) VALUES (7, N'Bombardier')
GO
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (1, 1, N'Sancity 18LF LNG')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (2, 2, N'Conecto LF')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (3, 2, N'Conecto LF G')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (4, 3, N'Lion’s City G')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (5, 3, N'Lion’s City G CNG')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (6, 3, N'Lion’s City CNG')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (7, 4, N'Urbino 10 III')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (8, 4, N'Urbino 12 IV Electric')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (9, 4, N'Urbino 18 IV FL Electric')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (10, 5, N'105Na')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (11, 6, N'E1')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (12, 6, N'N8C-NF')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (13, 6, N'N8S')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (14, 7, N'NGT6')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (15, 7, N'NGT6/2')
INSERT [dbo].[Vehicle Models] ([model_id], [brand_id], [model_name]) VALUES (16, 7, N'NGT8')
GO
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'1', N'165', N'Engine Repair', 1500.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'10', N'585', N'Bodywork Repair', 1600.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'11', N'585', N'Tire Replacement', 550.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'12', N'316', N'Engine Repair', 1400.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'13', N'585', N'Collision Repair', 2500.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'14', N'316', N'Brake System Repair', 800.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'15', N'316', N'Engine Repair', 1100.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'16', N'T124', N'Electrical System Repair', 1200.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'17', N'T124', N'Transmission Repair', 1400.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'18', N'T193', N'Bodywork Repair', 1700.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'19', N'T639', N'Engine Repair', 1300.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'2', N'165', N'Bodywork Repair', 2000.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'20', N'T867', N'Battery Replacement', 600.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'3', N'657', N'Engine Repair', 1200.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'4', N'657', N'Tire Replacement', 500.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'5', N'657', N'Bodywork Repair', 1800.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'6', N'607', N'Brake System Repair', 900.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'7', N'165', N'Fuel System Repair', 700.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'8', N'607', N'Electrical System Repair', 1000.0000)
INSERT [dbo].[Vehicle Repairs] ([repair_id], [vehicle_num], [repair_type], [repair_cost]) VALUES (N'9', N'657', N'Transmission Repair', 1300.0000)
GO
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'165', N'WI56789', N'BUS', 3, 3)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'193', N'WL12345', N'BUS', 2, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'253', N'WC23456', N'BUS', 2, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'316', N'WT56789', N'BUS', 4, 3)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'327', N'WE34567', N'BUS', 2, 2)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'351', N'WN23456', N'BUS', 3, 3)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'366', N'WH90123', N'BUS', 3, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'403', N'WA12345', N'BUS', 1, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'564', N'WD78901', N'BUS', 4, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'585', N'WB67890', N'BUS', 2, 2)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'607', N'WQ89012', N'BUS', 2, 2)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'626', N'WG45678', N'BUS', 4, 3)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'657', N'WM67890', N'BUS', 3, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'725', N'WO78901', N'BUS', 4, 2)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'733', N'WF89012', N'BUS', 2, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'824', N'WK56789', N'BUS', 1, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'830', N'WJ01234', N'BUS', 3, 2)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'865', N'WS90123', N'BUS', 4, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'867', N'WP34567', N'BUS', 2, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'945', N'WR45678', N'BUS', 2, 1)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T124', NULL, N'TRAM', 5, 10)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T152', NULL, N'TRAM', 6, 12)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T193', NULL, N'TRAM', 7, 14)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T198', NULL, N'TRAM', 6, 11)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T284', NULL, N'TRAM', 7, 15)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T346', NULL, N'TRAM', 7, 16)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T351', NULL, N'TRAM', 5, 10)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T425', NULL, N'TRAM', 6, 12)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T502', NULL, N'TRAM', 7, 14)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T543', NULL, N'TRAM', 7, 16)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T601', NULL, N'TRAM', 6, 11)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T639', NULL, N'TRAM', 6, 12)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T657', NULL, N'TRAM', 5, 10)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T725', NULL, N'TRAM', 6, 11)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T733', NULL, N'TRAM', 7, 15)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T789', NULL, N'TRAM', 6, 13)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T824', NULL, N'TRAM', 6, 13)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T867', NULL, N'TRAM', 7, 14)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T890', NULL, N'TRAM', 6, 12)
INSERT [dbo].[Vehicles] ([vehicle_num], [reg_num], [vehicle_type], [brand_id], [model_id]) VALUES (N'T912', NULL, N'TRAM', 7, 16)
GO
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (1, N'165', N'Accident', 1)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (2, N'165', N'Mechanical Failure', 2)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (3, N'253', N'Traffic Violation', 1)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (4, N'253', N'Collision', 4)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (5, N'253', N'Accident', 3)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (6, N'253', N'Mechanical Failure', 6)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (7, N'366', N'Traffic Violation', 7)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (8, N'403', N'Collision', 8)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (9, N'564', N'Accident', 9)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (10, N'585', N'Mechanical Failure', 10)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (11, N'607', N'Traffic Violation', 11)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (12, N'626', N'Collision', 12)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (13, N'657', N'Accident', 13)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (14, N'725', N'Mechanical Failure', 14)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (15, N'733', N'Traffic Violation', 15)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (16, N'824', N'Collision', 16)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (17, N'830', N'Accident', 17)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (18, N'865', N'Mechanical Failure', 18)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (19, N'865', N'Traffic Violation', 19)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (20, N'945', N'Collision', 20)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (21, N'T124', N'Accident', 21)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (22, N'T152', N'Mechanical Failure', 3)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (23, N'T124', N'Traffic Violation', 23)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (24, N'T198', N'Collision', 24)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (25, N'T284', N'Accident', 4)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (26, N'T346', N'Mechanical Failure', 10)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (27, N'T346', N'Traffic Violation', 17)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (28, N'T425', N'Collision', 28)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (29, N'T502', N'Accident', 29)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (30, N'T543', N'Mechanical Failure', 30)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (31, N'T601', N'Traffic Violation', 31)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (32, N'T639', N'Collision', 32)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (33, N'T657', N'Accident', 33)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (34, N'T725', N'Mechanical Failure', 34)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (35, N'T733', N'Traffic Violation', 35)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (36, N'T789', N'Collision', 36)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (37, N'T824', N'Accident', 37)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (38, N'T867', N'Mechanical Failure', 38)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (39, N'T890', N'Traffic Violation', 39)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (40, N'T912', N'Collision', 40)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (41, N'165', N'Accident', 41)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (42, N'193', N'Mechanical Failure', 42)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (43, N'253', N'Traffic Violation', 43)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (44, N'316', N'Collision', 44)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (45, N'327', N'Accident', 45)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (46, N'351', N'Mechanical Failure', 46)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (47, N'366', N'Traffic Violation', 47)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (48, N'403', N'Collision', 11)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (49, N'564', N'Accident', 9)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (50, N'585', N'Mechanical Failure', 20)
INSERT [dbo].[Vehicles Incidents] ([entry_id], [vehicle_num], [incident_type], [driver_id]) VALUES (51, N'165', N'awaria silnika', 2)
GO
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (1, 1, CAST(N'2024-01-05' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (2, 2, CAST(N'2024-01-05' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (3, 3, CAST(N'2024-01-05' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (4, 4, CAST(N'2024-01-05' AS Date), CAST(N'11:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (5, 5, CAST(N'2024-01-06' AS Date), CAST(N'12:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (6, 6, CAST(N'2024-01-06' AS Date), CAST(N'13:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (7, 7, CAST(N'2024-01-06' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (8, 8, CAST(N'2024-01-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (9, 9, CAST(N'2024-01-07' AS Date), CAST(N'16:00:00' AS Time), CAST(N'00:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (10, 1, CAST(N'2024-01-07' AS Date), CAST(N'17:00:00' AS Time), CAST(N'01:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (11, 1, CAST(N'2024-01-08' AS Date), CAST(N'18:00:00' AS Time), CAST(N'02:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (12, 2, CAST(N'2024-01-16' AS Date), CAST(N'19:00:00' AS Time), CAST(N'03:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (13, 13, CAST(N'2024-01-17' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (14, 14, CAST(N'2024-01-18' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (15, 15, CAST(N'2024-01-19' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (16, 16, CAST(N'2024-01-20' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (17, 17, CAST(N'2024-01-21' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (18, 18, CAST(N'2024-01-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (19, 19, CAST(N'2024-01-23' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (20, 20, CAST(N'2024-01-24' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (21, 21, CAST(N'2024-01-25' AS Date), CAST(N'04:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (22, 22, CAST(N'2024-01-26' AS Date), CAST(N'05:00:00' AS Time), CAST(N'13:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (23, 23, CAST(N'2024-01-27' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (24, 24, CAST(N'2024-01-28' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (25, 25, CAST(N'2024-01-29' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (26, 26, CAST(N'2024-01-30' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (27, 27, CAST(N'2024-01-31' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (28, 28, CAST(N'2024-02-01' AS Date), CAST(N'11:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (29, 29, CAST(N'2024-02-02' AS Date), CAST(N'12:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (30, 30, CAST(N'2024-02-03' AS Date), CAST(N'13:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (31, 31, CAST(N'2024-02-04' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (32, 32, CAST(N'2024-02-05' AS Date), CAST(N'15:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (33, 33, CAST(N'2024-02-06' AS Date), CAST(N'16:00:00' AS Time), CAST(N'00:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (34, 14, CAST(N'2024-02-18' AS Date), CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (35, 15, CAST(N'2024-02-19' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (36, 16, CAST(N'2024-02-20' AS Date), CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (37, 17, CAST(N'2024-02-21' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (38, 18, CAST(N'2024-02-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (39, 19, CAST(N'2024-02-23' AS Date), CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Work Shifts] ([entry_id], [driver_id], [shift_date], [start_time], [finish_time]) VALUES (40, 20, CAST(N'2024-02-24' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
GO
ALTER TABLE [dbo].[Bus Departures]  WITH CHECK ADD  CONSTRAINT [FK_Bus Departures_Bus Stops] FOREIGN KEY([stop_id])
REFERENCES [dbo].[Bus Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Bus Departures] CHECK CONSTRAINT [FK_Bus Departures_Bus Stops]
GO
ALTER TABLE [dbo].[Bus Departures]  WITH CHECK ADD  CONSTRAINT [FK_Departures_Bus Lines] FOREIGN KEY([line_num])
REFERENCES [dbo].[Bus Lines] ([line_num])
GO
ALTER TABLE [dbo].[Bus Departures] CHECK CONSTRAINT [FK_Departures_Bus Lines]
GO
ALTER TABLE [dbo].[Bus Lines]  WITH CHECK ADD  CONSTRAINT [FK_Bus Lines_Bus Stops] FOREIGN KEY([starting_station_id])
REFERENCES [dbo].[Bus Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Bus Lines] CHECK CONSTRAINT [FK_Bus Lines_Bus Stops]
GO
ALTER TABLE [dbo].[Bus Lines]  WITH CHECK ADD  CONSTRAINT [FK_Bus Lines_Bus Stops1] FOREIGN KEY([destination_station_id])
REFERENCES [dbo].[Bus Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Bus Lines] CHECK CONSTRAINT [FK_Bus Lines_Bus Stops1]
GO
ALTER TABLE [dbo].[Bus Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Bus Services_Bus Lines1] FOREIGN KEY([line_num])
REFERENCES [dbo].[Bus Lines] ([line_num])
GO
ALTER TABLE [dbo].[Bus Schedule] CHECK CONSTRAINT [FK_Bus Services_Bus Lines1]
GO
ALTER TABLE [dbo].[Bus Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Bus Services_Vehicles] FOREIGN KEY([bus_num])
REFERENCES [dbo].[Vehicles] ([vehicle_num])
GO
ALTER TABLE [dbo].[Bus Schedule] CHECK CONSTRAINT [FK_Bus Services_Vehicles]
GO
ALTER TABLE [dbo].[LoginDriver]  WITH CHECK ADD  CONSTRAINT [FK_LoginDriver_Drivers] FOREIGN KEY([driver_id])
REFERENCES [dbo].[Drivers] ([driver_id])
GO
ALTER TABLE [dbo].[LoginDriver] CHECK CONSTRAINT [FK_LoginDriver_Drivers]
GO
ALTER TABLE [dbo].[LoginManagement]  WITH CHECK ADD  CONSTRAINT [FK_LoginManagement_Managers] FOREIGN KEY([manager_id])
REFERENCES [dbo].[Managers] ([manager_id])
GO
ALTER TABLE [dbo].[LoginManagement] CHECK CONSTRAINT [FK_LoginManagement_Managers]
GO
ALTER TABLE [dbo].[Tram Departures]  WITH CHECK ADD  CONSTRAINT [FK_Tram Departures_Tram Lines] FOREIGN KEY([line_num])
REFERENCES [dbo].[Tram Lines] ([line_num])
GO
ALTER TABLE [dbo].[Tram Departures] CHECK CONSTRAINT [FK_Tram Departures_Tram Lines]
GO
ALTER TABLE [dbo].[Tram Departures]  WITH CHECK ADD  CONSTRAINT [FK_Tram Departures_Tram Stops] FOREIGN KEY([stop_id])
REFERENCES [dbo].[Tram Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Tram Departures] CHECK CONSTRAINT [FK_Tram Departures_Tram Stops]
GO
ALTER TABLE [dbo].[Tram Lines]  WITH CHECK ADD  CONSTRAINT [FK_Tram Lines_Tram Stops] FOREIGN KEY([starting_station_id])
REFERENCES [dbo].[Tram Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Tram Lines] CHECK CONSTRAINT [FK_Tram Lines_Tram Stops]
GO
ALTER TABLE [dbo].[Tram Lines]  WITH CHECK ADD  CONSTRAINT [FK_Tram Lines_Tram Stops1] FOREIGN KEY([destination_station_id])
REFERENCES [dbo].[Tram Stops] ([stop_id])
GO
ALTER TABLE [dbo].[Tram Lines] CHECK CONSTRAINT [FK_Tram Lines_Tram Stops1]
GO
ALTER TABLE [dbo].[Tram Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Tram Services_Tram Lines] FOREIGN KEY([line_num])
REFERENCES [dbo].[Tram Lines] ([line_num])
GO
ALTER TABLE [dbo].[Tram Schedule] CHECK CONSTRAINT [FK_Tram Services_Tram Lines]
GO
ALTER TABLE [dbo].[Tram Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Tram Services_Vehicles] FOREIGN KEY([tram_num])
REFERENCES [dbo].[Vehicles] ([vehicle_num])
GO
ALTER TABLE [dbo].[Tram Schedule] CHECK CONSTRAINT [FK_Tram Services_Vehicles]
GO
ALTER TABLE [dbo].[Vehicle Models]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle Models_Vehicle Brands] FOREIGN KEY([brand_id])
REFERENCES [dbo].[Vehicle Brands] ([brand_id])
GO
ALTER TABLE [dbo].[Vehicle Models] CHECK CONSTRAINT [FK_Vehicle Models_Vehicle Brands]
GO
ALTER TABLE [dbo].[Vehicle Repairs]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle Repairs_Vehicles] FOREIGN KEY([vehicle_num])
REFERENCES [dbo].[Vehicles] ([vehicle_num])
GO
ALTER TABLE [dbo].[Vehicle Repairs] CHECK CONSTRAINT [FK_Vehicle Repairs_Vehicles]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Vehicle Brands] FOREIGN KEY([brand_id])
REFERENCES [dbo].[Vehicle Brands] ([brand_id])
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_Vehicle Brands]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Vehicle Models] FOREIGN KEY([model_id])
REFERENCES [dbo].[Vehicle Models] ([model_id])
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_Vehicle Models]
GO
ALTER TABLE [dbo].[Vehicles Incidents]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles Incidents_Drivers] FOREIGN KEY([driver_id])
REFERENCES [dbo].[Drivers] ([driver_id])
GO
ALTER TABLE [dbo].[Vehicles Incidents] CHECK CONSTRAINT [FK_Vehicles Incidents_Drivers]
GO
ALTER TABLE [dbo].[Vehicles Incidents]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Incidents_Vehicles] FOREIGN KEY([vehicle_num])
REFERENCES [dbo].[Vehicles] ([vehicle_num])
GO
ALTER TABLE [dbo].[Vehicles Incidents] CHECK CONSTRAINT [FK_Vehicles_Incidents_Vehicles]
GO
ALTER TABLE [dbo].[Work Shifts]  WITH CHECK ADD  CONSTRAINT [FK_Work Shifts_Drivers] FOREIGN KEY([driver_id])
REFERENCES [dbo].[Drivers] ([driver_id])
GO
ALTER TABLE [dbo].[Work Shifts] CHECK CONSTRAINT [FK_Work Shifts_Drivers]
GO
USE [master]
GO
ALTER DATABASE [Transport_miejski] SET  READ_WRITE 
GO
