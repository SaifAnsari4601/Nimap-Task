USE [master]
GO
/****** Object:  Database [db_nimap]    Script Date: 03-Apr-23 10:42:58 AM ******/
CREATE DATABASE [db_nimap]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_nimap', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\db_nimap.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_nimap_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\db_nimap_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db_nimap] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_nimap].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_nimap] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_nimap] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_nimap] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_nimap] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_nimap] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_nimap] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db_nimap] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_nimap] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_nimap] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_nimap] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_nimap] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_nimap] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_nimap] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_nimap] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_nimap] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_nimap] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_nimap] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_nimap] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_nimap] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_nimap] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_nimap] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_nimap] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_nimap] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_nimap] SET  MULTI_USER 
GO
ALTER DATABASE [db_nimap] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_nimap] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_nimap] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_nimap] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db_nimap]
GO
/****** Object:  Table [dbo].[tbl_category]    Script Date: 03-Apr-23 10:42:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cname] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_product]    Script Date: 03-Apr-23 10:42:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pname] [varchar](100) NULL,
	[cid] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([cid])
REFERENCES [dbo].[tbl_category] ([id])
GO
/****** Object:  StoredProcedure [dbo].[sp_category]    Script Date: 03-Apr-23 10:42:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_category]
@action int=0,
@id int=0,
@cname varchar(100)=null
as
begin
if(@action=1)
 begin
 insert into tbl_category values(@cname)
 select 'Data Inserted Successfully...'
 end
if(@action=2)
 begin
 select * from tbl_category order by id desc
 end
if(@action=3)
 begin
 delete from tbl_category where id = @id
 select 'Data Daleted Successfully...'
 end
if(@action=4)
 begin
 update tbl_category set cname=@cname where id =@id
 select 'Data Updated Successfully...'
 end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_product]    Script Date: 03-Apr-23 10:42:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_product]
@action int=0,
@id int=0,
@pname varchar(100)=null,
@cid int=0
as
begin
if(@action=1)
 begin
 insert into tbl_product values(@pname,@cid)
 select 'Data Inserted Successfully...'
 end
if(@action=2)
 begin
 select p.id,p.pname,p.cid,c.cname from tbl_product as p left join tbl_category as c on c.id=p.cid
 end
if(@action=3)
 begin
 delete from tbl_product where id = @id
 select 'Data Daleted Successfully...'
 end
if(@action=4)
 begin
 update tbl_product set pname=@pname,cid=@cid where id =@id
 select 'Data Updated Successfully...'
 end
end
GO
USE [master]
GO
ALTER DATABASE [db_nimap] SET  READ_WRITE 
GO
